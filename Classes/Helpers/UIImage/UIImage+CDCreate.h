//
//  UIImage+CDCreate.h
//  CrutchKitExample
//
//  Created by Smal Vadim on 06/06/15.
//  Copyright (c) 2015 cognitivedisson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CDCreate)

+ (instancetype)cd_clearImageWithSize:(CGSize)size;

+ (instancetype)cd_imageWithSize:(CGSize)size
                           color:(UIColor *)color;

+ (instancetype)cd_imageFromView:(UIView *)view;

@end
