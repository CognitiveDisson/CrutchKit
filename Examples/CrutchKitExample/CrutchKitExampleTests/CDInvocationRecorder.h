//
//  CDInvocationRecorder.h
//  CrutchKitExample
//
//  Created by Smal Vadim on 15/12/15.
//  Copyright © 2015 cognitivedisson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDInvocationRecorder : NSProxy

@property (strong, nonatomic, readonly) NSMutableArray *invocationContainers;

- (instancetype)initWithProtocol:(Protocol *)protocol;

@end
