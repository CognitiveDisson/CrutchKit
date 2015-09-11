//
//  UIImage+CDCrop.m
//  CrutchKitExample
//
//  Created by Smal Vadim on 06/06/15.
//  Copyright (c) 2015 cognitivedisson. All rights reserved.
//

#import "UIImage+CDCrop.h"

@implementation UIImage (CDCrop)

- (UIImage *)cd_imageCropped:(CGRect)rect {
    
    CGImageRef imageRef = CGImageCreateWithImageInRect( [self CGImage], rect );
    
    UIImage *image = [UIImage imageWithCGImage:imageRef
                                         scale:1.0f
                                   orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    
    return image;
}

- (UIImage *)cd_imagedCroppedToCircle {
    
    CGFloat minSize = MIN(self.size.width, self.size.height);
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(minSize, minSize), NO, self.scale);
    CGRect roundedRect = CGRectMake(0, 0, minSize, minSize);
    CGFloat cornerRadius = minSize / 2.0f;
    
    [[UIBezierPath bezierPathWithRoundedRect:roundedRect
                                cornerRadius:cornerRadius] addClip];
    
    CGRect drawRect = CGRectMake((self.size.height - self.size.width) / 2.0,
                                 0,
                                 self.size.width,
                                 self.size.height);
    
    if (self.size.height > self.size.width) {
        
        drawRect = CGRectMake(0, (self.size.width - self.size.height) / 2.0, self.size.width, self.size.height);
        
    }
    
    [self drawInRect:drawRect];
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}

@end
