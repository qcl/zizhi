//
//  Zizhi.h
//  zizhi-ios-sample
//
//  Created by Qing-Cheng Li on 2016/10/10.
//  Copyright © 2016年 QCLS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Foundation/Foundation.h>

@class ZizhiMatcher;

@interface ZizhiMatcher : NSObject

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, assign) XCUIElementType elementType;
@property (nonatomic, strong) ZizhiMatcher *ancestor;

- (instancetype)initWithIdentifier:(NSString *)identifier elementType:(XCUIElementType)elementType;
- (instancetype)initWithIdentifier:(NSString *)identifier;
- (instancetype)initWithElementType:(XCUIElementType)elementType;

@end

@interface Zizhi : NSObject

#pragma mark - Basic search element method

+ (XCUIElement *)findElementByZizhiMatcher:(ZizhiMatcher *)matcher;
+ (XCUIElement *)findElementByIdentifier:(NSString *)identifier;
+ (XCUIElement *)findElementByIdentifier:(NSString *)identifier elementType:(XCUIElementType)elementType;

@end
