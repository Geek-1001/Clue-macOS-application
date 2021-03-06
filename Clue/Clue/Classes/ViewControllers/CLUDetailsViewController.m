//
//  CLUDetailsViewController.m
//  Clue
//
//  Created by Ahmed Sulaiman on 1/20/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import "CLUDetailsViewController.h"
#import "KPCTabsControl/KPCTabsControl-Swift.h"
#import "CLUTabBarItem.h"
#import "CLUDeviceInfoViewController.h"
#import "CLUViewStructureViewController.h"
#import "CLUNetworkViewController.h"
#import "CLUUserInteractionsViewController.h"
#import "NSColor+CLUStyleAdditions.h"

@interface CLUDetailsViewController () <TabsControlDataSource, TabsControlDelegate>

@property (weak) IBOutlet TabsControl *tabsControl;
@property (nonatomic) NSArray *tabControlItems;
@property (weak) IBOutlet CLUDeviceInfoViewController *deviceInfoViewController;
@property (weak) IBOutlet CLUViewStructureViewController *viewStructureViewController;
@property (weak) IBOutlet CLUNetworkViewController *networkViewController;
@property (weak) IBOutlet CLUUserInteractionsViewController *userInteractionsViewController;

@end

@implementation CLUDetailsViewController

#pragma mark - Initialization

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (!self) {
        return nil;
    }
    _tabControlItems = @[[[CLUTabBarItem alloc] initWithTitle:@"Network" forType:CLUTabBarItemNetwork],
                         [[CLUTabBarItem alloc] initWithTitle:@"User Interactions" forType:CLUTabBarItemUserInetraction],
                         [[CLUTabBarItem alloc] initWithTitle:@"View Structure" forType:CLUTabBarItemViewStructure],
                         [[CLUTabBarItem alloc] initWithTitle:@"Device Info" forType:CLUTabBarItemDeviceInfo]];
    return self;
}

#pragma mark - View Controllers' State

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSeparators];
    
    ClueStyle *style = [[ClueStyle alloc] init];
    style.tabButtonWidth = TabWidthFlexible;
    
    _tabsControl.dataSource = self;
    _tabsControl.delegate = self;
    _tabsControl.style = style;
    [_tabsControl reloadTabs];
    [_tabsControl selectItemAtIndex:0];
}

// TODO: refactor. Add searators from Interface Builder
- (void)setupSeparators {
    NSView *verticalSeparator = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, 1, self.view.frame.size.height)];
    [verticalSeparator setWantsLayer:YES];
    verticalSeparator.layer.backgroundColor = [[NSColor clu_borderDark] CGColor];
    [self.view addSubview:verticalSeparator];
    NSView *horizontalSeparator = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, self.view.frame.size.width, 1)];
    [horizontalSeparator setWantsLayer:YES];
    horizontalSeparator.layer.backgroundColor = [[NSColor clu_borderDark] CGColor];
    [self.view addSubview:horizontalSeparator];
}

#pragma mark - Tabs Control Data Source

- (NSInteger)tabsControlNumberOfTabs:(TabsControl * _Nonnull)control {
    return _tabControlItems.count;
}

- (CLUTabBarItem *)tabsControl:(TabsControl * _Nonnull)control itemAtIndex:(NSInteger)index {
    return _tabControlItems[index];
}

- (NSString * _Nonnull)tabsControl:(TabsControl * _Nonnull)control titleForItem:(CLUTabBarItem *)item {
    return item.title;
}

#pragma mark - Tabs Control Delegate

- (void)tabsControlDidChangeSelection:(TabsControl *)control item:(CLUTabBarItem *)item {
    [_deviceInfoViewController.view setHidden:(item.type != CLUTabBarItemDeviceInfo)];
    [_viewStructureViewController.view setHidden:(item.type != CLUTabBarItemViewStructure)];
    [_networkViewController.view setHidden:(item.type != CLUTabBarItemNetwork)];
    [_userInteractionsViewController.view setHidden:(item.type != CLUTabBarItemUserInetraction)];
}

@end
