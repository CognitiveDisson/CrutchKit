//
//  UIView+CDCompletion.h
//  CrutchKitExample
//
//  Created by Smal Vadim on 20/07/15.
//  Copyright (c) 2015 cognitivedisson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDTypes.h"

@interface UIView (CDCompletion)

- (void)endEditing:(BOOL)force
        completion:(CDBoolBlock)block;

@end
