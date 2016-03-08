//
//  NSMethodSignature+CDInvocation.h
//  CrutchKitExample
//
//  Created by Vadim Smal on 2/13/16.
//  Copyright © 2016 cognitivedisson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMethodSignature (CDInvocation)

+ (instancetype)cd_signatureWithProtocol:(Protocol *)protocol
                             selector:(SEL)selector;

@end
