//
//  zizhi_ios_sampleUITestBase.m
//  zizhi-ios-sample
//
//  Created by Qing-Cheng Li on 2016/10/10.
//  Copyright © 2016年 QCLS. All rights reserved.
//

#import "zizhi_ios_sampleUITestBase.h"

@implementation zizhi_ios_sampleUITestBase

- (void)setUp
{
    [super setUp];
    self.continueAfterFailure = NO;
    [[[XCUIApplication alloc] init] launch];
}

- (void)testHelloWorld
{
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.buttons[@"Hello"] tap];
    XCTAssertNotNil(app.staticTexts[@"Hello world"]);
}

- (void)tearDown
{
    [super tearDown];
}

@end
