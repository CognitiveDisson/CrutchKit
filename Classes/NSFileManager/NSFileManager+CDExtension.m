//
//  NSFileManager+CDExtension.m
//  CrutchKitExample
//
//  Created by Smal Vadim on 06/06/15.
//  Copyright (c) 2015 cognitivedisson. All rights reserved.
//

#import "NSFileManager+CDExtension.h"

@implementation NSFileManager (CDExtension)

- (NSUInteger)fileSizeAtPath:(NSString *)filePath {
    NSDictionary *fileAttributes = [self attributesOfItemAtPath:filePath error:nil];
    return [[fileAttributes objectForKey:NSFileSize] unsignedIntegerValue];
}

- (NSUInteger)folderSizeAtPath:(NSString *)folderPath {
    
    NSArray *contents = [self contentsOfDirectoryAtPath:folderPath error:nil];
    
    NSEnumerator *contentsEnumurator = [contents objectEnumerator];
    
    NSString *fileName;
    unsigned long long int folderSize = 0;
    
    while (fileName = [contentsEnumurator nextObject]) {
        NSString *filePath = [folderPath stringByAppendingPathComponent:fileName];
        BOOL isDirectory = NO;
        [self fileExistsAtPath:filePath isDirectory:&isDirectory];
        if (isDirectory) {
            folderSize += [self folderSizeAtPath:folderPath];
        } else {
            folderSize += [self fileSizeAtPath:filePath];
        }
    }
    
    return folderSize;
}

@end
