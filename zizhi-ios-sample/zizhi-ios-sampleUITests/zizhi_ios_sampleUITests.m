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

- (void)testHelloWorld
{
    NSPredicate *p = [NSPredicate predicateWithFormat:@"exists == 1"];
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *btn = app.buttons[@"Hello"];
    [btn tap];

    XCUIElement *element = app.staticTexts[@"Hello world"];
    [self expectationForPredicate:p evaluatedWithObject:element handler:nil];
    [self waitForExpectationsWithTimeout:15 handler:nil];
}

- (void)tearDown {
    [super tearDown];
}

@end
