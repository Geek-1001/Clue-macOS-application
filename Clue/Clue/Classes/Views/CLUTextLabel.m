//
//  CLUTextLabel.m
//  Clue
//
//  Created by Ahmed Sulaiman on 11/27/16.
//  Copyright © 2016 Ahmed Sulaiman. All rights reserved.
//

#import "CLUTextLabel.h"

@implementation CLUTextLabel

- (instancetype)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if(!self) {
        return nil;
    }
    [self setBezeled:NO];
    [self setDrawsBackground:NO];
    [self setEditable:NO];
    [self setSelectable:NO];
    return self;
}


@end
