//
//  CLUTimelineSlider.m
//  Clue
//
//  Created by Ahmed Sulaiman on 2/17/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import "CLUTimelineSlider.h"
#import "CLUTimelineSliderCell.h"
#import "CLUTimelineEvent.h"

// Change this value to redistribute height between doifferent items (if new event type has been added)
#define TOTAL_EVENTS_NUMBER 3

@interface CLUTimelineSlider()
@property (nonatomic) NSMutableArray *eventsDrawingArray;
@end

@implementation CLUTimelineSlider

#pragma mark - Initialization

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (!self) {
        return nil;
    }
    self.cell = [[CLUTimelineSliderCell alloc] init];
    _eventsDrawingArray = [NSMutableArray new];
    return self;
}

#pragma mark - Public Interface

- (void)addEventsOfType:(CLUTimelineEventType)eventType
          forTimestamps:(NSArray<NSNumber *> *)timestampsArray
              withColor:(NSColor *)eventColor {
    if (!_eventsDrawingArray) {
        return;
    }
    NSArray *eventRectArray = [self eventsRectsFromTimestampsArray:timestampsArray
                                                      forEventType:eventType];
    CLUTimelineEvent *event = [[CLUTimelineEvent alloc] initWithColor:eventColor
                                                             andRects:eventRectArray];
    [_eventsDrawingArray addObject:event];
}

- (NSArray *)eventsRectsFromTimestampsArray:(NSArray<NSNumber *> *)timestampsArray
                               forEventType:(CLUTimelineEventType)eventType {
    CGFloat eventWidthPerSecond = self.frame.size.width / self.maxValue;
    CGFloat eventHeight = eventWidthPerSecond;
    CGFloat additionalOffsetBetweenEvents = (self.frame.size.height - (eventHeight * TOTAL_EVENTS_NUMBER)) / TOTAL_EVENTS_NUMBER;
    CGFloat eventY = 0;
    switch (eventType) {
        case CLUTimelineNetworkEvent:
            eventY = 0;
            break;
        case CLUTimelineUserInteractionEvent:
            eventY = additionalOffsetBetweenEvents + eventHeight;
            break;
        case CLUTimelineViewStructureEvent:
            eventY = (additionalOffsetBetweenEvents * 2) + (eventHeight * 2);
            break;
    }
    NSMutableArray *eventsRectArray = [NSMutableArray new];
    for (NSNumber *timestamp in timestampsArray) {
        CGFloat eventX = (timestamp.integerValue * eventWidthPerSecond) - eventWidthPerSecond;
        NSRect eventRect = NSMakeRect(eventX, eventY, eventWidthPerSecond, eventHeight);
        [eventsRectArray addObject:[NSValue valueWithRect:eventRect]];
    }
    
    return eventsRectArray;
}

- (void)setDuration:(double)duration {
    self.maxValue = duration;
}

- (void)setCurrentTime:(double)time {
    self.doubleValue = time;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];    
    if (!_eventsDrawingArray || _eventsDrawingArray.count == 0) {
        return;
    }
    for (CLUTimelineEvent *event in _eventsDrawingArray) {
        for (NSValue *rectValue in event.rectsArray) {
            NSBezierPath *eventPath = [NSBezierPath bezierPathWithRect:rectValue.rectValue];
            [event.color set];
            [eventPath fill];
        }
    }
}
 
@end
