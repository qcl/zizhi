//
//  zizhi_ios_sampleUITests.m
//  zizhi-ios-sampleUITests
//
//  Created by Qing-Cheng Li on 2016/10/10.
//  Copyright © 2016年 QCLS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Zizhi.h"

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

- (void) test_Test_Case_Name {
    // Given something
    ZZMatcher *zzm_1 = [[ZZMatcher alloc] initWithIdentifier:@"Some where"];
    ZZMatcher *zzm_2 = [[ZZMatcher alloc] initWithIdentifier:@"Some button" elementType:XCUIElementTypeButton];
    zzm_2.ancestor = zzm_1;
    XCUIElement *targetElement_1 = [Zizhi findElementByZizhiMatcher:zzm_2];
    [targetElement_1 tap];
    
    ZZMatcher *zzm_3 = [[ZZMatcher alloc] initWithIdentifier:@"Another where"];
    ZZMatcher *zzm_4 = [[ZZMatcher alloc] initWithIdentifier:@"Some label"];
    zzm_4.ancestor = zzm_3;
    XCUIElement *targetElement_2 = [Zizhi findElementByZizhiMatcher:zzm_4];
    XCTAssertNotNil(targetElement_2);
    
    // When doing some actions
    ZZMatcher *zzm_5 = [[ZZMatcher alloc] initWithElementType:XCUIElementTypeNavigationBar];
    ZZMatcher *zzm_6 = [[ZZMatcher alloc] initWithIdentifier:@"A" elementType:XCUIElementTypeButton];
    zzm_6.ancestor = zzm_5;
    XCUIElement *targetElement_3 = [Zizhi findElementByZizhiMatcher:zzm_6];
    [targetElement_3 tap];
    
    ZZMatcher *zzm_7 = [[ZZMatcher alloc] initWithIdentifier:@"C" elementType:XCUIElementTypeCollectionView];
    ZZMatcher *zzm_8 = [[ZZMatcher alloc] initWithIdentifier:@"b" elementType:XCUIElementTypeButton];
    zzm_8.ancestor = zzm_7;
    XCUIElement *targetElement_4 = [Zizhi findElementByZizhiMatcher:zzm_8];
    [targetElement_4 tap];
    
    // Then something should happend
    ZZMatcher *zzm_9 = [[ZZMatcher alloc] initWithIdentifier:@"some icons" elementType:XCUIElementTypeImage];
    XCUIElement *targetElement_5 = [Zizhi findElementByZizhiMatcher:zzm_9];
    XCTAssertNotNil(targetElement_5);
    
    
}

// TestCaseTitle
- (void) test_TestCaseTitle {
    // Given ...
    ZZMatcher *zzm_1 = [[ZZMatcher alloc] initWithElementType:XCUIElementTypeNavigationBar];
    ZZMatcher *zzm_2 = [[ZZMatcher alloc] initWithIdentifier:@"Menu" elementType:XCUIElementTypeButton];
    zzm_2.ancestor = zzm_1;
    XCUIElement *targetElement_1 = [Zizhi findElementByZizhiMatcher:zzm_2];
    [targetElement_1 tap];
    
    // When ...
    ZZMatcher *zzm_3 = [[ZZMatcher alloc] initWithIdentifier:@"APPRISE" elementType:XCUIElementTypeButton];
    XCUIElement *targetElement_2 = [Zizhi findElementByZizhiMatcher:zzm_3];
    [targetElement_2 tap];
    
    // Then ...
    ZZMatcher *zzm_4 = [[ZZMatcher alloc] initWithIdentifier:@"Your Anisatr is really strong"];
    XCUIElement *targetElement_3 = [Zizhi findElementByZizhiMatcher:zzm_4];
    XCTAssertNotNil(targetElement_3);
    
    
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
