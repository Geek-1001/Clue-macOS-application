//
//  CLUVideoViewController.m
//  Clue
//
//  Created by Ahmed Sulaiman on 11/5/16.
//  Copyright © 2016 Ahmed Sulaiman. All rights reserved.
//

#import "CLUVideoViewController.h"
#import "CLUDocument.h"
#import "CLUVideo.h"
#import "CLUVideoControlsView.h"
#import "CLUTimeSlider.h"
#import "CLUTimeDistributionController.h"

static void *AVSPPlayerItemStatusContext = &AVSPPlayerItemStatusContext;
static void *AVSPPlayerRateContext = &AVSPPlayerRateContext;
static void *AVSPPlayerLayerReadyForDisplay = &AVSPPlayerLayerReadyForDisplay;

@interface CLUVideoViewController ()

@property (nonatomic) CLUVideo *video;

@property (weak) IBOutlet NSView *playerView;
@property (weak) IBOutlet CLUVideoControlsView *videoControls;
@property (weak) IBOutlet NSProgressIndicator *loadingIndicator;
@property (weak) IBOutlet NSTextField *infoLabel; // TODO: make separate Error/Info View to reuse across the app

@property (strong) AVPlayer *player;
@property (strong) AVPlayerLayer *playerLayer;
@property (nonatomic) double currentTime;
@property (strong) id timeObserverToken;

@end

@implementation CLUVideoViewController

#pragma mark - Initialization

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (!self) {
        return nil;
    }
    _player = [[AVPlayer alloc] init];
    [self registerNotificationObservers];
    return self;
}

#pragma mark - View Controllers' State

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setWantsLayer:YES];
    [self.view.layer setBackgroundColor:[NSColor colorWithRed:56/255.0 green:56/255.0 blue:56/255.0 alpha:1].CGColor]; // TODO: Move colours to separate class
    
    CLUDocument *document = [self currentDocument];
    if (!document) {
        return;
    }
    [self showLoading];
    _video = document.video;
    __weak CLUVideoViewController *weakSelf = self;
    [_video configureVideoWithCompletion:^(CLUVideoStatus status) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [weakSelf handleVideoWithStatus:status];
        });
    }];
}

#pragma mark - Setup

- (void)setupPlayerLayer {
    AVPlayerLayer *newPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    newPlayerLayer.frame = self.view.layer.bounds;
    newPlayerLayer.autoresizingMask = kCALayerWidthSizable | kCALayerHeightSizable;
    newPlayerLayer.hidden = YES;
    newPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    [_playerView.layer addSublayer:newPlayerLayer];
    _playerLayer = newPlayerLayer;
    
    [self addObserver:self
           forKeyPath:@"playerLayer.readyForDisplay"
              options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew
              context:AVSPPlayerLayerReadyForDisplay];
}

- (void)registerNotificationObservers {
    [self addObserver:self
           forKeyPath:@"player.rate"
              options:NSKeyValueObservingOptionNew
              context:AVSPPlayerRateContext];
    
    [self addObserver:self
           forKeyPath:@"player.currentItem.status"
              options:NSKeyValueObservingOptionNew
              context:AVSPPlayerItemStatusContext];
}

#pragma mark - Actions

- (void)playPauseAction:(NSButton *)sender {
    if (_player.rate != 1.f) {
        if (_videoControls.currentTime == [self videoDuration]) {
            [self setCurrentTime:0.f];
        }
        [self play];
    } else {
        [self pause];
    }
}

- (void)timeSliderDidDrag:(CLUTimeSlider *)timeSlider {
    [self setCurrentTime:timeSlider.doubleValue];
    if (timeSlider.isSliderMoving) {
        [self pause];
    } else {
        if (_videoControls.isPlayButtonPlay) {
            [self play];
        }
    }
}

- (void)showLoading {
    [_loadingIndicator setHidden:NO];
    [_loadingIndicator startAnimation:self];
}

- (void)hideLoading {
    [_loadingIndicator setHidden:YES];
    [_loadingIndicator stopAnimation:self];
}

- (void)showInfoLabelWithMessage:(NSString *)message {
    [_infoLabel setStringValue:message];
    [_infoLabel setHidden:NO];
}

#pragma mark - Handlers (Notifications & Observers)

- (void)handleVideoWithStatus:(CLUVideoStatus)videoStatus {
    if (videoStatus != CLUVideoStatusPlayable) {
        [self hideLoading];
        NSString *errorMessage; // TODO: move all messages to Localaizable.string
        switch (videoStatus) {
            case CLUVideoStatusUnknown:
                errorMessage = @"Undefined Error";
                break;
                
            case CLUVideoStatusUnplayable:
                errorMessage = @"Unplayable Video";
                break;
                
            case CLUVideoStatusNoVideoTracks:
                errorMessage = @"No Video Tracks Available";
                break;
                
            default:
                errorMessage = @"Undefined Error";
        }
        [self showInfoLabelWithMessage:errorMessage];
        return;
    }
    [self setupPlayerLayer];
    [_videoControls setPlayButtonTarget:self action:@selector(playPauseAction:)];
    [_videoControls setTimeSliderTarget:self action:@selector(timeSliderDidDrag:)];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:_video.asset];
    [_player replaceCurrentItemWithPlayerItem:playerItem];
    __weak CLUVideoViewController *weakSelf = self;
    [self setTimeObserverToken:[_player addPeriodicTimeObserverForInterval:CMTimeMake(1, 10) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        NSTimeInterval timeInSeconds = CMTimeGetSeconds(time);
        [weakSelf.videoControls setCurrentTime:timeInSeconds];
        [[CLUTimeDistributionController sharedController] setCurrentTime:timeInSeconds];
    }]];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context == AVSPPlayerItemStatusContext) {
        AVPlayerStatus status = [change [NSKeyValueChangeNewKey] integerValue];
        BOOL enable = NO;
        switch (status) {
            case AVPlayerItemStatusUnknown:
                [self hideLoading];
                [self showInfoLabelWithMessage:@"Undefined Error"]; // TODO: move message to Localabizable
                break;
            case AVPlayerItemStatusReadyToPlay:
                [_videoControls setVideoDuration:[self videoDuration]];
                [[CLUTimeDistributionController sharedController] setDuration:[self videoDuration]];
                enable = YES;
                break;
            case AVPlayerItemStatusFailed:
                [self hideLoading];
                [self showInfoLabelWithMessage:@"Failed To Load Video"];
                break;
        }
        [_videoControls setEnable:enable];
    } else if (context == AVSPPlayerRateContext) {
        float rate = [change [NSKeyValueChangeNewKey] floatValue];
        if (rate != 1.f) {
            if (_videoControls.currentTime == [self videoDuration] && _videoControls.isPlayButtonPlay) {
                [_videoControls forceTogglePlayButtonState];
                
                CLUTimeDistributionController *timeDistributorController = [CLUTimeDistributionController sharedController];
                [timeDistributorController setTimePlaybackStart:!timeDistributorController.timePlaybackStart];
            }
        }
    } else if (context == AVSPPlayerLayerReadyForDisplay) {
        if ([change[NSKeyValueChangeNewKey] boolValue] == YES) {
            [self hideLoading];
            [self showInfoLabelWithMessage:@"Play Video"];
            self.playerLayer.hidden = NO;
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - Utils

- (void)play {
    [_player play];
    [[CLUTimeDistributionController sharedController] setTimePlaybackStart:YES];
}

- (void)pause {
    [_player pause];
    [[CLUTimeDistributionController sharedController] setTimePlaybackStart:NO];
}

- (double)videoDuration {
    AVPlayerItem *playerItem = _player.currentItem;
    if (playerItem.status == AVPlayerItemStatusReadyToPlay) {
        return CMTimeGetSeconds(playerItem.asset.duration);
    } else {
        return 0.f;
    }
}

- (double)currentTime {
    return CMTimeGetSeconds(_player.currentTime);
}

- (void)setCurrentTime:(double)timeInSeconds {
    CMTimeScale timeScale = self.player.currentItem.asset.duration.timescale;
    CMTime time = CMTimeMakeWithSeconds(timeInSeconds, timeScale);
    [_player seekToTime:time toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
}

#pragma mark - Deallocation

- (void)dealloc {
    [_player pause];
    [_player removeTimeObserver:[self timeObserverToken]];
    _timeObserverToken = nil;
    [self removeObserver:self forKeyPath:@"player.rate"];
    [self removeObserver:self forKeyPath:@"player.currentItem.status"];
    if (_playerLayer) {
        [self removeObserver:self forKeyPath:@"playerLayer.readyForDisplay"];
    }
}

@end
