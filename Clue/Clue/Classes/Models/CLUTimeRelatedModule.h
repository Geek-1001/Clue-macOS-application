//
//  CLUTimeRelatedModule.h
//  Clue
//
//  Created by Ahmed Sulaiman on 1/24/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLUJSONDeserializable.h"
#import "CLUTimeRelatedModuleDelegate.h"

#define TIMESTAMP_KEY @"timestamp"

@interface CLUTimeRelatedModule : NSObject

@property (nonatomic, weak) id<CLUTimeRelatedModuleDelegate> delegate;
@property (nonatomic, readonly) NSInteger currentTiestamp; // in seconds
@property (nonatomic, readonly) NSMutableArray<NSDictionary *> *rootDataItems;
@property (nonatomic) NSMutableDictionary *rootDataDictionary;

- (instancetype)initWithURL:(NSURL *)url;
- (void)updateCurrentTimestamp:(NSInteger)timestamp;

@end
