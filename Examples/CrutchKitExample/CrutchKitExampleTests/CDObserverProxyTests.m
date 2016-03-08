//
//  CDObserverProxyTests.m
//  CrutchKitExample
//
//  Created by Smal Vadim on 15/12/15.
//  Copyright © 2015 cognitivedisson. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <CDProxying.h>
#import "CDInvocationHandler.h"
#import "CDInvocationArgument.h"

@interface CDObserverProxyTests : XCTestCase

@end

@implementation CDObserverProxyTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testProxying {
    //giwen
    Protocol *protocol = @protocol(UITableViewDelegate);
    id mockObserver = [[CDInvocationHandler alloc] initWithProtocol:protocol];
    [[mockObserver expect] tableView:CDArgAny estimatedHeightForFooterInSection:5];
    id proxy = [CDObserversProxy observersProxyWithProtocol:protocol
                                                  observers:@[mockObserver]];
    //when
    [proxy tableView:[UITableView new] estimatedHeightForFooterInSection:5];
    
    //then
    [mockObserver performVerification];
}

- (void)testProxyingToMeny {
    //giwen
    Protocol *protocol = @protocol(UITableViewDelegate);
    id mockObserverFirst = CDProtcolHandler(protocol);
    [[mockObserverFirst expect] tableView:CDArgAny estimatedHeightForFooterInSection:5];
    id mockObserverSecond = CDProtcolHandler(protocol);
    [[mockObserverSecond expect] tableView:CDArgAny estimatedHeightForFooterInSection:5];
    id proxy = [CDObserversProxy observersProxyWithProtocol:protocol
                                                  observers:@[mockObserverFirst,
                                                              mockObserverSecond]];
    //when
    [proxy tableView:[UITableView new] estimatedHeightForFooterInSection:5];
    
    //then
    [mockObserverFirst performVerification];
    [mockObserverSecond performVerification];
}

- (void)testProxyinDistributively {
    //giwen
    Protocol *protocol = @protocol(UITableViewDelegate);
    id mockObserverFirst = CDProtcolHandler(protocol);
    [[mockObserverFirst expect] tableView:CDArgAny estimatedHeightForFooterInSection:5];
    [[mockObserverFirst expect] tableView:CDArgAny viewForHeaderInSection:0];
    
    NSString *selector = NSStringFromSelector(@selector(tableView:viewForHeaderInSection:));
    id mockObserverSecond = [[CDInvocationHandler alloc] initWithProtocol:protocol
                                                                selectors:@[selector]];
    [[mockObserverSecond reject] tableView:CDArgAny estimatedHeightForFooterInSection:5];
    [[mockObserverSecond expect] tableView:CDArgAny viewForHeaderInSection:0];
    
    id proxy = [CDObserversProxy observersProxyWithProtocol:protocol
                                                  observers:@[mockObserverFirst,
                                                              mockObserverSecond]];
    //when
    [proxy tableView:[UITableView new] estimatedHeightForFooterInSection:5];
    [proxy tableView:[UITableView new] viewForHeaderInSection:0];
    
    //then
    [mockObserverFirst performVerification];
    [mockObserverSecond performVerification];
}

- (void)testProxyinManyProtocolsToOneObserver {
    //giwen
    Protocol *protocol = @protocol(UITableViewDelegate);
    id mockObserver = CDProtcolHandler(protocol);
    [[mockObserver expect] tableView:CDArgAny estimatedHeightForFooterInSection:5];
    [[mockObserver expect] tableView:CDArgAny viewForHeaderInSection:0];
    
    id proxy = [CDObserversProxy observersProxyWithProtocol:protocol
                                                  observers:@[mockObserver]];
    //when
    [proxy tableView:[UITableView new] estimatedHeightForFooterInSection:5];
    [proxy tableView:[UITableView new] viewForHeaderInSection:0];
    
    //then
    [mockObserver performVerification];
}

- (void)testProxySelector {
    //giwen
    Protocol *protocol = @protocol(UITableViewDelegate);
    id mockObserver = CDProtcolHandler(protocol);
    [[mockObserver expect] tableView:CDArgAny estimatedHeightForFooterInSection:5];
    
    id proxy = [CDObserversProxy observersProxyWithProtocols:nil
                                                   selectors:@[NSStringFromSelector(@selector(tableView:estimatedHeightForFooterInSection:))]
                                                   observers:@[mockObserver]];
    //when
    [proxy tableView:[UITableView new] estimatedHeightForFooterInSection:5];
    
    //then
    [mockObserver performVerification];
}

@end
