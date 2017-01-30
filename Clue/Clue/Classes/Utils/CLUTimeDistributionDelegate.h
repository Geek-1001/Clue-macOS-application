//
//  CLUTimeDistributionDelegate.h
//  Clue
//
//  Created by Ahmed Sulaiman on 1/29/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CLUTimeDistributionDelegate <NSObject>

@required
- (void)timeDidChangeTo:(double)time;
@optional
- (void)timeWillStartWithDuration:(double)duration;
- (void)timePlaybackDidStart;
- (void)timePlaybackDidStop;

@end
