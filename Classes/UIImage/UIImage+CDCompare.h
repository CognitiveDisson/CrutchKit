//
//  UIImage+CDCompare.h
//  CrutchKitExample
//
//  Created by Smal Vadim on 06/06/15.
//  Copyright (c) 2015 cognitivedisson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CDCompare)

- (BOOL)cd_isEqualToImageByBytes:(UIImage *)image;

@end
