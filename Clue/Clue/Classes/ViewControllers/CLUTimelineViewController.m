//
//  CLUTimelineViewController.m
//  Clue
//
//  Created by Ahmed Sulaiman on 2/17/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import "CLUTimelineViewController.h"
#import "CLUTextLabel.h"
#import "CLUTimelineSlider.h"
#import "CLUTimeDistributionController.h"
#import "CLUTimeDistributionDelegate.h"

@interface CLUTimelineViewController () <CLUTimeDistributionDelegate>

@property (weak) IBOutlet CLUTextLabel *timeLabel;
@property (weak) IBOutlet CLUTimelineSlider *timelineSlider;

@end

@implementation CLUTimelineViewController

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (!self) {
        return nil;
    }
    [[CLUTimeDistributionController sharedController] registerHandler:self];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setWantsLayer:YES];
    [self.view.layer setBackgroundColor:[[NSColor colorWithRed:56/255.0
                                                         green:56/255.0
                                                          blue:56/255.0
                                                         alpha:1] CGColor]];
    [_timelineSlider setEnabled:NO]; // Prevent user from interactions with slider
}

#pragma mark - Time Distribution Delegate

- (void)timeDidChangeTo:(double)time {
    [_timelineSlider setCurrentTime:time];
    [self setTimeLabelForTime:time];
}

- (void)timeWillStartWithDuration:(double)duration {
    [_timelineSlider setDuration:duration];
    
    CLUDocument *document = [self currentDocument];
    if (!document) {
        return;
    }
    [_timelineSlider addEventsOfType:CLUTimelineNetworkEvent
                       forTimestamps:document.network.rootDataDictionary.allKeys
                           withColor:CLUTimelineNetworkColor];
    [_timelineSlider addEventsOfType:CLUTimelineUserInteractionEvent
                       forTimestamps:document.userInteractions.rootDataDictionary.allKeys
                           withColor:CLUTimelineUserInteractionColor];
    [_timelineSlider addEventsOfType:CLUTimelineViewStructureEvent
                       forTimestamps:document.viewStructure.rootDataDictionary.allKeys
                           withColor:CLUTimelineViewStructureColor];
}

#pragma mark - Utils

// TODO: refactor copy-paste from Video Controls
- (void)setTimeLabelForTime:(double)time {
    NSDate *currentTimeDate = [NSDate dateWithTimeIntervalSince1970:time];
    NSDate *maxTimeDate = [NSDate dateWithTimeIntervalSince1970:_timelineSlider.maxValue];
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"mm:ss"];
    [timeFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSString *currentTime = [timeFormatter stringFromDate:currentTimeDate];
    NSString *maxTime = [timeFormatter stringFromDate:maxTimeDate];
    NSString *timeLabelStringValue = [NSString stringWithFormat:@"%@ / %@", currentTime, maxTime];
    _timeLabel.stringValue = timeLabelStringValue;
}

#pragma mark - Dealloc

- (void)dealloc {
    [[CLUTimeDistributionController sharedController] unregisterHandler:self];
}

@end
