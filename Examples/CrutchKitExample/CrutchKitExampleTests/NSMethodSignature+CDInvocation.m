//
//  NSMethodSignature+CDInvocation.m
//  CrutchKitExample
//
//  Created by Vadim Smal on 2/13/16.
//  Copyright © 2016 cognitivedisson. All rights reserved.
//

#import "NSMethodSignature+CDInvocation.h"
#import <objc/runtime.h>

@implementation NSMethodSignature (CDInvocation)

+ (instancetype)cd_signatureWithProtocol:(Protocol *)protocol
                             selector:(SEL)selector {
    struct objc_method_description description = protocol_getMethodDescription(protocol, selector, NO, YES);
    return [NSMethodSignature signatureWithObjCTypes:description.types];
}

@end
