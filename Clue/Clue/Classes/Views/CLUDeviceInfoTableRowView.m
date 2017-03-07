//
//  CLUDeviceInfoTableRowView.m
//  Clue
//
//  Created by Ahmed Sulaiman on 1/22/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import "CLUDeviceInfoTableRowView.h"
#import "CLUTextLabel.h"
#import "NSColor+CLUStyleAdditions.h"

#define kDefaultSideOffset 20

@interface CLUDeviceInfoTableRowView()
@property (nonatomic) BOOL isAlternateRow;
@end

@implementation CLUDeviceInfoTableRowView

- (instancetype)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (!self) {
        return nil;
    }
    _isAlternateRow = NO;
    return self;
}

- (void)setAlternateRow:(BOOL)isAlternate {
    _isAlternateRow = isAlternate;
}

- (void)drawBackgroundInRect:(NSRect)dirtyRect{
    if (_isAlternateRow) {
        [[NSColor colorWithWhite:0.2 alpha:1] set];
    } else {
        [[NSColor clu_backgroundLight] set];
    }
    NSRectFill(dirtyRect);
}

@end
