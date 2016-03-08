//
//  CDProxyDefinition.m
//  Pods
//
//  Created by Smal Vadim on 15/12/15.
//
//

#import "CDProxyDefinition.h"
#import "CDObserver.h"
#import "CDProtocol.h"

@interface CDProxyDefinition ()

@property (strong, nonatomic, readwrite) NSHashTable *observers;
@property (strong, nonatomic, readwrite) NSArray *protocols;
@property (strong, nonatomic, readwrite) NSArray *selectors;

@end

@implementation CDProxyDefinition

- (instancetype)initWithProtocols:(NSArray *)protocols
                        selectors:(NSArray *)selectors
                        observers:(NSArray *)observers {
    
    self = [super init];
    
    if (self) {
        
        _protocols = protocols;
        
        _selectors = selectors;
        
        _observers = [NSHashTable hashTableWithOptions:NSPointerFunctionsWeakMemory];
        
        for (id observer in observers) {
            
            [self addObserver:observer];
            
        }
        
    }
    
    return self;
}

+ (instancetype)definitionWithProtocols:(NSArray *)protocols {
    return [[self alloc] initWithProtocols:protocols
                                 selectors:nil
                                 observers:nil];
}

+ (instancetype)definitionWithProtocols:(NSArray *)protocols
                              observers:(NSArray *)observers {
    return [[self alloc] initWithProtocols:protocols
                                 selectors:nil
                                 observers:observers];
}

+ (instancetype)definitionWithProtocols:(NSArray *)protocols
                              selectors:(NSArray *)selectors
                              observers:(NSArray *)observers {
    return [[self alloc] initWithProtocols:protocols
                                 selectors:selectors
                                 observers:observers];
}

+ (instancetype)definitionWithSelector:(SEL)selector {
    return [[self alloc] initWithProtocols:nil
                                 selectors:@[NSStringFromSelector(selector)]
                                 observers:nil];
}

+ (instancetype)definitionWithSelectors:(NSArray *)selectors {
    return [[self alloc] initWithProtocols:nil
                                 selectors:selectors
                                 observers:nil];
}

- (NSArray *)proxyObservers {
    return [_observers allObjects];
}

- (NSArray *)proxyProtocols {
    return [_protocols copy];
}

- (NSArray *)proxySelectors {
    return [_selectors copy];
}

- (void)addObserver:(id<CDObserver>)observer {
    
    @synchronized(self) {
        
        for (Protocol *protocol in self.protocols) {
            if ([observer conformsToProtocol:protocol]) {
                [_observers addObject:observer];
                return;
            }
        }
        
        for (NSString *selector in self.selectors) {
            if ([observer respondsToSelector:NSSelectorFromString(selector)]) {
                [_observers addObject:observer];
                return;
            }
        }
        
        [NSException raise:NSInvalidArgumentException
                    format:@"Observer %@ not conform to any protocol %@ or selector %@", observer, self.proxyProtocols, self.selectors];
    
    }
    
}

- (void)removeObserver:(id)observer {
    
    @synchronized(self) {
        
        [_observers removeObject:observer];
        
    }
    
}

@end
