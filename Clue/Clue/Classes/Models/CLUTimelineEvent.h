//
//  CLUTimelineEvent.h
//  Clue
//
//  Created by Ahmed Sulaiman on 2/19/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface CLUTimelineEvent : NSObject

@property (nonatomic) NSColor *color;
@property (nonatomic) NSArray<NSValue *> *rectsArray;

- (instancetype)initWithColor:(NSColor *)color andRects:(NSArray<NSValue *> *)rects;

@end
