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
    sleep(2);
}

- (void)testHelloWorld
{
    //sleep(3);
    
    NSPredicate *p = [NSPredicate predicateWithFormat:@"exists == 1"];
    
    XCUIApplication *app = [[XCUIApplication alloc] init];

    XCUIElement *btn = app.buttons[@"Hello"];
    //[self expectationForPredicate:p evaluatedWithObject:btn handler:nil];
    //[self waitForExpectationsWithTimeout:15 handler:nil];
    
    [btn tap];

    XCUIElement *element = app.staticTexts[@"Hello world"];
    
    [self expectationForPredicate:p evaluatedWithObject:element handler:nil];
    [self waitForExpectationsWithTimeout:15 handler:^(NSError * _Nullable error) {
        
    }];
}

- (void)tearDown
{
    [super tearDown];
}

@end
