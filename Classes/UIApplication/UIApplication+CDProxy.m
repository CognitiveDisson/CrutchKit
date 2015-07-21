//
//  UIApplication+CDProxy.m
//  CrutchKitExample
//
//  Created by Smal Vadim on 07/06/15.
//  Copyright (c) 2015 cognitivedisson. All rights reserved.
//

#import "UIApplication+CDProxy.h"
#import "UIResponder+CDExtension.h"
#import "CDProxy.h"

@implementation UIApplication (CDProxy)

- (id <CDProxy>)observersProxyForProtocol:(Protocol *)protocol
                                       selector:(SEL)selector
                                      forSender:(UIResponder *)sender {
    
    NSArray *responderChain = [sender cd_responderChain];
    
    for (UIResponder *responder in responderChain) {
        
        id<CDProxy> proxy = responder.proxy;
        
        if (proxy && [proxy respondsToSelector:selector fromProtocol:protocol fromSender:sender]) {
            return proxy;
        }
        
    }
    
    return nil;
}

@end
