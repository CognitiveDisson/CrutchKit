//
//  CDInvocationContainer.m
//  CrutchKitExample
//
//  Created by Vadim Smal on 2/13/16.
//  Copyright © 2016 cognitivedisson. All rights reserved.
//

#import "CDInvocationContainer.h"
#import "CDInvocationArgument.h"

@interface CDInvocationContainer ()

@property (strong, nonatomic, readwrite) NSInvocation *invocation;
@property (strong, nonatomic, readwrite) NSMethodSignature *signature;
@property (assign, nonatomic, readwrite) SEL selector;
@property (strong, nonatomic, readwrite) NSArray *arguments;

@end

@implementation CDInvocationContainer

- (instancetype)initWithInvocation:(NSInvocation *)invocation
                   methodSignature:(NSMethodSignature *)signature {
    if (self) {
        _invocation = invocation;
        _signature = signature;
        _selector = invocation.selector;
        [self fillArguments];
    }
    return self;
}

- (void)fillArguments {
    [self.invocation retainArguments];
    NSMutableArray *arguments = [NSMutableArray new];
    NSUInteger numberOfArguments = [self.signature numberOfArguments];
    for (NSUInteger idx = 2; idx < numberOfArguments; idx++) {
        __unsafe_unretained id arg;
        [self.invocation getArgument:&arg atIndex:idx];
        if (!CheckObjectType([self.signature getArgumentTypeAtIndex:idx])) {
            NSValue *value = [NSValue value:&arg withObjCType:[self.signature getArgumentTypeAtIndex:idx]];
            arg = nil;
            [arguments addObject:value];
        } else if (arg == nil || arg == [NSNull null]) {
            [arguments addObject:[CDInvocationArgument nilArgument]];
        } else if ([arg isKindOfClass:[CDInvocationArgument class]]) {
            [arguments addObject:arg];
        } else {
            [arguments addObject:[CDInvocationArgument argumentWithObject:arg]];
        }
    }
    self.arguments = arguments;
}

BOOL CheckObjectType(const char *objCType)
{
    objCType = CDArgumentTypeWithoutQualifiers(objCType);
    
    if(strcmp(objCType, @encode(id)) == 0 || strcmp(objCType, @encode(Class)) == 0)
        return YES;
    
    // sometimes the name of an object's class is tacked onto the type, in double quotes
    if(strncmp(objCType, @encode(id), 1) == 0 && objCType[1] == '\"')
        return YES;
    
    // if the returnType is a typedef to an object, it has the form ^{OriginClass=#}
    NSString *regexString = @"^\\^\\{(.*)=#.*\\}";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString options:0 error:NULL];
    NSString *type = [NSString stringWithCString:objCType encoding:NSASCIIStringEncoding];
    if([regex numberOfMatchesInString:type options:0 range:NSMakeRange(0, type.length)] > 0)
        return YES;
    
    // if the return type is a block we treat it like an object
    // TODO: if the runtime were to encode the block's argument and/or return types, this test would not be sufficient
    if(strcmp(objCType, @encode(void(^)())) == 0)
        return YES;
    
    return NO;
}

const char *CDArgumentTypeWithoutQualifiers(const char *objCType)
{
    while(strchr("rnNoORV", objCType[0]) != NULL)
        objCType += 1;
    return objCType;
}


- (BOOL)isEqual:(CDInvocationContainer *)object {
    if (self.selector != object.selector) {
        return NO;
    }
    if (![self.arguments isEqualToArray:object.arguments]) {
        return NO;
    }
    return YES;
}

@end
