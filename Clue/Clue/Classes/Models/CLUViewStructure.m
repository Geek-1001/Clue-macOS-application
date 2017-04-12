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
    // If there is no data in main dictionary - fail initialization, since view structure can't be empty
    if (self.rootDataDictionary.count == 0) {
        return nil;
    }
    // init root view item with default value for default timestamp (at start self.currentTiestamp = 0)
    _rootViewItem = [self.rootDataDictionary objectForKey:[NSNumber numberWithInteger:self.currentTiestamp]];
    return self;
}

- (void)JSONTimeRelatedDataFromDataItemsArray:(NSMutableArray *)dataItems
                         toRootDataDictionary:(inout NSMutableDictionary *)dataDictionary {
    if (!dataItems || dataItems.count == 0 || !dataDictionary) {
        return;
    }
    for (NSDictionary *viewStateDictionary in dataItems) {
        id timestampObject = [viewStateDictionary objectForKey:TIMESTAMP_KEY];
        NSDictionary *viewJSONRepresentationDictionary = [viewStateDictionary objectForKey:VIEW_KEY];
        // Continue to the next json object from file if there is no timestamp and view data in current one
        if (!timestampObject || !viewJSONRepresentationDictionary) {
            continue;
        }
        NSNumber *timestampKey = [NSNumber numberWithFloat:[timestampObject integerValue]];
        CLUUIView *view = [[CLUUIView alloc] initWithJSONRepresentation:viewJSONRepresentationDictionary];
        if (view && timestampKey) {
            [dataDictionary setObject:view forKey:timestampKey];
        }
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
