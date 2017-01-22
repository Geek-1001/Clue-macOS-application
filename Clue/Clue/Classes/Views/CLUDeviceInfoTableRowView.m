//
//  CLUDeviceInfoTableRowView.m
//  Clue
//
//  Created by Ahmed Sulaiman on 1/22/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import "CLUDeviceInfoTableRowView.h"
#import "CLUTextLabel.h"

#define kDefaultSideOffset 20

@interface CLUDeviceInfoTableRowView()

@property (nonatomic) BOOL isAlternateRow;
@property (nonatomic) CLUTextLabel *textLabel;

@end

@implementation CLUDeviceInfoTableRowView

- (instancetype)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (!self) {
        return nil;
    }
    _isAlternateRow = NO;
    [self setupTextLabel];
    return self;
}

- (void)setupTextLabel {
    if (!_textLabel) {
        _textLabel = [[CLUTextLabel alloc] initWithFrame:CGRectZero];
        _textLabel.textColor = [NSColor whiteColor];
        _textLabel.font = [NSFont systemFontOfSize:13];
        _textLabel.stringValue = @"Default value";
        [_textLabel sizeToFit];
        [self addSubview:_textLabel];
    }
    
    int x = kDefaultSideOffset;
    int y = ceil(self.frame.size.height/2 - _textLabel.frame.size.height/2); // center vertical
    [_textLabel setFrameOrigin:NSMakePoint(x, y)];
}

- (void)setAlternateRow:(BOOL)isAlternate {
    _isAlternateRow = isAlternate;
}

- (void)setText:(NSString *)text {
    _textLabel.stringValue = text;
    [_textLabel sizeToFit];
}

- (void)drawBackgroundInRect:(NSRect)dirtyRect{
    if (_isAlternateRow) {
        [[NSColor colorWithWhite:0.2 alpha:1] set];
    } else {
        [[NSColor colorWithRed:63/255.0 green:63/255.0 blue:63/255.0 alpha:1] set];
    }
    NSRectFill(dirtyRect);
}

@end
