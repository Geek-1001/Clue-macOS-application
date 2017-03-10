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

@property (nonatomic, readonly) double duration;
@property (nonatomic, readonly) double currentTime;
@property (nonatomic, readonly) BOOL timePlaybackStart;

+ (instancetype)sharedController;
- (void)registerHandler:(id<CLUTimeDistributionDelegate>)handler withDocumentID:(NSString *)documentId;
- (void)unregisterHandler:(id<CLUTimeDistributionDelegate>)handler;

- (void)setCurrentTime:(double)currentTime forDocumentId:(NSString *)documentId;
- (void)setDuration:(double)duration forDocumentId:(NSString *)documentId;
- (void)setTimePlaybackStart:(BOOL)timePlaybackStart forDocumentId:(NSString *)documentId;

@end
