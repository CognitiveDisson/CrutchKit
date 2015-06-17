//
//  CDDebugger.h
//  CrutchKitExample
//
//  Created by Smal Vadim on 06/06/15.
//  Copyright (c) 2015 cognitivedisson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDDebugger : NSObject

+ (NSUInteger)usedMemory;

+ (NSUInteger)freeMemory;

+ (NSUInteger)getFreeDiskspace;

+ (void)printCurrentTimeWithTitle:(NSString *)title;

@end
