//
//  NSColor+CLUStyleAdditions.m
//  Clue
//
//  Created by Ahmed Sulaiman on 3/7/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import "NSColor+CLUStyleAdditions.h"

@implementation NSColor (CLUStyleAdditions)

+ (NSColor *)clu_backgroundLight {
    return [NSColor colorWithRed:63/255.0 green:63/255.0 blue:63/255.0 alpha:1];
}

+ (NSColor *)clu_backgroundDark {
    return [NSColor colorWithRed:56/255.0 green:56/255.0 blue:56/255.0 alpha:1];
}

+ (NSColor *)clu_borderDark {
    return [NSColor colorWithRed:24/255.0 green:24/255.0 blue:24/255.0 alpha:1];
}

+ (NSColor *)clu_accentRed {
    return [NSColor colorWithRed:251/255.0 green:105/255.0 blue:97/255.0 alpha:1];
}

+ (NSColor *)clu_textLight {
    return [NSColor whiteColor];
}

@end
