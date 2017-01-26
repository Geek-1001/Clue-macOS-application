//
//  CLUTimeRelatedModule.h
//  Clue
//
//  Created by Ahmed Sulaiman on 1/24/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLUJSONDeserializable.h"

#define TIMESTAMP_KEY @"timestamp"

@interface CLUTimeRelatedModule : NSObject

@property (nonatomic, readonly) NSMutableArray<NSDictionary *> *rootDataItems;
@property (nonatomic) NSMutableDictionary *rootDataDictionary;

- (instancetype)initWithURL:(NSURL *)url;

@end
