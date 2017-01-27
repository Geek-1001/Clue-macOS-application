//
//  CLUUIView.h
//  Clue
//
//  Created by Ahmed Sulaiman on 1/25/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLUJSONDeserializable.h"
#import "CLUOutlineViewDataItem.h"
#import "NSMutableArray+CLUMutableArrayAdditions.h"
#import "CLUUIViewProperty.h"

@interface CLUUIView : NSObject <CLUJSONDeserializable, CLUOutlineViewDataItem>

@property (nonatomic, readonly) NSString *className;
@property (nonatomic, readonly) NSMutableArray *properties;
@property (nonatomic, readonly) NSMutableArray *subviews;

@end
