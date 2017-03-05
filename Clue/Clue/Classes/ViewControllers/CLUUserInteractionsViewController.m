//
//  CLUUserInteractionsViewController.m
//  Clue
//
//  Created by Ahmed Sulaiman on 2/5/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import "CLUUserInteractionsViewController.h"
#import "CLUUserInteractions.h"

@interface CLUUserInteractionsViewController ()

@property (nonatomic) CLUUserInteractions *userInteractions;
@property (weak) IBOutlet NSScrollView *scrollView;
@property (weak) IBOutlet NSOutlineView *outlineView;

@end

@implementation CLUUserInteractionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CLUDocument *document = [self currentDocument];
    if (!document) {
        return;
    }
    _userInteractions = document.userInteractions;
    _userInteractions.delegate = self;
    self.rootOutlineViewObject = _userInteractions.rootUserIntercationsArray;
    self.outlineViewReference = _outlineView;
    
    [self configureStyleForOutlineView:_outlineView andScrollView:_scrollView];
}

#pragma mark - Time Distribution Delegate

- (void)timeDidChangeTo:(double)time {
    NSInteger timeInSeconds = ceil(time);
    [_userInteractions updateCurrentTimestamp:timeInSeconds];
}

#pragma mark - Time Related Module Delegate

- (void)timeRelatedModule:(CLUViewStructure *)module didChangeWithTimestamp:(NSInteger)timestamp {
    self.rootOutlineViewObject = _userInteractions.rootUserIntercationsArray;
    [_outlineView reloadData];
}

@end
