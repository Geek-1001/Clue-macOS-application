//
//  CLUUIView.m
//  Clue
//
//  Created by Ahmed Sulaiman on 1/25/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import "CLUUIView.h"
#import "NSString+NSStringAddition.h"

#define SUBVIEWS_KEY @"subviews"
#define PROPERTIES_KEY @"properties"
#define CLASS_KEY @"class"

@implementation CLUUIView

- (instancetype)initWithJSONRepresentation:(NSDictionary *)json {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _properties = [NSMutableArray new];
    _subviews = [NSMutableArray new];
    
    _properties.arrayName = @"Properties";
    _subviews.arrayName = @"Subviews";
    [_subviews setArrayType:[NSNumber numberWithInt:CLUOutlineViewDataSubviewsArrayItem]];
    [_properties setArrayType:[NSNumber numberWithInt:CLUOutlineViewDataPropertiesArrayItem]];
    
    [self propertiesForJSONDictionary:json toArray:_properties];
    [self subviewsForJSONDictionary:json toArray:_subviews];
    _className = [json objectForKey:CLASS_KEY];
    
    return self;
}

- (void)propertiesForJSONDictionary:(NSDictionary *)jsonDictionary toArray:(inout NSMutableArray *)propertiesArray {
    if (!jsonDictionary || !propertiesArray) {
        return;
    }
    
    NSDictionary *propertiesJSONDictionary = [jsonDictionary objectForKey:PROPERTIES_KEY];
    NSArray *allPropertiesJSONKeys = [propertiesJSONDictionary allKeys];
    NSArray *allPropertiesJSONValues = [propertiesJSONDictionary allValues];
    
    for (int i = 0; i < allPropertiesJSONKeys.count; i++) {
        CLUUIViewProperty *property;
        if ([allPropertiesJSONValues[i] isKindOfClass:[NSDictionary class]]) {
            property = [[CLUUIViewProperty alloc] initWithJSONRepresentation:allPropertiesJSONValues[i]
                                                      forRootName:allPropertiesJSONKeys[i]];
        } else {
            property = [[CLUUIViewProperty alloc] initWithName:allPropertiesJSONKeys[i]
                                                         value:allPropertiesJSONValues[i]];
        }
        if (property) {
            [propertiesArray addObject:property];
        }
    }
}

- (void)subviewsForJSONDictionary:(NSDictionary *)jsonDictionary toArray:(inout NSMutableArray *)subviewsArray {
    if (!jsonDictionary || !subviewsArray) {
        return;
    }
    
    NSArray<NSDictionary *> *subviewsJSONArray = [jsonDictionary objectForKey:SUBVIEWS_KEY];
    for (NSDictionary *subviewsJSONItem in subviewsJSONArray) {
        CLUUIView *subview = [[CLUUIView alloc] initWithJSONRepresentation:subviewsJSONItem];
        [subviewsArray addObject:subview];
    }
}

#pragma mark - Outline View Data Source Item

- (NSInteger)numberOfChildren {
    return 2;
}

- (BOOL)isItemExpandable {
    return YES;
}

- (id _Nonnull)childAtIndex:(NSInteger)index {
    return index == 0 ? _properties : _subviews;
}

- (NSString * _Nonnull)itemName {
    return _className;
}

// TODO: refactor. Put all UIKit class names into object/enum to remove string check
- (CLUOutlineViewDataItemType)itemType {
    if ([self classNameString:_className containsOfEquestTo:@"UILabel"]) {
        return CLUOutlineViewDataUILabelItem;
    } else if ([self classNameString:_className containsOfEquestTo:@"UIButton"]) {
        return CLUOutlineViewDataUIButtonItem;
    } else if ([self classNameString:_className containsOfEquestTo:@"UIImageView"]) {
        return CLUOutlineViewDataUIImageViewItem;
    } else if ([self classNameString:_className containsOfEquestTo:@"UISearchView"]) {
        return CLUOutlineViewDataUISearchViewItem;
    } else if ([self classNameString:_className containsOfEquestTo:@"UITableView"]) {
        return CLUOutlineViewDataUITableViewItem;
    } else if ([self classNameString:_className containsOfEquestTo:@"UITextField"]) {
        return CLUOutlineViewDataUITextFieldItem;
    } else if ([self classNameString:_className containsOfEquestTo:@"UIWindow"]) {
        return CLUOutlineViewDataUIWindowItem;
    } else if ([self classNameString:_className containsOfEquestTo:@"UIWebView"]) {
        return CLUOutlineViewDataUIWebViewItem;
    } else if ([self classNameString:_className containsOfEquestTo:@"UISwitch"]) {
        return CLUOutlineViewDataUISwitchItem;
    } else if ([self classNameString:_className containsOfEquestTo:@"UISlider"]) {
        return CLUOutlineViewDataUISliderItem;
    }
    return CLUOutlineViewDataUIViewItem;
}

- (BOOL)classNameString:(NSString *)className containsOfEquestTo:(NSString *)classToCheck {
    if (!classToCheck || classToCheck.length < 2 || !className) {
        return NO;
    }
    return [className containsCaseInsensitiveString:[classToCheck substringFromIndex:2]] || [className isEqualToString:classToCheck];
}

@end
