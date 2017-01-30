//
//  CLUViewStructureViewController.m
//  Clue
//
//  Created by Ahmed Sulaiman on 1/24/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import "CLUViewStructureViewController.h"
#import "CLUTabBarItem.h"
#import "CLUViewStructure.h"
#import "CLUOutlineViewDataItem.h"
#import "NSMutableArray+CLUMutableArrayAdditions.h"
#import "CLUTableRowView.h"
#import "CLUTimeDistributionDelegate.h"
#import "CLUTimeRelatedModuleDelegate.h"
#import "CLUTimeDistributionController.h"

#define kDefaultOutlineViewRowHeight 20

@interface CLUViewStructureViewController () <NSOutlineViewDataSource, NSOutlineViewDelegate, CLUTimeDistributionDelegate, CLUTimeRelatedModuleDelegate>

@property (weak) IBOutlet NSScrollView *scrollView;
@property (weak) IBOutlet NSOutlineView *outlineView;
@property (nonatomic) CLUViewStructure *viewStructure;

@end

@implementation CLUViewStructureViewController

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
    [self.view.layer setBackgroundColor:[[NSColor colorWithRed:63/255.0
                                                         green:63/255.0
                                                          blue:63/255.0
                                                         alpha:1] CGColor]];
    CLUDocument *document = [self currentDocument];
    if (!document) {
        return;
    }
    _viewStructure = document.viewStructure;
    _viewStructure.delegate = self;
    [self configureTableView];
}

- (void)configureTableView {
    [_scrollView setBackgroundColor:[NSColor colorWithRed:63/255.0 green:63/255.0 blue:63/255.0 alpha:1]];
    [_outlineView setBackgroundColor:_scrollView.backgroundColor];
    
    _outlineView.dataSource = self;
    _outlineView.delegate = self;
}

// TODO: Refactor. This method is too huge.
- (NSImage *)imageForItemType:(CLUOutlineViewDataItemType)itemType {
    NSString *imageName;
    switch (itemType) {
        case CLUOutlineViewDataUIViewItem: imageName = @"uiview-icon";
            break;
        case CLUOutlineViewDataSubviewsArrayItem: imageName = @"subviews-icon";
            break;
        case CLUOutlineViewDataPropertiesArrayItem: imageName = @"properties-icon";
            break;
        case CLUOutlineViewDataUndefinedPropertyItem: imageName = @"undefined-property-icon";
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
    return (item == nil) ? [_viewStructure rootViewItem] : [item childAtIndex:index];
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
    NSInteger timeInSeconds = ceil(time);
    [_viewStructure updateCurrentTimestamp:timeInSeconds];
}

#pragma mark - Time Related Module Delegate

- (void)timeRelatedModule:(CLUViewStructure *)module didChangeWithTimestamp:(NSInteger)timestamp {
    [_outlineView reloadData];
}

#pragma mark - Dealloc

- (void)dealloc {
    [[CLUTimeDistributionController sharedController] unregisterHandler:self];
}

@end
