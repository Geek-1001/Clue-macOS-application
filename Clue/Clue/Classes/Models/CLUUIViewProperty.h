//
//  CLUUIViewProperty.h
//  Clue
//
//  Created by Ahmed Sulaiman on 1/25/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLUOutlineViewDataItem.h"

@interface CLUUIViewProperty : NSObject <CLUOutlineViewDataItem>

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSMutableArray *values;

- (instancetype)initWithName:(NSString *)name value:(id)value;
- (instancetype)initWithJSONRepresentation:(NSDictionary *)json forRootName:(NSString *)name;

@end
