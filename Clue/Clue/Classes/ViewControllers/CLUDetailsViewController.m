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

@interface CLUDetailsViewController () <TabsControlDataSource>

@property (weak) IBOutlet TabsControl *tabsControl;
@property (nonatomic) NSArray *tabControlItems;

@end

@implementation CLUDetailsViewController

#pragma mark - Initialization

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (!self) {
        return nil;
    }
    _tabControlItems = @[[[CLUTabBarItem alloc] initWithTitle:@"Network"],
                         [[CLUTabBarItem alloc] initWithTitle:@"User Interactions"],
                         [[CLUTabBarItem alloc] initWithTitle:@"View Structure"],
                         [[CLUTabBarItem alloc] initWithTitle:@"Device Info"]];
    return self;
}

#pragma mark - View Controllers' State

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ClueStyle *style = [[ClueStyle alloc] init];
    style.tabButtonWidth = TabWidthFlexible;
    
    _tabsControl.dataSource = self;
    _tabsControl.style = style;
    [_tabsControl reloadTabs];
}

#pragma mark - Tabs Control Data Source

- (NSInteger)tabsControlNumberOfTabs:(TabsControl * _Nonnull)control {
    return 4;
}

- (CLUTabBarItem *)tabsControl:(TabsControl * _Nonnull)control itemAtIndex:(NSInteger)index {
    return _tabControlItems[index];
}

- (NSString * _Nonnull)tabsControl:(TabsControl * _Nonnull)control titleForItem:(CLUTabBarItem *)item {
    return item.title;
}

@end
