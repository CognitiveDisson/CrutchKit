//
//  NSFileManager+CDExtension.h
//  CrutchKitExample
//
//  Created by Smal Vadim on 06/06/15.
//  Copyright (c) 2015 cognitivedisson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (CDExtension)

- (NSUInteger)fileSizeAtPath:(NSString *)filePath;

- (NSUInteger)folderSizeAtPath:(NSString *)folderPath;

@end
