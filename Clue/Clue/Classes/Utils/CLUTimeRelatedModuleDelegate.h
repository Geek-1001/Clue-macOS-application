//
//  CLUTimeRelatedModuleDelegate.h
//  Clue
//
//  Created by Ahmed Sulaiman on 1/29/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLUTimeRelatedModule;

@protocol CLUTimeRelatedModuleDelegate <NSObject>

- (void)timeRelatedModule:(CLUTimeRelatedModule *)module didChangeWithTimestamp:(NSInteger)timestamp; // in seconds

@end
