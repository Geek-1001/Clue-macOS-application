//
//  CLUTimeDistributionController.h
//  Clue
//
//  Created by Ahmed Sulaiman on 1/29/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLUTimeDistributionDelegate.h"

@interface CLUTimeDistributionController : NSObject

@property (nonatomic) double duration;
@property (nonatomic) double currentTime;
@property (nonatomic) BOOL timePlaybackStart;

+ (instancetype)sharedController;
- (void)registerHandler:(id<CLUTimeDistributionDelegate>)handler;
- (void)unregisterHandler:(id<CLUTimeDistributionDelegate>)handler;

@end
