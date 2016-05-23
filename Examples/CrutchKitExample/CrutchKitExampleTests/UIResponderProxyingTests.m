//
//  UIResponderProxyingTests.m
//  CrutchKitExample
//
//  Created by m.rakhmanov on 21.05.16.
//  Copyright © 2016 cognitivedisson. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <CDProxying.h>
#import "CDInvocationHandler.h"
#import "CDInvocationArgument.h"
#import <CDProxy/Proxy/CDProxy.h>

@interface UIResponderProxyingTests : XCTestCase

@end

@implementation UIResponderProxyingTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testThatProxyIsInsertedInResponderChain {
    
    // given
    UIResponder* responder = [UIResponder new];
    id proxy = CDProtcolHandler(@protocol(CDProxy));
    
    // when
    [responder cd_insertProxyInResponderChain:proxy];
    
    // then
    XCTAssertEqualObjects(responder.cd_defaultProxy, proxy);
}

- (void)testThatProxyIsRemovedFromResponderChain {
    
    // given
    UIResponder* responder = [UIResponder new];
    id proxy = CDProtcolHandler(@protocol(CDProxy));
    
    [responder cd_insertProxyInResponderChain:proxy];
    
    // when
    [responder cd_removeProxyFromResponderChain];
    
    // then
    XCTAssertNil(responder.cd_defaultProxy);
}

- (void)testThatResponderChainIsCorrectlyFilledOut {
    
    // given
    UIView* view1 = [UIView new];
    UIView* view2 = [UIView new];
    [view1 addSubview:view2];
    
    // when
    NSArray *chain = [view2 cd_responderChain];
    
    // then
    XCTAssert([chain containsObject:view1]);
    XCTAssert([chain containsObject:view2]);
}

- (void)testThatCDProxyForProtocolCallsExpectedMethodOfCDProxy {
    
    // given
    id proxy = CDProtcolHandler(@protocol(CDProxy));
    [[proxy expect] proxyProtocol:@protocol(CDProxy)];
    
    UIView* view1 = [UIView new];
    UIView* view2 = [UIView new];
    [view1 addSubview:view2];
    
    [view1 cd_insertProxyInResponderChain:proxy];
    
    // when
    [view2 cd_proxyForProtocol:@protocol(CDProxy)];
    
    // then
    [proxy performVerification];
}

- (void)testThatCDProxyForProtocolFailsToFindIncorrectProtocol {
    
    // given
    id proxy = CDProtcolHandler(@protocol(CDProxy));
    [[proxy reject] proxyProtocol:@protocol(CDProxy)];
    [[proxy expect] proxyProtocol:@protocol(UITableViewDelegate)];
    
    UIView* view1 = [UIView new];
    UIView* view2 = [UIView new];
    [view1 addSubview:view2];
    
    [view1 cd_insertProxyInResponderChain:proxy];
    
    // when
    [view2 cd_proxyForProtocol:@protocol(UITableViewDelegate)];
    
    // then
    [proxy performVerification];
}

- (void)testThatCDProxyForProtocolFailsToFindDeletedProtocol {
    
    // given
    id proxy = CDProtcolHandler(@protocol(CDProxy));
    [[proxy reject] proxyProtocol:@protocol(CDProxy)];
    
    UIView* view1 = [UIView new];
    UIView* view2 = [UIView new];
    [view1 addSubview:view2];
    
    [view1 cd_insertProxyInResponderChain:proxy];
    [view1 cd_removeProxyFromResponderChain];
    
    // when
    [view2 cd_proxyForProtocol:@protocol(CDProxy)];
    
    // then
    [proxy performVerification];
}

- (void)testThatCDProxyForSelectorCallsExpectedMethodOfCDProxy {
    
    // given
    SEL selector = @selector(definition);
    
    id proxy = CDProtcolHandler(@protocol(CDProxy));
    [[proxy expect] proxySelector:selector];
    
    UIView* view1 = [UIView new];
    UIView* view2 = [UIView new];
    [view1 addSubview:view2];
    
    [view1 cd_insertProxyInResponderChain:proxy];
    
    // when
    [view2 cd_proxyForSelector:selector];
    
    // then
    [proxy performVerification];
}

- (void)testThatCDProxyForProtocolSelectorCallsExpectedMethodOfCDProxy {
    
    // given
    SEL selector = @selector(definition);
    Protocol *protocol = @protocol(CDProxy);
    
    id proxy = CDProtcolHandler(protocol);
    [[proxy expect] proxyProtocol:protocol selector:selector];
    
    UIView* view1 = [UIView new];
    UIView* view2 = [UIView new];
    [view1 addSubview:view2];
    
    [view1 cd_insertProxyInResponderChain:proxy];
    
    // when
    [view2 cd_proxyForProtocol:protocol selector:selector];
    
    // then
    [proxy performVerification];
}

@end
