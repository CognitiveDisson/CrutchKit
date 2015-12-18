//
//  CDObserverProxyTests.m
//  CrutchKitExample
//
//  Created by Smal Vadim on 15/12/15.
//  Copyright © 2015 cognitivedisson. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <CrutchKit/CDProxying.h>

@interface CDObserverProxyTests : XCTestCase

@property (strong, nonatomic) CDObserversProxy *proxy;

@end

@implementation CDObserverProxyTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
