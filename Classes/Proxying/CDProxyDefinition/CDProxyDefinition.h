//
//  CDProxyDefinition.h
//  Pods
//
//  Created by Smal Vadim on 15/12/15.
//
//

#import <Foundation/Foundation.h>

@protocol CDObserver;

@interface CDProxyDefinition : NSObject

+ (instancetype)definitionWithProtocols:(NSArray *)protocols;

+ (instancetype)definitionWithProtocols:(NSArray *)protocols
                              observers:(NSArray *)observers;

+ (instancetype)definitionWithProtocols:(NSArray *)protocols
                              selectors:(NSArray *)selectors
                              observers:(NSArray *)observers;

+ (instancetype)definitionWithSelector:(SEL)selector;

+ (instancetype)definitionWithSelectors:(NSArray *)selectors;

@property (assign, nonatomic) BOOL onlyFirstRespondedObserver;

- (NSArray *)proxyObservers;
- (NSArray *)proxyProtocols;
- (NSArray *)proxySelectors;

- (void)addObserver:(id<CDObserver>)observer;

- (void)removeObserver:(id<CDObserver>)observer;

@end
