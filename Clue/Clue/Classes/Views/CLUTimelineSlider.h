//
//  CLUTimelineSlider.h
//  Clue
//
//  Created by Ahmed Sulaiman on 2/17/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define CLUTimelineNetworkColor [NSColor colorWithRed:239/255.0 green:98/255.0 blue:19/255.0 alpha:1]
#define CLUTimelineUserInteractionColor [NSColor colorWithRed:33/255.0 green:155/255.0 blue:231/255.0 alpha:1]
#define CLUTimelineViewStructureColor [NSColor colorWithRed:201/255.0 green:115/255.0 blue:184/255.0 alpha:1]

typedef NS_ENUM(NSInteger, CLUTimelineEventType) {
    CLUTimelineNetworkEvent,
    CLUTimelineUserInteractionEvent,
    CLUTimelineViewStructureEvent
};

@interface CLUTimelineSlider : NSSlider

// TODO: refactor interface duplication from TimeSlider (VideoControlsView)
- (void)setDuration:(double)duration;
- (void)setCurrentTime:(double)time;

- (void)addEventsOfType:(CLUTimelineEventType)eventType
          forTimestamps:(NSArray<NSNumber *> *)timestampsArray
              withColor:(NSColor *)eventColor;

@end
