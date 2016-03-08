//
//  CDInvocationContainer.h
//  CrutchKitExample
//
//  Created by Vadim Smal on 2/13/16.
//  Copyright © 2016 cognitivedisson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDInvocationContainer : NSObject

- (instancetype)initWithInvocation:(NSInvocation *)invocation
                   methodSignature:(NSMethodSignature *)signature;

@property (strong, nonatomic, readonly) NSInvocation *invocation;
@property (strong, nonatomic, readonly) NSMethodSignature *signature;
@property (assign, nonatomic, readonly) SEL selector;
@property (strong, nonatomic, readonly) NSArray *arguments;

@end
