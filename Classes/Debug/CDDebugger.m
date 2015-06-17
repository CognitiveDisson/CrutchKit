//
//  CDDebugger.m
//  CrutchKitExample
//
//  Created by Smal Vadim on 06/06/15.
//  Copyright (c) 2015 cognitivedisson. All rights reserved.
//

#import "CDDebugger.h"
#import "mach/mach.h"

static NSDateFormatter *currentTimeformatter;

@implementation CDDebugger

+ (NSUInteger)usedMemory {
    struct task_basic_info info;
    mach_msg_type_number_t size = sizeof(info);
    kern_return_t kerr = task_info(mach_task_self(),
                                   TASK_BASIC_INFO,
                                   (task_info_t)&info,
                                   &size);

    if( kerr == KERN_SUCCESS ) {
        return info.resident_size;
    }
    
    return 0;
}

+ (NSUInteger)freeMemory {
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t pagesize;
    vm_statistics_data_t vm_stat;
    
    host_page_size(host_port, &pagesize);
    (void) host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    return vm_stat.free_count * pagesize;
}

+ (NSUInteger)getFreeDiskspace {
    uint64_t totalSpace = 0;
    uint64_t totalFreeSpace = 0;
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    
    if (dictionary) {
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];
        NSNumber *freeFileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemFreeSize];
        totalSpace = [fileSystemSizeInBytes unsignedLongLongValue];
        totalFreeSpace = [freeFileSystemSizeInBytes unsignedLongLongValue];
    }
    
    return totalFreeSpace;
}

+ (void)printCurrentTimeWithTitle:(NSString *)title {
    
    NSDate *date = [NSDate date];
    
    double timeInterval = [date timeIntervalSince1970];
    if (!currentTimeformatter) {
        currentTimeformatter = [[NSDateFormatter alloc] init];
        [currentTimeformatter setDateFormat:@"MMMM dd, yyyy (EEEE) HH:mm:ss z Z"];
    }
    
    double millisecondsPart = timeInterval - (int)timeInterval;
    int milliseconds = (int)(millisecondsPart * 1000.0);
    
    NSString *formatedDate = [currentTimeformatter stringFromDate:date];
    
    NSLog(@"%@ : %@ %d",title, formatedDate, milliseconds);
}

@end
