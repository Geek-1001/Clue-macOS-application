//
//  CLUViewStructureViewController.m
//  Clue
//
//  Created by Ahmed Sulaiman on 1/24/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import "CLUViewStructureViewController.h"
#import "CLUViewStructure.h"

@interface CLUViewStructureViewController ()

@property (weak) IBOutlet NSScrollView *scrollView;
@property (weak) IBOutlet NSOutlineView *outlineView;
@property (nonatomic) CLUViewStructure *viewStructure;

@end

@implementation CLUViewStructureViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CLUDocument *document = [self currentDocument];
    if (!document) {
        return;
    }
    _viewStructure = document.viewStructure;
    _viewStructure.delegate = self;
    self.rootOutlineViewObject = _viewStructure.rootViewItem;
    self.outlineViewReference = _outlineView;

    [self configureStyleForOutlineView:_outlineView andScrollView:_scrollView];
}

#pragma mark - Time Distribution Delegate

- (void)timeDidChangeTo:(double)time {
    NSInteger timeInSeconds = ceil(time);
    [_viewStructure updateCurrentTimestamp:timeInSeconds];
}

#pragma mark - Time Related Module Delegate

- (void)timeRelatedModule:(CLUViewStructure *)module didChangeWithTimestamp:(NSInteger)timestamp {
    self.rootOutlineViewObject = _viewStructure.rootViewItem;
    [_outlineView reloadData];
}

@end
