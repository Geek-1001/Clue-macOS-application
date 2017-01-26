//
//  CLUTableRowView.m
//  Clue
//
//  Created by Ahmed Sulaiman on 1/26/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import "CLUTableRowView.h"
#import "CLUTextLabel.h"

#define kDefaultSideOffset 20

@interface CLUTableRowView()

@property (nonatomic) CLUTextLabel *textLabel;
@property (nonatomic) NSImageView *imageView;

@end

@implementation CLUTableRowView

- (instancetype)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (!self) {
        return nil;
    }
    [self setupTextLabel];
    [self setupImageView];
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

- (void)setupImageView {
    if (!_imageView) {
        _imageView = [[NSImageView alloc] initWithFrame:NSMakeRect(0, 0, 10, self.frame.size.height)];
        [self addSubview:_imageView];
    }
}

- (void)setText:(NSString *)text {
    _textLabel.stringValue = text;
    [_textLabel sizeToFit];
}

- (void)setImage:(NSImage *)image {
    [_imageView setImage:image];
}

@end
