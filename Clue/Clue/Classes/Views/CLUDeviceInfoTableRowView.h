//
//  CLUDeviceInfoTableRowView.h
//  Clue
//
//  Created by Ahmed Sulaiman on 1/22/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CLUDeviceInfoTableRowView : NSTableRowView

- (void)setAlternateRow:(BOOL)isAlternate;
- (void)setText:(NSString *)text;

@end
