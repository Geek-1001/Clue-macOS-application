//
//  CLUNetwork.m
//  Clue
//
//  Created by Ahmed Sulaiman on 1/30/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import "CLUNetwork.h"
#import "NSMutableArray+CLUMutableArrayAdditions.h"

@implementation CLUNetwork

- (instancetype)initWithURL:(NSURL *)url {
    self = [super initWithURL:url];
    if (!self) {
        return nil;
    }
    _rootNetworkEntitiesArray = [NSMutableArray new];
    [self setupRootNetworkEntitiesArrayStyle];
    [self JSONTimeRelatedDataFromDataItemsArray:self.rootDataItems toRootDataDictionary:self.rootDataDictionary];
    return self;
}

- (void)JSONTimeRelatedDataFromDataItemsArray:(NSMutableArray *)dataItems
                         toRootDataDictionary:(inout NSMutableDictionary *)dataDictionary {
    if (!dataItems || dataItems.count == 0 || !dataDictionary) {
        return;
    }
    for (NSDictionary *networkDictionary in dataItems) {
        NSInteger timestamp = [[networkDictionary objectForKey:TIMESTAMP_KEY] integerValue];
        NSNumber *timestampKey = [NSNumber numberWithFloat:timestamp];
       
        CLUNetworkEntity *networkEntity = [[CLUNetworkEntity alloc] initWithJSONRepresentation:networkDictionary];
        NSMutableArray *networkEntityArrayForTimestamp = [dataDictionary objectForKey:timestampKey];
        if (!networkEntityArrayForTimestamp) {
            networkEntityArrayForTimestamp = [NSMutableArray new];
        }
        [networkEntityArrayForTimestamp addObject:networkEntity];
        [dataDictionary setObject:networkEntityArrayForTimestamp forKey:timestampKey];
    }
}

- (void)setupRootNetworkEntitiesArrayStyle {
    [_rootNetworkEntitiesArray setArrayName:@"Network Interactions"];
    [_rootNetworkEntitiesArray setArrayType:[NSNumber numberWithInteger:CLUOutlineViewDataNetworkUndefinedItem]];
}

- (void)updateCurrentTimestamp:(NSInteger)timestamp {
    NSMutableArray *networkEntitiesArrayForTimestamp = [self.rootDataDictionary objectForKey:[NSNumber numberWithInteger:timestamp]];
    if (networkEntitiesArrayForTimestamp) {
        _rootNetworkEntitiesArray = networkEntitiesArrayForTimestamp;
        [self setupRootNetworkEntitiesArrayStyle];
    }
    [super updateCurrentTimestamp:timestamp];
}

@end
