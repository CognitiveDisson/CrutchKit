//
//  UIResponder+CDExtension.m
//  CrutchKitExample
//
//  Created by Smal Vadim on 07/06/15.
//  Copyright (c) 2015 cognitivedisson. All rights reserved.
//

#import "UIResponder+CDExtension.h"
#import <objc/runtime.h>

@implementation UIResponder (CDExtension)

@dynamic proxy;

- (id <CDProxy>)proxy {
    return objc_getAssociatedObject(self, @selector(proxy));
}

- (void)setProxy:(id <CDProxy>)proxy {
    objc_setAssociatedObject(self, @selector(proxy), proxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)cd_responderChain {
    UIResponder *responder = self;
    NSMutableArray *responders = [NSMutableArray arrayWithObject:responder];
    while ((responder = [responder nextResponder]) != nil) {
        [responders addObject:responder];
    }
    return responders;
}

@end
