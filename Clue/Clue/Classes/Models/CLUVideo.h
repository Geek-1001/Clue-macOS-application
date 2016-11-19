//
//  CLUVideo.h
//  Clue
//
//  Created by Ahmed Sulaiman on 11/20/16.
//  Copyright © 2016 Ahmed Sulaiman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface CLUVideo : NSObject

typedef NS_ENUM(NSInteger, CLUVideoStatus) {
    CLUVideoStatusUnknown,
    CLUVideoStatusPlayable,
    CLUVideoStatusUnplayable,
    CLUVideoStatusNoVideoTracks
};

@property (nonatomic, readonly) NSURL *fileURL;
@property (nonatomic, readonly) NSSize videoSize;
@property (nonatomic, readonly) AVURLAsset *asset;
@property (nonatomic, readonly) CLUVideoStatus videoStatus;

- (instancetype)initWithURL:(NSURL *)fileURL;
- (void)configureVideoWithCompletion:(void (^)(CLUVideoStatus status))completion;

@end
