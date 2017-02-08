//
//  CLUInteractionEntity.h
//  Clue
//
//  Created by Ahmed Sulaiman on 2/4/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLUOutlineViewDataItem.h"
#import "CLUJSONDeserializable.h"

@interface CLUInteractionEntity : NSObject <CLUOutlineViewDataItem, CLUJSONDeserializable>

@property (nonatomic, readonly) NSString *type;
@property (nonatomic, readonly) NSMutableArray *touches;

@end
