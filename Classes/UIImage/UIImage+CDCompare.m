//
//  UIImage+CDCompare.m
//  CrutchKitExample
//
//  Created by Smal Vadim on 06/06/15.
//  Copyright (c) 2015 cognitivedisson. All rights reserved.
//

#import "UIImage+CDCompare.h"

@implementation UIImage (CDCompare)

- (BOOL)cd_isEqualToImageByBytes:(UIImage *)image {
    
    NSData *imagePixelsData = (NSData *)CFBridgingRelease(CGDataProviderCopyData(CGImageGetDataProvider(self.CGImage)));
    
    NSData *otherImagePixelsData = (NSData *)CFBridgingRelease(CGDataProviderCopyData(CGImageGetDataProvider(image.CGImage)));
    
    BOOL comparison = [imagePixelsData isEqualToData:otherImagePixelsData];
    
    return comparison;
}

@end
