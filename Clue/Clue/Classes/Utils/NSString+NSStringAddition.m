//
//  NSString+NSStringAddition.m
//  Clue
//
//  Created by Ahmed Sulaiman on 1/27/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import "NSString+NSStringAddition.h"

@implementation NSString (NSStringAddition)

- (BOOL)containsCaseInsensitiveString:(NSString *)string {
    return [self rangeOfString:string options:NSCaseInsensitiveSearch].length != 0;
}

@end
