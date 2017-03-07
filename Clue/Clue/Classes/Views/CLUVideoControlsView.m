//
//  CLUVideoControlsView.m
//  Clue
//
//  Created by Ahmed Sulaiman on 11/27/16.
//  Copyright © 2016 Ahmed Sulaiman. All rights reserved.
//

#import "CLUVideoControlsView.h"
#import "CLUTimeSlider.h"
#import "CLUTextLabel.h"
#import "NSColor+CLUStyleAdditions.h"

@interface CLUVideoControlsView()
@property (nonatomic) NSButton *playButton;
@property (nonatomic) CLUTimeSlider *timeSlider;
@property (nonatomic) CLUTextLabel *timeLabel;
@end

@implementation CLUVideoControlsView

#pragma mark - Initialization

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (!self) {
        return nil;
    }
    [self setupPlayButton];
    [self setupTimeSlider];
    [self setupTimeLabel];
    return self;
}

- (void)setupPlayButton {
    _playButton = [[NSButton alloc] init];
    NSImage *playIcon = [NSImage imageNamed:@"PlayIcon"];
    NSImage *pauseIcon = [NSImage imageNamed:@"PauseIcon"];
    [_playButton setImage:playIcon];
    [_playButton setAlternateImage:pauseIcon];
    NSButtonCell *playButtonCell = (NSButtonCell *) _playButton.cell;
    playButtonCell.showsStateBy = NSContentsCellMask;
    playButtonCell.highlightsBy = NSNoCellMask;
    [_playButton setFrameSize:playIcon.size];
    [_playButton setFrameOrigin:NSMakePoint(20, 15)];
    [_playButton setFocusRingType:NSFocusRingTypeNone];
    _playButton.bordered = NO;
    [self addSubview:_playButton];
}

- (void)setupTimeSlider {
    CGSize rootSize = self.frame.size;
    NSInteger height = 8;
    _timeSlider = [[CLUTimeSlider alloc] initWithFrame:NSMakeRect(0, rootSize.height - height, rootSize.width, height)];
    [_timeSlider setBackgroundColor:[NSColor clearColor]];
    [_timeSlider setSelectedBackgroundColor:[NSColor clu_accentRed]];
    [self addSubview:_timeSlider];
}

- (void)setupTimeLabel {
    CGFloat x = _playButton.frame.origin.x + _playButton.frame.size.width + 15;
    CGFloat y = _playButton.frame.origin.y;
    _timeLabel = [[CLUTextLabel alloc] initWithFrame:NSMakeRect(x, y, 0, 0)];
    [_timeLabel setTextColor:[NSColor clu_textLight]];
    _timeLabel.stringValue = @"00:00 / 00:00 "; // TODO: fix sizing of time label
    [_timeLabel sizeToFit];
    [self addSubview:_timeLabel];
}

#pragma mark - Public Interface

- (void)setEnable:(BOOL)enable {
    _playButton.enabled = enable;
    _timeSlider.enabled = enable;
}

#pragma mark Time Slider

- (void)setTimeSliderTarget:(id)target action:(SEL)action {
    if (target && action) {
        _timeSlider.target = target;
        _timeSlider.action = action;
    }
}

- (void)setVideoDuration:(double)duration {
    [_timeSlider setMaxValue:duration];
}

- (void)setCurrentTime:(double)time {
    _timeSlider.doubleValue = time;
    _currentTime = time;
    [self setTimeLabelForTime:time];
}

#pragma mark Play Button

- (void)setPlayButtonTarget:(id)target action:(SEL)action {
    if (target && action) {
        [_playButton setTarget:target];
        [_playButton setAction:action];
    }
}

- (BOOL)isPlayButtonPlay {
    return _playButton.state == 1 ? YES : NO;
}

- (void)forceTogglePlayButtonState {
    NSInteger currentState = _playButton.state;
    [_playButton setState:currentState == 0 ? 1 : 0];
}

#pragma mark - Utils

- (void)setTimeLabelForTime:(double)time {
    NSDate *currentTimeDate = [NSDate dateWithTimeIntervalSince1970:time];
    NSDate *maxTimeDate = [NSDate dateWithTimeIntervalSince1970:_timeSlider.maxValue];
    
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"mm:ss"];
    [timeFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    NSString *currentTime = [timeFormatter stringFromDate:currentTimeDate];
    NSString *maxTime = [timeFormatter stringFromDate:maxTimeDate];
    
    NSString *timeLabelStringValue = [NSString stringWithFormat:@"%@ / %@", currentTime, maxTime];
    
    _timeLabel.stringValue = timeLabelStringValue;
}

#pragma mark - Drawing

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    [[NSColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5] set];
    NSRectFill(dirtyRect);
}

@end
