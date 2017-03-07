//
//  CLUTimeRelatedModuleViewController.m
//  Clue
//
//  Created by Ahmed Sulaiman on 2/4/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import "CLUTimeRelatedModuleViewController.h"
#import "CLUTimeDistributionController.h"
#import "CLUTableRowView.h"
#import "NSMutableArray+CLUMutableArrayAdditions.h"
#import <Carbon/Carbon.h>
#import "NSColor+CLUStyleAdditions.h"

#define kDefaultOutlineViewRowHeight 20

@interface CLUTimeRelatedModuleViewController ()

@end

@implementation CLUTimeRelatedModuleViewController

#pragma mark - Initialization

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (!self) {
        return nil;
    }
    [[CLUTimeDistributionController sharedController] registerHandler:self];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setWantsLayer:YES];
    [self.view.layer setBackgroundColor:[[NSColor clu_backgroundLight] CGColor]];
}

- (void)keyDown:(NSEvent *)event {
    if (!_outlineViewReference) {
        return;
    }
    
    NSEventModifierFlags currentEventFlags = [NSEvent modifierFlags];
    if (event.keyCode == kVK_ANSI_C && currentEventFlags == NSEventModifierFlagCommand) {
        id<CLUOutlineViewDataItem> item = [_outlineViewReference itemAtRow:[_outlineViewReference selectedRow]];
        NSPasteboard *generalPasteboard = [NSPasteboard generalPasteboard];
        [generalPasteboard declareTypes:@[NSStringPboardType] owner:nil];
        [generalPasteboard setString:[item itemName] forType:NSStringPboardType];
    }
}

#pragma mark - Utils

- (void)configureStyleForOutlineView:(inout NSOutlineView *)outlineView
                       andScrollView:(inout NSScrollView *)scrollView {
    [scrollView setBackgroundColor:[NSColor clu_backgroundLight]];
    [outlineView setBackgroundColor:scrollView.backgroundColor];
    outlineView.dataSource = self;
    outlineView.delegate = self;
}

// TODO: refactor. Method is too huge. Think about better approach of mapping image names and enum types
- (NSImage *)imageForItemType:(CLUOutlineViewDataItemType)itemType {
    NSString *imageName;
    switch (itemType) {
        case CLUOutlineViewDataNetworkUndefinedItem: imageName = @"undefined-network-entity-icon";
            break;
        case CLUOutlineViewDataNetworkPropertyAllHeadersItem: imageName = @"all-headers-network-property-icon";
            break;
        case CLUOutlineViewDataNetworkPropertyDataItem: imageName = @"data-network-property-icon";
            break;
        case CLUOutlineViewDataNetworkPropertyErrorItem: imageName = @"error-network-property-icon";
            break;
        case CLUOutlineViewDataNetworkPropertyHTTPMethodItem: imageName = @"http-method-network-property-icon";
            break;
        case CLUOutlineViewDataNetworkPropertyRequestItem: imageName = @"request-network-property-icon";
            break;
        case CLUOutlineViewDataNetworkPropertyResponseItem: imageName = @"response-network-property-icon";
            break;
        case CLUOutlineViewDataNetworkPropertyStatusItem: imageName = @"status-code-network-property-icon";
            break;
        case CLUOutlineViewDataNetworkPropertyTypeItem: imageName = @"type-network-property-icon";
            break;
        case CLUOutlineViewDataNetworkPropertyURLItem: imageName = @"url-network-property-icon";
            break;
        case CLUOutlineViewDataUndefinedPropertyItem: imageName = @"undefined-property-icon";
            break;
        case CLUOutlineViewDataNetworkReceiveCompleteItem: imageName = @"complete-network-entity-icon";
            break;
        case CLUOutlineViewDataNetworkReceiveRedirectItem: imageName = @"receive-redirect-network-entity-icon";
            break;
        case CLUOutlineViewDataNetworkReceiveDataItem: imageName = @"receive-data-network-entity-icon";
            break;
        case CLUOutlineViewDataUIViewItem: imageName = @"uiview-icon";
            break;
        case CLUOutlineViewDataSubviewsArrayItem: imageName = @"subviews-icon";
            break;
        case CLUOutlineViewDataPropertiesArrayItem: imageName = @"properties-icon";
            break;
        case CLUOutlineViewDataUILabelItem: imageName = @"uilabel-icon";
            break;
        case CLUOutlineViewDataUIButtonItem: imageName = @"uibutton-icon";
            break;
        case CLUOutlineViewDataUIImageViewItem: imageName = @"uiimageview-icon";
            break;
        case CLUOutlineViewDataUISearchViewItem: imageName = @"uisearchview-icon";
            break;
        case CLUOutlineViewDataUITableViewItem: imageName = @"uitableview-icon";
            break;
        case CLUOutlineViewDataUITextFieldItem: imageName = @"uitextfield-icon";
            break;
        case CLUOutlineViewDataUIWindowItem: imageName = @"uiwindow-icon";
            break;
        case CLUOutlineViewDataUIWebViewItem: imageName = @"uiwebview-icon";
            break;
        case CLUOutlineViewDataUISwitchItem: imageName = @"uiswitch-icon";
            break;
        case CLUOutlineViewDataUISliderItem: imageName = @"uislider-icon";
            break;
        case CLUOutlineViewDataPropertyColorItem: imageName = @"color-property-icon";
            break;
        case CLUOutlineViewDataPropertyFontItem: imageName = @"font-property-icon";
            break;
        case CLUOutlineViewDataPropertyFrameItem: imageName = @"frame-property-icon";
            break;
        case CLUOutlineViewDataPropertyHeightItem: imageName = @"height-property-icon";
            break;
        case CLUOutlineViewDataPropertyWidthItem: imageName = @"width-property-icon";
            break;
        case CLUOutlineViewDataPropertyLayoutMarginItem: imageName = @"layout-margin-property-icon";
            break;
        case CLUOutlineViewDataPropertyLayoutMarginTopItem: imageName = @"layout-margins-top-property-icon";
            break;
        case CLUOutlineViewDataPropertyLayoutMarginBottomItem: imageName = @"layout-margins-bottom-property-icon";
            break;
        case CLUOutlineViewDataPropertyLayoutMarginRightItem: imageName = @"layout-margins-right-property-icon";
            break;
        case CLUOutlineViewDataPropertyLayoutMarginLeftItem: imageName = @"layout-margins-left-property-icon";
            break;
        case CLUOutlineViewDataPropertyTextItem: imageName = @"text-property-icon";
            break;
        case CLUOutlineViewDataPropertyXItem: imageName = @"x-property-icon";
            break;
        case CLUOutlineViewDataPropertyYItem: imageName = @"y-property-icon";
            break;
        case CLUOutlineViewDataInteractionUndefinedItem: imageName = @"touch-interaction-property-icon";
            break;
        case CLUOutlineViewDataInteractionTouchCountPropertyItem: imageName = @"touch-count-interaction-property-icon";
            break;
        case CLUOutlineViewDataInteractionBeganItem: imageName = @"touch-began-interaction-property-icon";
            break;
        case CLUOutlineViewDataInteractionEndedItem: imageName = @"touch-ended-interaction-property-icon";
            break;
        case CLUOutlineViewDataInteractionMovedItem: imageName = @"touch-moved-interaction-property-icon";
            break;
        default:
            return nil;
    }
    return [NSImage imageNamed:imageName];
}

#pragma mark - Outline View Data Source

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id<CLUOutlineViewDataItem>)item {
    return (item == nil) ? 1 : [item numberOfChildren];
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id<CLUOutlineViewDataItem>)item {
    return (item == nil) ? YES : [item isItemExpandable];
}

- (id<CLUOutlineViewDataItem>)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id<CLUOutlineViewDataItem>)item {
    return (item == nil) ? _rootOutlineViewObject : [item childAtIndex:index];
}

#pragma mark - Outline View Delegate

- (CGFloat)outlineView:(NSOutlineView *)outlineView heightOfRowByItem:(id<CLUOutlineViewDataItem>)item {
    return kDefaultOutlineViewRowHeight;
}

- (NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(NSTableColumn *)tableColumn item:(id<CLUOutlineViewDataItem>)item {
    static NSString *rowIdentifier = @"cell_identifier";
    CLUTableRowView *tableViewRow = [outlineView makeViewWithIdentifier:rowIdentifier
                                                                  owner:self];
    if (tableViewRow == nil) {
        tableViewRow = [[CLUTableRowView alloc] initWithFrame:
                        NSMakeRect(0, 0, self.view.frame.size.width, kDefaultOutlineViewRowHeight)];
        tableViewRow.identifier = rowIdentifier;
    }
    
    CLUOutlineViewDataItemType itemType = [item itemType];
    [tableViewRow setText:[item itemName]];
    [tableViewRow setImage:[self imageForItemType:itemType]];
    
    return tableViewRow;
}

#pragma mark - Time Distribution Delegate

- (void)timeDidChangeTo:(double)time {
    NSLog(@"Warning: Should be implemented in child classes");
}

#pragma mark - Time Related Module Delegate

- (void)timeRelatedModule:(CLUViewStructure *)module didChangeWithTimestamp:(NSInteger)timestamp {
    NSLog(@"Warning: Should be implemented in child classes");
}

#pragma mark - Dealloc

- (void)dealloc {
    [[CLUTimeDistributionController sharedController] unregisterHandler:self];
}

@end
