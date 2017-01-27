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
    return self;
}

- (void)JSONTimeRelatedDataFromDataItemsArray:(NSMutableArray *)dataItems
                         toRootDataDictionary:(inout NSMutableDictionary *)dataDictionary {
    if (!dataItems || dataItems.count == 0 || !dataDictionary) {
        return;
    }
    for (NSDictionary *viewStateDictionary in dataItems) {
        CGFloat timestamp = [[viewStateDictionary objectForKey:TIMESTAMP_KEY] floatValue];
        CLUUIView *view = [[CLUUIView alloc] initWithJSONRepresentation:[viewStateDictionary objectForKey:VIEW_KEY]];
        [dataDictionary setObject:view forKey:[NSNumber numberWithFloat:timestamp]];
    }
}

- (CLUUIView *)rootViewItem {
    return [self.rootDataDictionary objectForKey:@0];
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
