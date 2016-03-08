//
//  NSException+CDInvocation.h
//  CrutchKitExample
//
//  Created by Vadim Smal on 2/13/16.
//  Copyright © 2016 cognitivedisson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSException (CDInvocation)

+ (instancetype)cd_expectExceptionWithInvocation:(NSInvocation *)invocation;

+ (instancetype)cd_rejectExceptionWithInvocation:(NSInvocation *)invocation;

@end
