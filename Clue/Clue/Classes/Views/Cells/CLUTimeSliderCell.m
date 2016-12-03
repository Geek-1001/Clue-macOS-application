//
//  CLUTimeSliderCell.m
//  Clue
//
//  Created by Ahmed Sulaiman on 11/27/16.
//  Copyright © 2016 Ahmed Sulaiman. All rights reserved.
//

#import "CLUTimeSliderCell.h"

@implementation CLUTimeSliderCell

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    _backgroundColor = [NSColor blackColor];
    _selectedBackgroundColor = [NSColor whiteColor];
    return self;
}

- (void)drawKnob:(NSRect)knobRect {
    [super drawKnob:NSMakeRect(knobRect.origin.x, knobRect.origin.y, 0, 0)];
}

- (void)drawBarInside:(NSRect)rect flipped:(BOOL)flipped {
    rect.size.height = 8.0;
    // Bar radius
    CGFloat barRadius = 0;
    // Knob position depending on control min/max value and current control value.
    CGFloat value = ([self doubleValue]  - [self minValue]) / ([self maxValue] - [self minValue]);
    // Final Left Part Width
    CGFloat finalWidth = value * ([[self controlView] frame].size.width - 8);
    // Left Part Rect
    NSRect leftRect = rect;
    leftRect.size.width = finalWidth;
    // Draw Left Part
    NSBezierPath* bg = [NSBezierPath bezierPathWithRoundedRect: rect xRadius: barRadius yRadius: barRadius];
    [_backgroundColor setFill];
    [bg fill];
    // Draw Right Part
    NSBezierPath* active = [NSBezierPath bezierPathWithRoundedRect: leftRect xRadius: barRadius yRadius: barRadius];
    [_selectedBackgroundColor setFill];
    [active fill];
}

@end
