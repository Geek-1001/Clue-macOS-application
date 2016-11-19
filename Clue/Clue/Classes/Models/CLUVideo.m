//
//  CLUVideo.m
//  Clue
//
//  Created by Ahmed Sulaiman on 11/20/16.
//  Copyright © 2016 Ahmed Sulaiman. All rights reserved.
//

#import "CLUVideo.h"

@implementation CLUVideo

- (instancetype)initWithURL:(NSURL *)fileURL {
    self = [super init];
    if (!self || !fileURL) {
        return nil;
    }
    _fileURL = fileURL;
    return self;
}

- (void)configureVideoWithCompletion:(void (^)(CLUVideoStatus status))completion {
    _asset = [[AVURLAsset alloc] initWithURL:_fileURL options:nil];
    NSArray *assetKeysToLoadAndTest = @[@"playable", @"hasProtectedContent", @"tracks"];
    
    [_asset loadValuesAsynchronouslyForKeys:assetKeysToLoadAndTest completionHandler:^(void) {
        for (NSString *key in assetKeysToLoadAndTest) {
            NSError *error = nil;
            if ([_asset statusOfValueForKey:key error:&error] == AVKeyValueStatusFailed) {
                _videoStatus = CLUVideoStatusUnknown;
                [self performCompletion:completion withStatus:_videoStatus];
            }
        }
        
        if (![_asset isPlayable] || [_asset hasProtectedContent]) {
            _videoStatus = CLUVideoStatusUnplayable;
            [self performCompletion:completion withStatus:_videoStatus];
        }
        
        if ([[_asset tracksWithMediaType:AVMediaTypeVideo] count] != 0) {
            _videoStatus = CLUVideoStatusPlayable;
            NSArray<AVAssetTrack *> *tracks = [_asset tracks];
            if (tracks && tracks.count > 0) {
                _videoSize = tracks[0].naturalSize;
            }
        } else {
            _videoStatus = CLUVideoStatusNoVideoTracks;
        }
        
        [self performCompletion:completion withStatus:_videoStatus];
    }];
}

- (void)performCompletion:(void (^)(CLUVideoStatus status))completion withStatus:(CLUVideoStatus)status {
    if (completion) {
        completion(status);
    }
}

@end
