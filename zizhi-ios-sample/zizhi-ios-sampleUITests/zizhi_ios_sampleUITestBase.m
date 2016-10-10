//
//  zizhi_ios_sampleUITestBase.m
//  zizhi-ios-sample
//
//  Created by Qing-Cheng Li on 2016/10/10.
//  Copyright © 2016年 QCLS. All rights reserved.
//

#import "zizhi_ios_sampleUITestBase.h"

@implementation zizhi_ios_sampleUITestBase

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    NSLog(@"base setup");
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    NSLog(@"base tear down");
}

@end
