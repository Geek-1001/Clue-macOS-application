//
//  CLUTimeSlider.m
//  Clue
//
//  Created by Ahmed Sulaiman on 11/27/16.
//  Copyright © 2016 Ahmed Sulaiman. All rights reserved.
//

#import "CLUTimeSlider.h"
#import "CLUTimeSliderCell.h"

@implementation CLUTimeSlider

- (instancetype)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (!self) {
        return nil;
    }
    self.cell = [[CLUTimeSliderCell alloc] init];
    return self;
}

- (void)setBackgroundColor:(NSColor *)color {
    ((CLUTimeSliderCell *) self.cell).backgroundColor = color;
}

- (void)setSelectedBackgroundColor:(NSColor *)color {
    ((CLUTimeSliderCell *) self.cell).selectedBackgroundColor = color;
}

- (void)mouseDown:(NSEvent *)event {
    _isSliderMoving = YES;
    [super mouseDown:event];
    _isSliderMoving = NO;
    [self sendAction:self.action to:self.target];
}

@end
