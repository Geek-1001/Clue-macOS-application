//
//  CLUOutlineViewDataItem.h
//  Clue
//
//  Created by Ahmed Sulaiman on 1/24/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CLUOutlineViewDataItem <NSObject>

// TODO: Move to separate file
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
    
    // Network Types
    CLUOutlineViewDataNetworkUndefinedItem,
    CLUOutlineViewDataNetworkReceiveDataItem,
    CLUOutlineViewDataNetworkReceiveRedirectItem,
    CLUOutlineViewDataNetworkReceiveCompleteItem,
    CLUOutlineViewDataNetworkPropertyAllHeadersItem,
    CLUOutlineViewDataNetworkPropertyDataItem,
    CLUOutlineViewDataNetworkPropertyErrorItem,
    CLUOutlineViewDataNetworkPropertyHTTPMethodItem,
    CLUOutlineViewDataNetworkPropertyRequestItem,
    CLUOutlineViewDataNetworkPropertyResponseItem,
    CLUOutlineViewDataNetworkPropertyStatusItem,
    CLUOutlineViewDataNetworkPropertyTypeItem,
    CLUOutlineViewDataNetworkPropertyURLItem,
    
    // Interaction Types
    CLUOutlineViewDataInteractionUndefinedItem,
    CLUOutlineViewDataInteractionTouchCountPropertyItem,
    CLUOutlineViewDataInteractionBeganItem,
    CLUOutlineViewDataInteractionEndedItem,
    CLUOutlineViewDataInteractionMovedItem,
    
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
