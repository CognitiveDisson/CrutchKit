//
//  UIImage+CDPainted.m
//  CrutchKitExample
//
//  Created by Smal Vadim on 06/06/15.
//  Copyright (c) 2015 cognitivedisson. All rights reserved.
//

#import "UIImage+CDPainted.h"

@implementation UIImage (CDPainted)

- (UIImage *)cd_imagePaintedInColor:(UIColor *)color {
    
    CGSize imageSize  = self.size;
    CGRect rect = (CGRect){ CGPointZero, imageSize };

    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    [self drawInRect:rect];
    CGContextSetBlendMode(context, kCGBlendModeSourceIn);
    [color setFill];
    CGContextFillRect(context, rect);
    
    UIImage *image  = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)cd_imageWithPaintedRect:(CGRect)paintedRect color:(UIColor *)color {
    
    CGSize imageSize  = self.size;
    CGRect rect = (CGRect){ CGPointZero, imageSize };
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    [self drawInRect:rect];
    CGContextSetBlendMode(context, kCGBlendModeSourceIn);
    [color setFill];
    CGContextFillRect(context, paintedRect);
    
    UIImage *image  = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

@end
