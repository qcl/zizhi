//
//  ZZMatcher.h
//  Pods
//
//  Created by Qing-Cheng Li on 2016/10/11.
//
//

#import <XCTest/XCTest.h>
#import <Foundation/Foundation.h>

@class ZZMatcher;

@interface ZZMatcher : NSObject

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, assign) XCUIElementType elementType;
@property (nonatomic, strong) ZZMatcher *ancestor;

- (instancetype)initWithIdentifier:(NSString *)identifier elementType:(XCUIElementType)elementType;
- (instancetype)initWithIdentifier:(NSString *)identifier;
- (instancetype)initWithElementType:(XCUIElementType)elementType;

@end
