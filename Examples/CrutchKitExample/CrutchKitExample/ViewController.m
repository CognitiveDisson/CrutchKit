//
//  ViewController.m
//  CrutchKitExample
//
//  Created by Smal Vadim on 02/06/15.
//  Copyright (c) 2015 cognitivedisson. All rights reserved.
//

#import "ViewController.h"
#import <CrutchKit/Debug/CDDebugger.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self test];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)test {
    NSMutableArray *array = [NSMutableArray new];
    for (int i = 0; i < 900000;i ++) {
        [array addObject:@(i*1000)];
            NSLog(@"%lu %lu", (unsigned long)[CDDebugger usedMemory],  (unsigned long)[CDDebugger freeMemory]);
    }
    return [array copy];
}

@end
