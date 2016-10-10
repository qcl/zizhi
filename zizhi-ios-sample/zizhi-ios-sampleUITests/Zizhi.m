//
//  Zizhi.m
//  zizhi-ios-sample
//
//  Created by Qing-Cheng Li on 2016/10/10.
//  Copyright © 2016年 QCLS. All rights reserved.
//

#import "Zizhi.h"

@implementation ZizhiMatcher

- (instancetype)initWithIdentifier:(NSString *)identifier elementType:(XCUIElementType)elementType
{
    self = [super init];
    if (self) {
        self.identifier = identifier;
        self.elementType = elementType;
    }
    return self;
}

- (instancetype)initWithIdentifier:(NSString *)identifier
{
    self = [self initWithIdentifier:identifier elementType:XCUIElementTypeAny];
    return self;
}

- (instancetype)initWithElementType:(XCUIElementType)elementType
{
    self = [self initWithIdentifier:nil elementType:elementType];
    return self;
}

@end

@implementation Zizhi

+ (XCUIElement *)findElementByZizhiMatcher:(ZizhiMatcher *)matcher
{
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *query;
    NSMutableArray <ZizhiMatcher *> *matchers = [NSMutableArray array];
    [matchers addObject:matcher];
    ZizhiMatcher *ancestor = matcher.ancestor;
    while (ancestor) {
        [matchers insertObject:ancestor atIndex:0];
        ancestor = ancestor.ancestor;
    }

    NSMutableArray <XCUIElementQuery *> *currentQueries = [NSMutableArray array];
    NSMutableArray <XCUIElementQuery *> *nextRunQueries = [NSMutableArray array];

    // first run query
    ZizhiMatcher *topMostMatcher = [matchers firstObject];
    [matchers removeObjectAtIndex:0];

    query = [app.windows descendantsMatchingType:topMostMatcher.elementType];
    if (topMostMatcher.identifier) {
        query = [query matchingIdentifier:topMostMatcher.identifier];
    }

    if ([query count] > 0) {
        [currentQueries addObject:query];
    }
    
    // other run if needed
    for (ZizhiMatcher *currentMatcher in matchers) {
        for (XCUIElementQuery *subQuery in currentQueries) {
            XCUIElementQuery *q = [subQuery descendantsMatchingType:currentMatcher.elementType];
            if (currentMatcher.identifier) {
                q = [q matchingIdentifier:currentMatcher.identifier];
            }
            if (q.count > 0) {
                [nextRunQueries addObject:q];
            }
        }
        currentQueries = [nextRunQueries mutableCopy];
        [nextRunQueries removeAllObjects];
    }

    if (currentQueries.count > 0 && [currentQueries firstObject].count > 0) {
        return [[currentQueries firstObject] elementBoundByIndex:0];
    }
    return nil;
}

+ (XCUIElement *)findElementByIdentifier:(NSString *)identifier elementType:(XCUIElementType)elementType
{
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *query = [[app.windows descendantsMatchingType:elementType] matchingIdentifier:identifier];
    if ([query count] > 0) {
        return [query elementBoundByIndex:0];
    }
    return nil;
}

+ (XCUIElement *)findElementByIdentifier:(NSString *)identifier
{
    return [Zizhi findElementByIdentifier:identifier elementType:XCUIElementTypeAny];
}

@end
