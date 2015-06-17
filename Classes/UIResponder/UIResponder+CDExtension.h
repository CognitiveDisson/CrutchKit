//
//  UIResponder+CDExtension.h
//  CrutchKitExample
//
//  Created by Smal Vadim on 07/06/15.
//  Copyright (c) 2015 cognitivedisson. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CDProxy;

@interface UIResponder (CDExtension)

@property (strong, nonatomic) id<CDProxy> proxy;

- (NSArray *)cd_responderChain;

@end
