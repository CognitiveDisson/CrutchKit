//
//  NSException+CDInvocation.m
//  CrutchKitExample
//
//  Created by Vadim Smal on 2/13/16.
//  Copyright © 2016 cognitivedisson. All rights reserved.
//

#import "NSException+CDInvocation.h"

static NSString * const CDVerifyExceptionName = @"CDVerifyException";

@implementation NSException (CDInvocation)

+ (instancetype)cd_expectExceptionWithInvocation:(NSInvocation *)invocation {
    NSString *reason = [NSString stringWithFormat:@"Invocation with selector %@ not called", NSStringFromSelector(invocation.selector)];
    return [NSException exceptionWithName:CDVerifyExceptionName reason:reason userInfo:nil];
}

+ (instancetype)cd_rejectExceptionWithInvocation:(NSInvocation *)invocation {
    NSString *reason = [NSString stringWithFormat:@"Rejected invocation with selector %@ was called", NSStringFromSelector(invocation.selector)];
    return [NSException exceptionWithName:CDVerifyExceptionName reason:reason userInfo:nil];
}

@end
