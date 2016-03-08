//
//  CDInvocationArgument.m
//  CrutchKitExample
//
//  Created by Vadim Smal on 2/13/16.
//  Copyright © 2016 cognitivedisson. All rights reserved.
//

#import "CDInvocationArgument.h"

@interface CDInvocationArgument ()

@property (assign, nonatomic, readwrite) BOOL anyArgument;
@property (assign, nonatomic, readwrite) BOOL nilArgument;
@property (strong, nonatomic, readwrite) id object;

@end

@implementation CDInvocationArgument

+ (id)anyArgument {
    CDInvocationArgument *argument = [CDInvocationArgument new];
    argument.anyArgument = YES;
    return argument;
}

+ (id)argumentWithObject:(id)object {
    CDInvocationArgument *argument = [CDInvocationArgument new];
    argument.object = object;
    return argument;
}

+ (id)nilArgument {
    CDInvocationArgument *argument = [CDInvocationArgument new];
    argument.nilArgument = YES;
    return argument;
}

- (BOOL)isEqual:(CDInvocationArgument *)object {
    if (![object isMemberOfClass:[CDInvocationArgument class]]) {
        return NO;
    }
    if (self.anyArgument || object.anyArgument) {
        return YES;
    }
    if (![self.object isEqual:object.object]) {
        return NO;
    }
    return YES;
}

@end
