//
//  CDInvocationRecorder.m
//  CrutchKitExample
//
//  Created by Smal Vadim on 15/12/15.
//  Copyright © 2015 cognitivedisson. All rights reserved.
//

#import "CDInvocationRecorder.h"
#import "NSMethodSignature+CDInvocation.h"
#import "CDInvocationContainer.h"

@interface CDInvocationRecorder ()

@property (strong, nonatomic) Protocol *protocol;
@property (strong, nonatomic, readwrite) NSMutableArray *invocationContainers;

@end

@implementation CDInvocationRecorder

- (instancetype)initWithProtocol:(Protocol *)protocol {
    _protocol = protocol;
    _invocationContainers = [NSMutableArray new];
    return self;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    return [NSMethodSignature cd_signatureWithProtocol:self.protocol
                                              selector:selector];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    NSMethodSignature *signature = [self methodSignatureForSelector:invocation.selector];
    CDInvocationContainer *container = [[CDInvocationContainer alloc] initWithInvocation:invocation
                                                                         methodSignature:signature];
    [self.invocationContainers addObject:container];
}


@end
