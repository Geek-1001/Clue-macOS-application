//
//  CLUOutlineViewDataItem.h
//  Clue
//
//  Created by Ahmed Sulaiman on 1/24/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CLUOutlineViewDataItem <NSObject>

typedef NS_ENUM(NSInteger, CLUOutlineViewDataItemType) {
    // View Types
    CLUOutlineViewDataUIViewItem,
    CLUOutlineViewDataUILabelItem,
    CLUOutlineViewDataUIButtonItem,
    CLUOutlineViewDataUIImageViewItem,
    CLUOutlineViewDataUISearchViewItem,
    CLUOutlineViewDataUITableViewItem,
    CLUOutlineViewDataUITextFieldItem,
    CLUOutlineViewDataUIWindowItem,
    CLUOutlineViewDataUIWebViewItem,
    CLUOutlineViewDataUISwitchItem,
    CLUOutlineViewDataUISliderItem,
    
    // Property Types
    CLUOutlineViewDataPropertyColorItem,
    CLUOutlineViewDataPropertyFontItem,
    CLUOutlineViewDataPropertyFrameItem,
    CLUOutlineViewDataPropertyHeightItem,
    CLUOutlineViewDataPropertyWidthItem,
    CLUOutlineViewDataPropertyXItem,
    CLUOutlineViewDataPropertyYItem,
    CLUOutlineViewDataPropertyLayoutMarginItem,
    CLUOutlineViewDataPropertyLayoutMarginTopItem,
    CLUOutlineViewDataPropertyLayoutMarginBottomItem,
    CLUOutlineViewDataPropertyLayoutMarginRightItem,
    CLUOutlineViewDataPropertyLayoutMarginLeftItem,
    CLUOutlineViewDataPropertyTextItem,
    
    // Other
    CLUOutlineViewDataSubviewsArrayItem,
    CLUOutlineViewDataPropertiesArrayItem,
    CLUOutlineViewDataUndefinedPropertyItem,
    CLUOutlineViewDataUndefinedItem
};

- (NSInteger)numberOfChildren;
- (BOOL)isItemExpandable;
- (id _Nonnull)childAtIndex:(NSInteger)index;

- (NSString * _Nonnull)itemName;
- (CLUOutlineViewDataItemType)itemType;

@end
