//
//  CLUUIViewProperty.m
//  Clue
//
//  Created by Ahmed Sulaiman on 1/25/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import "CLUUIViewProperty.h"
#import "NSString+NSStringAddition.h"

@implementation CLUUIViewProperty

#pragma mark - Initialization

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (!self) {
        return nil;
    }
    _name = name;
    _values = [NSMutableArray new];
    return self;
}

- (instancetype)initWithName:(NSString *)name value:(id)value {
    self = [self initWithName:name];
    [_values addObject:value];
    return self;
}

- (instancetype)initWithJSONRepresentation:(NSDictionary *)json forRootName:(NSString *)name {
    self = [self initWithName:name];
    [self subPropertiesFromJSONDictionary:json toArray:_values];
    return self;
}

#pragma mark - JSON Parsing

- (void)subPropertiesFromJSONDictionary:(NSDictionary *)jsonDictionary toArray:(inout NSMutableArray *)valuesArray {
    if (!jsonDictionary || !valuesArray) {
        return;
    }
    
    NSArray *allJSONKeys = [jsonDictionary allKeys];
    NSArray *allJSONValues = [jsonDictionary allValues];
    
    for (int i = 0; i < allJSONKeys.count; i++) {
        CLUUIViewProperty *property;
        if ([allJSONValues[i] isKindOfClass:[NSDictionary class]]) {
            property = [[CLUUIViewProperty alloc] initWithJSONRepresentation:allJSONValues[i]
                                                                 forRootName:allJSONKeys[i]];
        } else {
            property = [[CLUUIViewProperty alloc] initWithName:allJSONKeys[i]
                                                         value:allJSONValues[i]];
        }
        if (property) {
            [valuesArray addObject:property];
        }
    }
}

- (BOOL)hasSingleNestedValue {
    return _values.count == 1 && [[_values firstObject] isKindOfClass:[CLUUIViewProperty class]];
}

#pragma mark - Outline View Data Source Item

- (NSInteger)numberOfChildren {
    return _values.count == 1 && ![self hasSingleNestedValue] ? 0 : _values.count;
}

- (BOOL)isItemExpandable {
    return [self hasSingleNestedValue] || _values.count > 1;
}

- (id _Nonnull)childAtIndex:(NSInteger)index {
    return _values[index];
}

- (NSString * _Nonnull)itemName {
    if (_values.count > 1 || [self hasSingleNestedValue]) {
        return _name;
    } else if (_values.count > 0 && ![self hasSingleNestedValue]) {
        return [NSString stringWithFormat:@"%@: %@", _name, _values[0]];
    } else {
        return [NSString stringWithFormat:@"%@: No Value", _name];
    }
}

// TODO: refactor. Method is too huge
- (CLUOutlineViewDataItemType)itemType {
    if ([_name containsCaseInsensitiveString:@"color"]) {
        return CLUOutlineViewDataPropertyColorItem;
    } else if ([_name containsCaseInsensitiveString:@"font"]) {
        return CLUOutlineViewDataPropertyFontItem;
    } else if ([_name containsCaseInsensitiveString:@"frame"]) {
        return CLUOutlineViewDataPropertyFrameItem;
    } else if ([_name containsCaseInsensitiveString:@"height"]) {
        return CLUOutlineViewDataPropertyHeightItem;
    } else if ([_name containsCaseInsensitiveString:@"width"]) {
        return CLUOutlineViewDataPropertyWidthItem;
    } else if ([_name containsCaseInsensitiveString:@"layoutMargins"]) {
        return CLUOutlineViewDataPropertyLayoutMarginItem;
    } else if ([_name containsCaseInsensitiveString:@"top"]) {
        return CLUOutlineViewDataPropertyLayoutMarginTopItem;
    } else if ([_name containsCaseInsensitiveString:@"bottom"]) {
        return CLUOutlineViewDataPropertyLayoutMarginBottomItem;
    } else if ([_name containsCaseInsensitiveString:@"left"]) {
        return CLUOutlineViewDataPropertyLayoutMarginLeftItem;
    } else if ([_name containsCaseInsensitiveString:@"right"]) {
        return CLUOutlineViewDataPropertyLayoutMarginRightItem;
    } else if ([_name containsCaseInsensitiveString:@"text"]  ||
               [_name containsCaseInsensitiveString:@"title"] ||
               [_name containsCaseInsensitiveString:@"stringValue"]) {
        return CLUOutlineViewDataPropertyTextItem;
    } else if ([_name isEqualToString:@"x"]) {
        return CLUOutlineViewDataPropertyXItem;
    } else if ([_name isEqualToString:@"y"]) {
        return CLUOutlineViewDataPropertyYItem;
    } else if ([_name isEqualToString:@"statusCode"]) {
        return CLUOutlineViewDataNetworkPropertyStatusItem;
    } else if ([_name containsCaseInsensitiveString:@"header"]) {
        return CLUOutlineViewDataNetworkPropertyAllHeadersItem;
    } else if ([_name isEqualToString:@"HTTPMethod"]) {
        return CLUOutlineViewDataNetworkPropertyHTTPMethodItem;
    } else if ([_name containsCaseInsensitiveString:@"url"]) {
        return CLUOutlineViewDataNetworkPropertyURLItem;
    } else if ([_name containsCaseInsensitiveString:@"type"]) {
        return CLUOutlineViewDataNetworkPropertyTypeItem;
    }
    
    return CLUOutlineViewDataUndefinedPropertyItem;
}

@end
