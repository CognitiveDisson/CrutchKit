//
//  UIView+CDCompletion.m
//  CrutchKitExample
//
//  Created by Smal Vadim on 20/07/15.
//  Copyright (c) 2015 cognitivedisson. All rights reserved.
//

#import "UIView+CDCompletion.h"

@implementation UIView (CDCompletion)

- (void)endEditing:(BOOL)force
        completion:(CDBoolBlock)block {
    
    __block BOOL result;
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        if (block) {
            block(result);
        }
    }];
    result = [self endEditing:YES];
    [CATransaction commit];
    
}

@end
