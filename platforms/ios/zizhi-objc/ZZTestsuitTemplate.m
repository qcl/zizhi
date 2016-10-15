//
//  {{TESTSUIT}}.m
//
//  Created by Zizhi on {{DATE}} with <3.
//

#import <XCTest/XCTest.h>
#import "Zizhi.h"

@interface {{TESTSUIT}} : XCTestCase

@end

@implementation {{TESTSUIT}}

- (void)setUp
{
    [super setUp];
    self.continueAfterFailure = NO;
    [[[XCUIApplication alloc] init] launch];
}

- (void)tearDown
{
    [super tearDown];
}

{{TESTCASES}}

@end
