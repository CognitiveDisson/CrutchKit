//
//  CDObserversProxy.m
//  CrutchKitExample
//
//  Created by Smal Vadim on 07/06/15.
//  Copyright (c) 2015 cognitivedisson. All rights reserved.
//

#import "CDObserversProxy.h"
#import "CDProxyDefinition.h"
#import "CDObserver.h"
#import "CDProtocol.h"
#import "CDSelector.h"
#import "UIApplication+CDProxying.h"
#import <objc/runtime.h>

@interface CDObserversProxy ()

@property (strong, nonatomic) CDProxyDefinition *definition;

@end

@implementation CDObserversProxy

- (instancetype)initWithDefinition:(CDProxyDefinition *)definition {
    
    self = [super init];
    
    if (self) {
        _definition = definition;
    }
    
    return self;
}

- (instancetype)initWithProtocols:(NSArray *)protocols
                        observers:(NSArray *)observers {
    
    CDProxyDefinition *definition = [CDProxyDefinition definitionWithProtocols:protocols
                                                                     observers:observers];
    return [self initWithDefinition:definition];
    
}

- (instancetype)initWithProtocol:(Protocol *)protocol
                       observers:(NSArray *)observers {
    return [self initWithProtocols:@[protocol]
                         observers:observers];
}

+ (instancetype)observersProxyWithDefinition:(CDProxyDefinition *)definition {
    return [[self alloc] initWithDefinition:definition];
}

+ (instancetype)observersProxyWithProtocol:(Protocol *)protocol
                                 observers:(NSArray *)observers {
    
    return [[self alloc] initWithProtocol:protocol
                                observers:observers];
}

+ (instancetype)observersProxyWithProtocols:(NSArray *)protocols
                                  observers:(NSArray *)observers {
    return [[self alloc] initWithProtocols:protocols
                                 observers:observers];
}

+ (instancetype)observersProxyWithProtocols:(NSArray *)protocols
                                  selectors:(NSArray *)selectors
                                  observers:(NSArray *)observers {
    CDProxyDefinition *definition = [CDProxyDefinition definitionWithProtocols:protocols
                                                                     selectors:selectors
                                                                     observers:observers];
    return [[self alloc] initWithDefinition:definition];
}

+ (instancetype)observersProxyForSender:(UIResponder *)sender
                               protocol:(Protocol *)protocol {
    return [[UIApplication sharedApplication] observersProxyForProtocol:protocol
                                                              forSender:sender];
}

- (BOOL)respondsToSelector:(SEL)selector
              fromProtocol:(Protocol *)protocol
                fromSender:(id)sender {
    
    for (Protocol *protocol in [self.definition proxyProtocols]) {
        if ([CDProtocol protocol:protocol isConformsToProtocol:protocol]) {
            NSArray *observers = [self.definition proxyObservers];
            for (id observer in observers) {
                if ([observer respondsToSelector:selector]) {
                    return YES;
                }
            }
        }
    }
    return NO;
}

- (id)unwrap {
    return self;
}

- (CDProxyDefinition *)definition {
    return _definition;
}

- (void)addObserver:(id<CDObserver>)observer {
    [self.definition addObserver:observer];
}

- (void)removeObserver:(id)observer {
    [self.definition removeObserver:observer];
}

- (BOOL)respondsToSelector:(SEL)selector {
    @synchronized(self) {
        
        if ([super respondsToSelector:selector]) {
            return YES;
        }
        
        NSArray *observers = [self.definition proxyObservers];
        for (id observer in observers) {
            if ([observer respondsToSelector:selector]) {
                return YES;
            }
        }
        
        return NO;
        
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    
    @synchronized(self) {
        
        NSArray *observers = [self.definition proxyObservers];
        
        for (id observer in observers) {
            
            if ([observer respondsToSelector:selector]) {
                return [observer methodSignatureForSelector:selector];
            }
            
        }
        
        NSString *reason = [NSString stringWithFormat:@"The observer which respond to %@ has not been found.", NSStringFromSelector(selector)];
        @throw([NSException exceptionWithName:@"CDObserversProxyException" reason:reason userInfo:nil]);
        
        return [super methodSignatureForSelector:@selector(cd_emptySignatureSelector)];
    }
    
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    
    @synchronized(self) {
        
        SEL selector = [invocation selector];
        NSString *stringSelector = NSStringFromSelector(selector);
        
        BOOL isContainSelector = NO;
        
        for (Protocol *protocol in [self.definition proxyProtocols]) {
            if ([CDProtocol protocol:protocol isContainSelector:selector recursively:YES]) {
                isContainSelector = YES;
            }
        }
        
        for (NSString *proxySelector in [self.definition proxySelectors]) {
            if ([proxySelector isEqualToString:stringSelector]) {
                isContainSelector = YES;
            }
        }
        
        if (!isContainSelector) {
            NSLog(@"WARNING : try forward invocation with selector %@ not contained in protocols %@ and selectors %@", NSStringFromSelector(selector), [self.definition proxyProtocols], [self.definition proxySelectors]);
            return;
        }
        
        NSArray *observers = [self.definition proxyObservers];
        
        for (id<CDObserver> observer in observers) {
            
            if ([observer respondsToSelector:[invocation selector]]) {
                
                if ([observer respondsToSelector:@selector(wantObserveSelector:)]) {
                    if (![observer wantObserveSelector:[invocation selector]]) {
                        return;
                    }
                }
                
                [invocation invokeWithTarget:observer];
                
                if (self.definition.onlyFirstRespondedObserver) {
                    return;
                }
                
            }
        }
        
    }
}

- (void)cd_emptySignatureSelector {
    
}

- (BOOL)proxyProtocol:(Protocol *)protocol {
    for (Protocol *proxyProtocol in self.definition.proxyProtocols) {
        if ([CDProtocol protocol:proxyProtocol isConformsToProtocol:protocol]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)proxyProtocol:(Protocol *)protocol
             selector:(SEL)selector {
    for (Protocol *proxyProtocol in self.definition.proxyProtocols) {
        BOOL conformToProtocol = [CDProtocol protocol:proxyProtocol
                                 isConformsToProtocol:protocol];
        BOOL respondToSelector = [self respondsToSelector:selector
                                              fromProtocol:protocol
                                                fromSender:self];
        if (conformToProtocol && respondToSelector) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)proxySelector:(SEL)selector {
    for (Protocol *proxyProtocol in self.definition.proxyProtocols) {
        if ([CDProtocol protocol:proxyProtocol
               isContainSelector:selector
                     recursively:NO]) {
            return YES;
        }
    }
    NSString *stringSelector = NSStringFromSelector(selector);
    for (NSString *proxySelectors in self.definition.proxySelectors) {
        if ([proxySelectors isEqualToString:stringSelector]) {
            return YES;
        }
    }
    return NO;
}

@end
