//
//  CLUViewStructure.m
//  Clue
//
//  Created by Ahmed Sulaiman on 1/24/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import "CLUViewStructure.h"

#define VIEW_KEY @"view"

@implementation CLUViewStructure

- (instancetype)initWithURL:(NSURL *)url {
    self = [super initWithURL:url];
    if (!self) {
        return nil;
    }
    [self JSONTimeRelatedDataFromDataItemsArray:self.rootDataItems toRootDataDictionary:self.rootDataDictionary];
    // init root view item with default value for default timestamp
    _rootViewItem = [self.rootDataDictionary objectForKey:[NSNumber numberWithInteger:self.currentTiestamp]];
    return self;
}

- (void)JSONTimeRelatedDataFromDataItemsArray:(NSMutableArray *)dataItems
                         toRootDataDictionary:(inout NSMutableDictionary *)dataDictionary {
    if (!dataItems || dataItems.count == 0 || !dataDictionary) {
        return;
    }
    for (NSDictionary *viewStateDictionary in dataItems) {
        NSInteger timestamp = [[viewStateDictionary objectForKey:TIMESTAMP_KEY] integerValue];
        CLUUIView *view = [[CLUUIView alloc] initWithJSONRepresentation:[viewStateDictionary objectForKey:VIEW_KEY]];
        NSNumber *timestampKey = [NSNumber numberWithFloat:timestamp];
        [dataDictionary setObject:view forKey:timestampKey];
    }
}

- (void)updateCurrentTimestamp:(NSInteger)timestamp {
    CLUUIView *viewForTimeStamp = [self.rootDataDictionary objectForKey:[NSNumber numberWithInteger:timestamp]];
    if (viewForTimeStamp) {
        _rootViewItem = viewForTimeStamp;
    }
    [super updateCurrentTimestamp:timestamp];
}

#pragma mark - Outline View Data Source Item

- (NSInteger)numberOfChildren {
    return 1;
}

- (BOOL)isItemExpandable {
    return YES;
}

- (id _Nonnull)childAtIndex:(NSInteger)index {
    return [self rootViewItem];
}

- (NSString * _Nonnull)itemName {
    return @"Root View";
}

- (CLUOutlineViewDataItemType)itemType {
    return CLUOutlineViewDataUndefinedItem;
}

@end
