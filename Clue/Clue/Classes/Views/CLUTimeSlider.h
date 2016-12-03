//
//  CLUTimeSlider.h
//  Clue
//
//  Created by Ahmed Sulaiman on 11/27/16.
//  Copyright © 2016 Ahmed Sulaiman. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CLUTimeSlider : NSSlider

@property (nonatomic, readonly) BOOL isSliderMoving;

- (void)setBackgroundColor:(NSColor *)color;
- (void)setSelectedBackgroundColor:(NSColor *)color;

@end
