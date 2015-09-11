//
//  UIColor+CDExtension.m
//  CrutchKitExample
//
//  Created by Smal Vadim on 08/06/15.
//  Copyright (c) 2015 cognitivedisson. All rights reserved.
//

#import "UIColor+CDExtension.h"

@implementation UIColor (CDExtension)

+ (instancetype)randomColor {
    CGFloat red = arc4random_uniform(255) / 255.0;
    CGFloat green = arc4random_uniform(255) / 255.0;
    CGFloat blue = arc4random_uniform(255) / 255.0;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
    return color;
}

@end
