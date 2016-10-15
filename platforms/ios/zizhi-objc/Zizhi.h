//
//  Zizhi.h
//  Zizhi
//
//  Created by Qing-Cheng Li on 2016/10/10.
//  Copyright © 2016 QCLS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Foundation/Foundation.h>

#import "ZZMatcher.h"

@interface Zizhi : NSObject

#pragma mark - Basic search element method

+ (XCUIElement *)findElementByZizhiMatcher:(ZZMatcher *)matcher;
+ (XCUIElement *)findElementByIdentifier:(NSString *)identifier;
+ (XCUIElement *)findElementByIdentifier:(NSString *)identifier elementType:(XCUIElementType)elementType;

@end
