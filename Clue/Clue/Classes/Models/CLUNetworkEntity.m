//
//  CLUNetworkEntity.m
//  Clue
//
//  Created by Ahmed Sulaiman on 1/30/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import "CLUNetworkEntity.h"
#import "NSMutableArray+CLUMutableArrayAdditions.h"
#import "CLUUIViewProperty.h"

#define LABEL_KEY @"label"
#define PROPERTIES_KEY @"properties"

@implementation CLUNetworkEntity

- (instancetype)initWithJSONRepresentation:(NSDictionary *)json {
    self = [super init];
    if (!self) {
        return nil;
    }
    _label = [json objectForKey:LABEL_KEY];
    _properties = [NSMutableArray new];
    [self propertiesForJSONDictionary:json toArray:_properties withLabel:_label];
    return self;
}

- (void)propertiesForJSONDictionary:(NSDictionary *)jsonDictionary
                            toArray:(inout NSMutableArray *)propertiesArray
                          withLabel:(NSString *)label {
    if (!jsonDictionary || !propertiesArray) {
        return;
    }
    NSArray<NSDictionary *> *propertiesJSONArray = [jsonDictionary objectForKey:PROPERTIES_KEY];
    for (int i = 0; i < propertiesJSONArray.count; i++) {
        NSString *arrayName = [self subproprtyItemArrayNameForLabel:label andIndex:i];
        CLUUIViewProperty *property = [[CLUUIViewProperty alloc] initWithJSONRepresentation:propertiesJSONArray[i]
                                                                                forRootName:arrayName];
        [propertiesArray addObject:property];
    }
}

// TODO: refactor. Do something with strings as a check.
- (NSString *)subproprtyItemArrayNameForLabel:(NSString *)label andIndex:(NSInteger)subpropertiesArrayIndex {
    if ([label isEqualToString:@"DidComplete"]) {
        return @"Error";
    } else if ([label isEqualToString:@"DidRedirect"]) {
        NSString *subpropertiesArrayName = @"Response";
        if (subpropertiesArrayIndex == 1) {
            subpropertiesArrayName = @"New Request";
        }
        return subpropertiesArrayName;
    } else if ([label isEqualToString:@"DidReceiveData"]) {
        return @"Data";
    } else if ([label isEqualToString:@"DidReceiveResponse"]) {
        return @"Response";
    }
    return @"Undefined";
}

#pragma mark - Outline View Data Item

- (NSInteger)numberOfChildren {
    return [_properties numberOfChildren];
}

- (BOOL)isItemExpandable {
    return [_properties isItemExpandable];
}

- (id _Nonnull)childAtIndex:(NSInteger)index {
    return [_properties childAtIndex:index];
}

- (NSString * _Nonnull)itemName {
    return _label;
}

- (CLUOutlineViewDataItemType)itemType {
    if ([_label isEqualToString:@"DidComplete"]) {
        return CLUOutlineViewDataNetworkReceiveCompleteItem;
    } else if ([_label isEqualToString:@"DidRedirect"]) {
        return CLUOutlineViewDataNetworkReceiveRedirectItem;
    } else if ([_label isEqualToString:@"DidReceiveData"]) {
        return CLUOutlineViewDataNetworkReceiveDataItem;
    } else if ([_label isEqualToString:@"DidReceiveResponse"]) {
        return CLUOutlineViewDataNetworkPropertyResponseItem;
    }
    return CLUOutlineViewDataNetworkUndefinedItem;
}

@end
