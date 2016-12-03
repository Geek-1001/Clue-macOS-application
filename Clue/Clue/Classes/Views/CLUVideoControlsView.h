//
//  CLUVideoControlsView.h
//  Clue
//
//  Created by Ahmed Sulaiman on 11/27/16.
//  Copyright © 2016 Ahmed Sulaiman. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CLUVideoControlsView : NSView

@property (nonatomic, readonly) double currentTime; // in seconds

- (BOOL)isPlayButtonPlay;
- (void)forceTogglePlayButtonState;
- (void)setPlayButtonTarget:(id)target action:(SEL)action;
- (void)setTimeSliderTarget:(id)target action:(SEL)action;
- (void)setEnable:(BOOL)enable;
- (void)setVideoDuration:(double)duration;
- (void)setCurrentTime:(double)time;

@end
