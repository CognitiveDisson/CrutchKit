//
//  CDProxy.h
//  CrutchKitExample
//
//  Created by Smal Vadim on 09/06/15.
//  Copyright (c) 2015 cognitivedisson. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CDProxyDefinition;

@protocol CDProxy <NSObject>

- (BOOL)respondsToSelector:(SEL)selector
              fromProtocol:(Protocol *)protocol
                fromSender:(id)sender;

- (CDProxyDefinition *)definition;

- (BOOL)proxyProtocol:(Protocol *)protocol;

- (BOOL)proxyProtocol:(Protocol *)protocol
             selector:(SEL)selector;

- (BOOL)proxySelector:(SEL)selector;

- (id)unwrap;

@end
