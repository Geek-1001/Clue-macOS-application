//
//  CLUUserInteractions.m
//  Clue
//
//  Created by Ahmed Sulaiman on 2/4/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import "CLUUserInteractions.h"
#import "NSMutableArray+CLUMutableArrayAdditions.h"
#import "CLUInteractionEntity.h"

@implementation CLUUserInteractions

- (instancetype)initWithURL:(NSURL *)url {
    self = [super initWithURL:url];
    if (!self) {
        return nil;
    }
    _rootUserIntercationsArray = [NSMutableArray new];
    [self setupRootUserInteractionsArrayStyle];
    [self extractJSONTimeRelatedDataFromDataItemsArray:self.rootDataItems toRootDataDictionary:self.rootDataDictionary];
    return self;
}

- (void)extractJSONTimeRelatedDataFromDataItemsArray:(NSMutableArray *)dataItems toRootDataDictionary:(inout NSMutableDictionary *)dataDictionary {
    if (!dataItems || dataItems.count == 0 || !dataDictionary) {
        return;
    }
    for (NSDictionary *interactionsDictionary in dataItems) {
        NSInteger timestamp = [[interactionsDictionary objectForKey:TIMESTAMP_KEY] integerValue];
        NSNumber *timestampKey = [NSNumber numberWithFloat:timestamp];
        CLUInteractionEntity *intercationEntity = [[CLUInteractionEntity alloc] initWithJSONRepresentation:interactionsDictionary];
        
        NSMutableArray *interactionkEntityArrayForTimestamp = [dataDictionary objectForKey:timestampKey];
        if (!interactionkEntityArrayForTimestamp) {
            interactionkEntityArrayForTimestamp = [NSMutableArray new];
        }
        [interactionkEntityArrayForTimestamp addObject:intercationEntity];
        
        [dataDictionary setObject:interactionkEntityArrayForTimestamp forKey:timestampKey];
    }
}

- (void)setupRootUserInteractionsArrayStyle {
    [_rootUserIntercationsArray setArrayName:@"User Interactions"];
    [_rootUserIntercationsArray setArrayType:[NSNumber numberWithInteger:CLUOutlineViewDataInteractionUndefinedItem]];
}

- (void)updateCurrentTimestamp:(NSInteger)timestamp {
    NSMutableArray *networkEntitiesArrayForTimestamp = [self.rootDataDictionary objectForKey:[NSNumber numberWithInteger:timestamp]];
    if (networkEntitiesArrayForTimestamp) {
        _rootUserIntercationsArray = networkEntitiesArrayForTimestamp;
        [self setupRootUserInteractionsArrayStyle];
    }
    [super updateCurrentTimestamp:timestamp];
}

@end
