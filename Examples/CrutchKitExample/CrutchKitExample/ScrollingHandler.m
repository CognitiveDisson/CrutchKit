//
//  ScrollingHandler.m
//  CrutchKitExample
//
//  Created by Smal Vadim on 29/12/15.
//  Copyright © 2015 cognitivedisson. All rights reserved.
//

#import "ScrollingHandler.h"

@implementation ScrollingHandler

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"did scroll wuth new y offset %f", scrollView.contentOffset.y);
}

@end
