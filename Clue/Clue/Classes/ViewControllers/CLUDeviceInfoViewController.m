//
//  CLUDeviceInfoViewController.m
//  Clue
//
//  Created by Ahmed Sulaiman on 1/22/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import "CLUDeviceInfoViewController.h"
#import "CLUDeviceInfo.h"
#import "CLUDeviceInfoTableRowView.h"
#import "NSColor+CLUStyleAdditions.h"

#define kDefaultTableRowHeight 36

@interface CLUDeviceInfoViewController () <NSTableViewDelegate, NSTableViewDataSource>

@property (nonatomic) CLUDeviceInfo *deviceInfo;
@property (weak) IBOutlet NSScrollView *scrollView;
@property (weak) IBOutlet NSTableView *tableView;
@property (nonatomic) NSArray *deviceInfoRowTitlesArray;

@end

@implementation CLUDeviceInfoViewController

#pragma mark - Initialization

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (!self) {
        return nil;
    }
    _deviceInfoRowTitlesArray = @[@"Battery State", @"System Name",
                                  @"Model", @"System Version",
                                  @"Battery Level", @"Name", @"Identifier"];
    return self;
}

#pragma mark - View Controllers' State

- (void)viewDidLoad {
    [super viewDidLoad];    
    [self.view setWantsLayer:YES];
    [self.view.layer setBackgroundColor:[[NSColor clu_backgroundLight] CGColor]];
    CLUDocument *document = [self currentDocument];
    if (!document) {
        return;
    }
    _deviceInfo = document.deviceInfo;
    [self configureTableView];    
}

#pragma mark - View Configuration

- (void)configureTableView {
    [_scrollView setBackgroundColor:[NSColor clu_backgroundLight]];
    [_tableView setBackgroundColor:_scrollView.backgroundColor];
    _tableView.allowsEmptySelection = YES;    
    _tableView.selectionHighlightStyle = NSTableViewSelectionHighlightStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
}

#pragma mark Table View Delegate

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    return kDefaultTableRowHeight;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    // To make NSTableView - view based instead of cell based
    return nil;
}

- (NSTableRowView *)tableView:(NSTableView *)tableView rowViewForRow:(NSInteger)row{
    static NSString *rowIdentifier = @"cell_identifier";
    CLUDeviceInfoTableRowView *tableViewRow = [tableView makeViewWithIdentifier:rowIdentifier
                                                                          owner:self];
    if (tableViewRow == nil) {
        tableViewRow = [[CLUDeviceInfoTableRowView alloc] initWithFrame:
                        NSMakeRect(0, 0, self.view.frame.size.width, kDefaultTableRowHeight)];
        tableViewRow.identifier = rowIdentifier;
    }
    NSString *rowTitle = _deviceInfoRowTitlesArray[row];
    NSString *rowValue = [self deviceInfoValueForRow:row];
    [tableViewRow setText:[NSString stringWithFormat:@"%@ : %@", rowTitle, rowValue]];
    [tableViewRow setAlternateRow:(row % 2)];
    return tableViewRow;
}

#pragma mark Table View Data Source

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return _deviceInfoRowTitlesArray.count;
}

#pragma mark Utils

// TODO: Refactor. Come up with something more clever
- (NSString *)deviceInfoValueForRow:(NSInteger)row {
    NSString *valueForRow;
    switch (row) {
        case 0:
            valueForRow = [_deviceInfo batteryStateString];
            break;
        case 1:
            valueForRow = _deviceInfo.systemName;
            break;
        case 2:
            valueForRow = _deviceInfo.model;
            break;
        case 3:
            valueForRow = _deviceInfo.systemVersion;
            break;
        case 4:
            valueForRow = [NSString stringWithFormat:@"%2.f", _deviceInfo.batteryLevel];
            break;
        case 5:
            valueForRow = _deviceInfo.name;
            break;
        case 6:
            valueForRow = _deviceInfo.identifierForVendor;
            break;
        default:
            valueForRow = @"";
    }
    return valueForRow;
}

@end
