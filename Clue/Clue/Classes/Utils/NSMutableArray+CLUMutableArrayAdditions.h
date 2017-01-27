//
//  NSMutableArray+CLUMutableArrayAdditions.h
//  Clue
//
//  Created by Ahmed Sulaiman on 1/25/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLUOutlineViewDataItem.h"

@interface NSMutableArray (CLUMutableArrayAdditions) <CLUOutlineViewDataItem>

@property (nonatomic) NSString *arrayName;
@property (nonatomic) NSNumber *arrayType;

@end
