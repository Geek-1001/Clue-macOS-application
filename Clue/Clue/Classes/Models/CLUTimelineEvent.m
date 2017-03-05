//
//  CLUTimelineEvent.m
//  Clue
//
//  Created by Ahmed Sulaiman on 2/19/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import "CLUTimelineEvent.h"

@implementation CLUTimelineEvent

- (instancetype)initWithColor:(NSColor *)color andRects:(NSArray<NSValue *> *)rects {
    self = [super init];
    if (!self) {
        return nil;
    }
    _color = color;
    _rectsArray = rects;
    return self;
}

@end
