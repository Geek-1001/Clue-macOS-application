//
//  CLUDeviceInfo.h
//  Clue
//
//  Created by Ahmed Sulaiman on 1/22/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLUJSONDeserializable.h"

@interface CLUDeviceInfo : NSObject <CLUJSONDeserializable>

typedef NS_ENUM(NSInteger, CLUBatteryState) {
    CLUBatteryStateUnknown,
    CLUBatteryStateUnplugged,
    CLUBatteryStateCharging,
    CLUBatteryStateFull
};

@property (nonatomic) CLUBatteryState batteryState;
@property (nonatomic) NSString *systemName;
@property (nonatomic) NSString *model;
@property (nonatomic) NSString *systemVersion;
@property (nonatomic) CGFloat batteryLevel;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *identifierForVendor;

- (instancetype)initWithURL:(NSURL *)url;
- (NSString *)batteryStateString;

@end
