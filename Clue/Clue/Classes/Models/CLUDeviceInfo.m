//
//  CLUDeviceInfo.m
//  Clue
//
//  Created by Ahmed Sulaiman on 1/22/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import "CLUDeviceInfo.h"

@implementation CLUDeviceInfo

- (instancetype)initWithURL:(NSURL *)url {
    NSError *error = nil;
    NSString *jsonString = [NSString stringWithContentsOfFile:url.path
                                                     encoding:NSUTF8StringEncoding
                                                        error:&error];
    if (error) {
        // TODO: add json error handling
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    self = [self initWithJSONRepresentation:jsonDictionary];
    return self;
}

- (instancetype)initWithJSONRepresentation:(NSDictionary *)json {
    self = [super init];
    if (!self) {
        return nil;
    }
    _batteryState = [[json objectForKey:@"batteryState"] integerValue];
    _systemName = [json objectForKey:@"systemName"];
    _model = [json objectForKey:@"model"];
    _systemVersion = [json objectForKey:@"systemVersion"];
    _batteryLevel = [[json objectForKey:@"batteryLevel"] floatValue];
    _name = [json objectForKey:@"name"];
    _identifierForVendor = [json objectForKey:@"identifierForVendor"];
    return self;
}

- (NSString *)batteryStateString {
    switch (_batteryState) {
        case CLUBatteryStateUnknown:
            return @"Unknown";
            
        case CLUBatteryStateUnplugged:
            return @"Unplugged";
            
        case CLUBatteryStateFull:
            return @"Full";
            
        case CLUBatteryStateCharging:
            return @"Charging";
    }
}

@end
