//
//  CDInvocationHandler.m
//  CrutchKitExample
//
//  Created by Vadim Smal on 2/13/16.
//  Copyright © 2016 cognitivedisson. All rights reserved.
//

#import "CDInvocationHandler.h"
#import "CDInvocationRecorder.h"
#import "CDInvocationContainer.h"
#import "NSMethodSignature+CDInvocation.h"
#import "NSException+CDInvocation.h"
#import <objc/runtime.h>

@interface CDInvocationHandler ()

@property (strong, nonatomic) Protocol *protocol;
@property (strong, nonatomic) NSArray *selectors;

@property (strong, nonatomic) CDInvocationRecorder *recorder;
@property (strong, nonatomic) CDInvocationRecorder *expectRecorder;
@property (strong, nonatomic) CDInvocationRecorder *rejectRecorder;

@end

@implementation CDInvocationHandler

- (instancetype)initWithProtocol:(Protocol *)protocol {
    self = [super init];
    if (self) {
        _protocol = protocol;
        _recorder = [[CDInvocationRecorder alloc] initWithProtocol:_protocol];
        _expectRecorder = [[CDInvocationRecorder alloc] initWithProtocol:_protocol];
        _rejectRecorder = [[CDInvocationRecorder alloc] initWithProtocol:_protocol];
    }
    return self;
}

- (instancetype)initWithProtocol:(Protocol *)protocol
                       selectors:(NSArray *)selectors {
    self = [self initWithProtocol:protocol];
    if (self) {
        _selectors = selectors;
    }
    return self;
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol {
    return YES;
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    
    if (self.selectors) {
        NSString *selector = NSStringFromSelector(aSelector);
        return [self.selectors containsObject:selector];
    }
    
    static BOOL isReqVals[4] = {NO, NO, YES, YES};
    static BOOL isInstanceVals[4] = {NO, YES, NO, YES};
    struct objc_method_description methodDescription = {NULL, NULL};
    
    for(int i = 0; i < 4; i++) {
        methodDescription = protocol_getMethodDescription(self.protocol,
                                                          aSelector,
                                                          isReqVals[i],
                                                          isInstanceVals[i]);
        
        if(methodDescription.types != NULL && methodDescription.name != NULL){
            return YES;
        }
    }
    
    return NO;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    NSMethodSignature *signature = [super methodSignatureForSelector:selector];
    if (!signature) {
        signature = [NSMethodSignature cd_signatureWithProtocol:self.protocol
                                                       selector:selector];
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    return [self.recorder forwardInvocation:invocation];
}

- (id)expect {
    return self.expectRecorder;
}

- (id)verify {
    return self.expectRecorder;
}

- (id)reject {
    return self.rejectRecorder;
}

- (void)performVerification {
    NSMutableArray *expectedInvocations = [self.expectRecorder invocationContainers];
    NSMutableArray *recordedInvocations = [[self.recorder invocationContainers] mutableCopy];
    NSMutableArray *rejectedInvocations = [self.rejectRecorder invocationContainers];
    for (CDInvocationContainer *invocation in recordedInvocations) {
        if ([expectedInvocations containsObject:invocation]) {
            [self.expectRecorder.invocationContainers removeObject:invocation];
            [self.recorder.invocationContainers removeObject:invocation];
        } else {
            @throw([NSException cd_expectExceptionWithInvocation:invocation.invocation]);
        }
        if ([rejectedInvocations containsObject:invocation]) {
            @throw([NSException cd_rejectExceptionWithInvocation:invocation.invocation]);
        }
    }
    for (CDInvocationContainer *invocation in expectedInvocations) {
        @throw([NSException cd_rejectExceptionWithInvocation:invocation.invocation]);
    }
}

@end
