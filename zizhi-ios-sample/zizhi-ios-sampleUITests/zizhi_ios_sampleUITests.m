//
//  zizhi_ios_sampleUITests.m
//  zizhi-ios-sampleUITests
//
//  Created by Qing-Cheng Li on 2016/10/10.
//  Copyright © 2016年 QCLS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Zizhi.h"

@interface zizhi_ios_sampleUITests : XCTestCase

@end

@implementation zizhi_ios_sampleUITests

- (void)setUp
{
    [super setUp];
    self.continueAfterFailure = NO;
    [[[XCUIApplication alloc] init] launch];
    sleep(1);
}

- (void)tearDown {
    NSLog(@"tear down");
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

// Pokemon Apprise
- (void) test_Pokemon_Apprise {
    
    // Given pokemon view
    ZZMatcher *zzm_1 = [[ZZMatcher alloc] initWithElementType:XCUIElementTypeTabBar];
    ZZMatcher *zzm_2 = [[ZZMatcher alloc] initWithIdentifier:@"Banana" elementType:XCUIElementTypeButton];
    zzm_2.ancestor = zzm_1;
    XCUIElement *targetElement_1 = [Zizhi findElementByZizhiMatcher:zzm_2];
    [self expectationForPredicate:[NSPredicate predicateWithFormat:@"exists == 1"] evaluatedWithObject:targetElement_1 handler:nil];
    [self waitForExpectationsWithTimeout:5 handler:nil];
    [targetElement_1 tap];
    
    // When tap pokemon apprise
    ZZMatcher *zzm_3 = [[ZZMatcher alloc] initWithIdentifier:@"menu" elementType:XCUIElementTypeButton];
    XCUIElement *targetElement_2 = [Zizhi findElementByZizhiMatcher:zzm_3];
    [self expectationForPredicate:[NSPredicate predicateWithFormat:@"exists == 1"] evaluatedWithObject:targetElement_2 handler:nil];
    [self waitForExpectationsWithTimeout:5 handler:nil];
    [targetElement_2 tap];
    
    ZZMatcher *zzm_4 = [[ZZMatcher alloc] initWithIdentifier:@"apprise" elementType:XCUIElementTypeButton];
    XCUIElement *targetElement_3 = [Zizhi findElementByZizhiMatcher:zzm_4];
    [self expectationForPredicate:[NSPredicate predicateWithFormat:@"exists == 1"] evaluatedWithObject:targetElement_3 handler:nil];
    [self waitForExpectationsWithTimeout:5 handler:nil];
    [targetElement_3 tap];
    
    // Then show apprise
    ZZMatcher *zzm_5 = [[ZZMatcher alloc] initWithIdentifier:@"Banana is delicious"];
    XCUIElement *targetElement_4 = [Zizhi findElementByZizhiMatcher:zzm_5];
    [self expectationForPredicate:[NSPredicate predicateWithFormat:@"exists == 1"] evaluatedWithObject:targetElement_4 handler:nil];
    [self waitForExpectationsWithTimeout:5 handler:nil];
}

@end
