//
//  CLUTabBarItem.h
//  Clue
//
//  Created by Ahmed Sulaiman on 1/20/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLUTabBarItem : NSObject

typedef NS_ENUM(NSInteger, CLUTabBarItemType) {
    CLUTabBarItemUnknown,
    CLUTabBarItemNetwork,
    CLUTabBarItemUserInetraction,
    CLUTabBarItemViewStructure,
    CLUTabBarItemDeviceInfo
};

- (instancetype)initWithTitle:(NSString *)title;
- (instancetype)initWithTitle:(NSString *)title forType:(CLUTabBarItemType)type;

@property (nonatomic) NSString *title;
@property (nonatomic) CLUTabBarItemType type;

@end
