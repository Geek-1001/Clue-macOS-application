//
//  CLUTimeDistributionController.m
//  Clue
//
//  Created by Ahmed Sulaiman on 1/29/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import "CLUTimeDistributionController.h"

@interface CLUTimeDistributionController()

@property (nonatomic) NSMutableArray *handlersArray;

@end

@implementation CLUTimeDistributionController

#pragma mark - Initialization

+ (instancetype)sharedController {
    static CLUTimeDistributionController *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CLUTimeDistributionController alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    _handlersArray = [NSMutableArray new];
    _currentTime = 0;
    return self;
}

#pragma mark - Public Interface

- (void)registerHandler:(id<CLUTimeDistributionDelegate>)handler {
    if (!handler) {
        return;
    }
    [_handlersArray addObject:handler];
}

- (void)unregisterHandler:(id<CLUTimeDistributionDelegate>)handler {
    if (!handler) {
        return;
    }
    [_handlersArray removeObject:handler];
}

- (void)setCurrentTime:(double)currentTime {
    _currentTime = currentTime;
    @synchronized (self) {
        [self notifyHandlersTimeDidChangeTo:currentTime withDuration:-1];
    }
}

- (void)setDuration:(double)duration {
    _duration = duration;
    @synchronized (self) {
        [self notifyHandlersTimeDidChangeTo:-1 withDuration:duration];
    }
}

- (void)setTimePlaybackStart:(BOOL)timePlaybackStart {
    _timePlaybackStart = timePlaybackStart;
    @synchronized (self) {
        [self notifyHandlersTimePlaybackStart:timePlaybackStart];
    }
}

#pragma mark - Handlers Notify Methods

- (void)notifyHandlersTimeDidChangeTo:(double)time withDuration:(double)duration {
    for (id<CLUTimeDistributionDelegate> handler in _handlersArray) {
        if (time >= 0) {
            [handler timeDidChangeTo:time];
        }
        if (duration >= 0 && [handler respondsToSelector:@selector(timeWillStartWithDuration:)]) {
            [handler timeWillStartWithDuration:duration];
        }
    }
}

- (void)notifyHandlersTimePlaybackStart:(BOOL)timePlaybackStart {
    for (id<CLUTimeDistributionDelegate> handler in _handlersArray) {
        if (timePlaybackStart && [handler respondsToSelector:@selector(timePlaybackDidStart)]) {
            [handler timePlaybackDidStart];
        } else if ([handler respondsToSelector:@selector(timePlaybackDidStop)]) {
            [handler timePlaybackDidStop];
        }
    }
}

@end
