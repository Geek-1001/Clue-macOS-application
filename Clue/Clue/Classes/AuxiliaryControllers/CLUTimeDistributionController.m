//
//  CLUTimeDistributionController.m
//  Clue
//
//  Created by Ahmed Sulaiman on 1/29/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import "CLUTimeDistributionController.h"

#pragma mark - Time Distribution Item class

@interface CLUTimeDistributionItem : NSObject
@property (nonatomic, weak) id<CLUTimeDistributionDelegate> handler;
@property (nonatomic) NSString *documentId;
@end

@implementation CLUTimeDistributionItem
@end

#pragma mark - Time Distribution Controller class

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

- (void)registerHandler:(id<CLUTimeDistributionDelegate>)handler withDocumentID:(NSString *)documentId {
    if (!handler || !documentId) {
        return;
    }
    
    CLUTimeDistributionItem *handlerItem = [CLUTimeDistributionItem new];
    handlerItem.handler = handler;
    handlerItem.documentId = documentId;
    
    [_handlersArray addObject:handlerItem];
}

- (void)unregisterHandler:(id<CLUTimeDistributionDelegate>)handler {
    if (!handler) {
        return;
    }
    for (CLUTimeDistributionItem *item in _handlersArray) {
        // Remove nil handlers, since they are already deallocated
        if (item.handler == nil) {
            [_handlersArray removeObject:item];
            return;
        }
    }
}

- (void)setCurrentTime:(double)currentTime forDocumentId:(NSString *)documentId {
    _currentTime = currentTime;
    @synchronized (self) {
        [self notifyHandlersTimeDidChangeTo:currentTime withDuration:-1 forDocumentId:documentId];
    }
}

- (void)setDuration:(double)duration forDocumentId:(NSString *)documentId {
    _duration = duration;
    @synchronized (self) {
        [self notifyHandlersTimeDidChangeTo:-1 withDuration:duration forDocumentId:documentId];
    }
}

- (void)setTimePlaybackStart:(BOOL)timePlaybackStart forDocumentId:(NSString *)documentId {
    _timePlaybackStart = timePlaybackStart;
    @synchronized (self) {
        [self notifyHandlersTimePlaybackStart:timePlaybackStart forDocumentId:documentId];
    }
}

#pragma mark - Handlers Notify Methods

- (void)notifyHandlersTimeDidChangeTo:(double)time withDuration:(double)duration forDocumentId:(NSString *)documentId {
    for (CLUTimeDistributionItem *item in _handlersArray) {
        if ([item.documentId isEqualToString:documentId]) {
            if (time >= 0) {
                [item.handler timeDidChangeTo:time];
            }
            if (duration >= 0 && [item.handler respondsToSelector:@selector(timeWillStartWithDuration:)]) {
                [item.handler timeWillStartWithDuration:duration];
            }
        }
    }
}

- (void)notifyHandlersTimePlaybackStart:(BOOL)timePlaybackStart forDocumentId:(NSString *)documentId {
    for (CLUTimeDistributionItem *item in _handlersArray) {
        if ([item.documentId isEqualToString:documentId]) {
            if (timePlaybackStart && [item.handler respondsToSelector:@selector(timePlaybackDidStart)]) {
                [item.handler timePlaybackDidStart];
            } else if ([item.handler respondsToSelector:@selector(timePlaybackDidStop)]) {
                [item.handler timePlaybackDidStop];
            }
        }
    }
}

@end
