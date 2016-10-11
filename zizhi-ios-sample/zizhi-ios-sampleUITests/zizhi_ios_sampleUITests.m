//
//  zizhi_ios_sampleUITests.m
//  zizhi-ios-sampleUITests
//
//  Created by Qing-Cheng Li on 2016/10/10.
//  Copyright © 2016年 QCLS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Zizhi/Zizhi.h>

#import "zizhi_ios_sampleUITestBase.h"

@interface zizhi_ios_sampleUITests : zizhi_ios_sampleUITestBase

@end

@implementation zizhi_ios_sampleUITests

- (void)setUp {
    
    NSLog(@"setup");
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    [super setUp];
}

- (void)tearDown {
    NSLog(@"tear down");
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.buttons[@"Hello"] tap];
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    XCTAssertNotNil(app.staticTexts[@"Hello world"]);
}

- (void)testExampleTwo {
    // Use recording to get started writing UI tests.
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.buttons[@"Hello"] tap];
    // Use XCTAssert and related functions to verify your tests produce the correct results.

    ZZMatcher *zzm1 = [[ZZMatcher alloc] initWithElementType:XCUIElementTypeWindow];
    ZZMatcher *zzm = [[ZZMatcher alloc] initWithIdentifier:@"Hello" elementType:XCUIElementTypeButton];
    zzm.ancestor = zzm1;
    XCUIElement *element = [Zizhi findElementByZizhiMatcher:zzm];
    [element tap];
//
    XCTAssertNotNil(app.staticTexts[@"Hello world"]);
}

@end
