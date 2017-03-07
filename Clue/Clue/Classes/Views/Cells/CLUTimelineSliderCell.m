//
//  CLUTimelineSliderCell.m
//  Clue
//
//  Created by Ahmed Sulaiman on 2/17/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import "CLUTimelineSliderCell.h"
#import "NSColor+CLUStyleAdditions.h"

@implementation CLUTimelineSliderCell

- (void)drawKnob:(NSRect)knobRect {
    [super drawKnob:NSMakeRect(knobRect.origin.x, knobRect.origin.y, 0, 0)];
}

// TODO: define "Magic Numbers"!
- (void)drawBarInside:(NSRect)rect flipped:(BOOL)flipped {
    CGFloat sliderValue = ([self doubleValue]  - [self minValue]) / ([self maxValue] - [self minValue]);
    CGFloat knobXValue = sliderValue * ([[self controlView] frame].size.width - 8);
    
    rect.size.height = 100.0;
    rect.origin.y = rect.origin.y - 40;
    CGFloat knobYValue = 0;
    NSBezierPath *backgroundPath = [NSBezierPath bezierPathWithRoundedRect:NSMakeRect(knobXValue, knobYValue, 1, 120) xRadius:0 yRadius:0];
    [[NSColor clu_accentRed] setFill];
    [backgroundPath fill];

    NSBezierPath *trianglePath = [NSBezierPath bezierPath];
    [trianglePath moveToPoint:NSMakePoint(knobXValue, 10)];
    [trianglePath lineToPoint:NSMakePoint(knobXValue - 7, knobYValue)];
    [trianglePath lineToPoint:NSMakePoint(knobXValue + 7, knobYValue)];
    [trianglePath closePath];
    [[NSColor clu_accentRed] set];
    [trianglePath fill];
}

@end
