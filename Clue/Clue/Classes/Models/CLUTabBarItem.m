//
//  CLUTabBarItem.m
//  Clue
//
//  Created by Ahmed Sulaiman on 1/20/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import "CLUTabBarItem.h"

@implementation CLUTabBarItem

- (instancetype)initWithTitle:(NSString *)title {
    self = [super init];
    if (!self) {
        return nil;
    }
    _title = title;
    return self;
}

@end
