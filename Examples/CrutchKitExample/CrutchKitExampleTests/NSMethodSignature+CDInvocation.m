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
    
    // checking all methods of a protocol (class methods, instance methods, optional methods, required methods)
    struct { BOOL isRequired; BOOL isInstance; } opts[4] = { {YES, YES}, {NO, YES}, {YES, NO}, {NO, NO} };
    for(int i = 0; i < 4; i++)
    {
        struct objc_method_description methodDescription = protocol_getMethodDescription(protocol,
                                                                                         selector,
                                                                                         opts[i].isRequired,
                                                                                         opts[i].isInstance);
        if (methodDescription.name != NULL) {
            return [NSMethodSignature signatureWithObjCTypes:methodDescription.types];
        }
    }
    return nil;
}

@end
