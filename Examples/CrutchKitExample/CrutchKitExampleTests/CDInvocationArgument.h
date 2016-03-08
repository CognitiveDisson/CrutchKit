//
//  CDInvocationArgument.h
//  CrutchKitExample
//
//  Created by Vadim Smal on 2/13/16.
//  Copyright © 2016 cognitivedisson. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CDArgAny [CDInvocationArgument anyArgument]

@interface CDInvocationArgument : NSObject

@property (assign, nonatomic, readonly, getter=isAnyArgument) BOOL anyArgument;
@property (assign, nonatomic, readonly, getter=isNilArgument) BOOL nilArgument;
@property (strong, nonatomic, readonly) id object;

+ (id)anyArgument;

+ (id)nilArgument;

+ (id)argumentWithObject:(id)object;

@end
