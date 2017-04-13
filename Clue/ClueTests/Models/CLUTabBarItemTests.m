//
//  CLUTabBarItemTests.m
//  Clue
//
//  Created by Ahmed Sulaiman on 4/9/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CLUTabBarItem.h"

@interface CLUTabBarItemTests : XCTestCase

@end

@implementation CLUTabBarItemTests

- (void)testInitWithTitle {
    CLUTabBarItem *tabBarItem = [[CLUTabBarItem alloc] initWithTitle:@"Test tab title"];
    XCTAssertNotNil(tabBarItem, @"Tab Bar Item is invalid");
    XCTAssertEqual(tabBarItem.type, CLUTabBarItemUnknown,
                   @"Tab Bar Item type should be CLUTabBarItemUnknown if init new instance with title only");
    XCTAssertEqualObjects(tabBarItem.title, @"Test tab title", @"Tab Bar Item title is incorrent");
}

- (void)testInitWithTitleForType {
    CLUTabBarItem *tabBarItem = [[CLUTabBarItem alloc] initWithTitle:@"Test tab title" forType:CLUTabBarItemUserInetraction];
    XCTAssertNotNil(tabBarItem, @"Tab Bar Item is invalid");
    XCTAssertEqual(tabBarItem.type, CLUTabBarItemUserInetraction, @"Tab Bar Item type is incorrect");
    XCTAssertEqualObjects(tabBarItem.title, @"Test tab title", @"Tab Bar Item title is incorrent");
}

@end
