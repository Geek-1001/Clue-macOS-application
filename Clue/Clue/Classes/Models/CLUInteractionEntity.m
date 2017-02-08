//
//  CLUInteractionEntity.m
//  Clue
//
//  Created by Ahmed Sulaiman on 2/4/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import "CLUInteractionEntity.h"
#import "NSMutableArray+CLUMutableArrayAdditions.h"
#import "CLUUIViewProperty.h"

#define TYPE_KEY @"type"
#define TOUCHES_KEY @"touches"

@implementation CLUInteractionEntity

- (instancetype)initWithJSONRepresentation:(NSDictionary *)json {
    self = [super init];
    if (!self) {
        return nil;
    }
    _type = [json objectForKey:TYPE_KEY];
    _touches = [NSMutableArray new];
    [self extractTouchesFromJSONDictionary:json toArray:_touches];
    return self;
}

- (void)extractTouchesFromJSONDictionary:(NSDictionary *)jsonDictionary toArray:(inout NSMutableArray *)touchesArray {
    if (!jsonDictionary || !touchesArray) {
        return;
    }
    NSArray<NSDictionary *> *touchesJSONArray = [jsonDictionary objectForKey:TOUCHES_KEY];
    for (NSDictionary *touchJSONDictionary in touchesJSONArray) {
        CLUUIViewProperty *touch = [[CLUUIViewProperty alloc] initWithJSONRepresentation:touchJSONDictionary
                                                                             forRootName:@"Touch"];
        if (touch) {
            [touchesArray addObject:touch];
        }
    }
}

#pragma mark - Outline View Data Item

- (NSInteger)numberOfChildren {
    return [_touches numberOfChildren];
}

- (BOOL)isItemExpandable {
    return [_touches isItemExpandable];
}

- (id)childAtIndex:(NSInteger)index {
    return _touches[index];
}

- (NSString *)itemName {
    return _type;
}

- (CLUOutlineViewDataItemType)itemType {
    if ([_type isEqualToString:@"Moved"]) {
        return CLUOutlineViewDataInteractionMovedItem;
    } else if ([_type isEqualToString:@"Began"]) {
        return CLUOutlineViewDataInteractionBeganItem;
    } else if ([_type isEqualToString:@"Ended"]) {
        return CLUOutlineViewDataInteractionEndedItem;
    }
    return CLUOutlineViewDataInteractionUndefinedItem;
}

@end
