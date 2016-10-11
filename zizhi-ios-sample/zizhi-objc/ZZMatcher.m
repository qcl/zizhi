//
//  ZZMatcher.m
//  Pods
//
//  Created by Qing-Cheng Li on 2016/10/11.
//
//

#import "ZZMatcher.h"

@implementation ZZMatcher

- (instancetype)initWithIdentifier:(NSString *)identifier elementType:(XCUIElementType)elementType
{
    self = [super init];
    if (self) {
        self.identifier = identifier;
        self.elementType = elementType;
    }
    return self;
}

- (instancetype)initWithIdentifier:(NSString *)identifier
{
    self = [self initWithIdentifier:identifier elementType:XCUIElementTypeAny];
    return self;
}

- (instancetype)initWithElementType:(XCUIElementType)elementType
{
    self = [self initWithIdentifier:nil elementType:elementType];
    return self;
}

@end
