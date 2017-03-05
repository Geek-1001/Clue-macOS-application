//
//  CLUNetworkViewController.m
//  Clue
//
//  Created by Ahmed Sulaiman on 1/31/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import "CLUNetworkViewController.h"
#import "CLUNetwork.h"

@interface CLUNetworkViewController ()

@property (nonatomic) CLUNetwork *network;
@property (weak) IBOutlet NSScrollView *scrollView;
@property (weak) IBOutlet NSOutlineView *outlineView;

@end

@implementation CLUNetworkViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CLUDocument *document = [self currentDocument];
    if (!document) {
        return;
    }
    _network = document.network;
    _network.delegate = self;
    self.rootOutlineViewObject = _network.rootNetworkEntitiesArray;
    self.outlineViewReference = _outlineView;
    
    [self configureStyleForOutlineView:_outlineView andScrollView:_scrollView];
}

#pragma mark - Time Distribution Delegate

- (void)timeDidChangeTo:(double)time {
    NSInteger timeInSeconds = ceil(time);
    [_network updateCurrentTimestamp:timeInSeconds];
}

#pragma mark - Time Related Module Delegate

- (void)timeRelatedModule:(CLUViewStructure *)module didChangeWithTimestamp:(NSInteger)timestamp {
    self.rootOutlineViewObject = _network.rootNetworkEntitiesArray;
    [_outlineView reloadData];
    [_outlineView expandItem:nil expandChildren:YES];
}

@end
