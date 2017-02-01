//
//  CLUNetworkEntity.h
//  Clue
//
//  Created by Ahmed Sulaiman on 1/30/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLUJSONDeserializable.h"
#import "CLUOutlineViewDataItem.h"

@interface CLUNetworkEntity : NSObject <CLUJSONDeserializable, CLUOutlineViewDataItem>

@property (nonatomic, readonly) NSString *label;
@property (nonatomic, readonly) NSMutableArray *properties;

@end
