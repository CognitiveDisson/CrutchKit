//
//  UIImage+CDCrop.h
//  CrutchKitExample
//
//  Created by Smal Vadim on 06/06/15.
//  Copyright (c) 2015 cognitivedisson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CDCrop)

- (UIImage *)cd_imageCropped:(CGRect)rect;

- (UIImage *)cd_imagedCroppedToCircle;

@end
