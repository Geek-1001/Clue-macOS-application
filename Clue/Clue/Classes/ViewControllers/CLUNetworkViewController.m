//
//  CLUNetworkViewController.m
//  Clue
//
//  Created by Ahmed Sulaiman on 1/31/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import "CLUNetworkViewController.h"
#import "CLUNetwork.h"
#import "CLUTimeDistributionDelegate.h"
#import "CLUTimeRelatedModuleDelegate.h"
#import "CLUTimeDistributionController.h"
#import "CLUTableRowView.h"

#define kDefaultOutlineViewRowHeight 20

@interface CLUNetworkViewController () <NSOutlineViewDataSource, NSOutlineViewDelegate, CLUTimeDistributionDelegate, CLUTimeRelatedModuleDelegate>

@property (nonatomic) CLUNetwork *network;
@property (weak) IBOutlet NSScrollView *scrollView;
@property (weak) IBOutlet NSOutlineView *outlineView;

@end

@implementation CLUNetworkViewController

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
    _network = document.network;
    _network.delegate = self;
    [self configureTableView];    
}

- (void)configureTableView {
    [_scrollView setBackgroundColor:[NSColor colorWithRed:63/255.0 green:63/255.0 blue:63/255.0 alpha:1]];
    [_outlineView setBackgroundColor:_scrollView.backgroundColor];
    _outlineView.dataSource = self;
    _outlineView.delegate = self;
}

// TODO: Refactor. This method is too huge as well as in View Structure View Controller
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
    return (item == nil) ? _network.rootNetworkEntitiesArray : [item childAtIndex:index];
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
    [_network updateCurrentTimestamp:timeInSeconds];
}

#pragma mark - Time Related Module Delegate

- (void)timeRelatedModule:(CLUViewStructure *)module didChangeWithTimestamp:(NSInteger)timestamp {
    [_outlineView reloadData];
    [_outlineView expandItem:nil expandChildren:YES];
}

#pragma mark - Dealloc

- (void)dealloc {
    [[CLUTimeDistributionController sharedController] unregisterHandler:self];
}

@end
