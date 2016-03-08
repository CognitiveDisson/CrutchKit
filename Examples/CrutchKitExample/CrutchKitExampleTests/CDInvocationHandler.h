//
//  CDInvocationHandler.h
//  CrutchKitExample
//
//  Created by Vadim Smal on 2/13/16.
//  Copyright © 2016 cognitivedisson. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CDProtcolHandler(protocol) [[CDInvocationHandler alloc] initWithProtocol:protocol]

@interface CDInvocationHandler : NSObject

- (instancetype)initWithProtocol:(Protocol *)protocol;

- (instancetype)initWithProtocol:(Protocol *)protocol
                       selectors:(NSArray *)selectors;

- (id)expect;

- (id)verify;

- (id)reject;

- (void)performVerification;

@end
