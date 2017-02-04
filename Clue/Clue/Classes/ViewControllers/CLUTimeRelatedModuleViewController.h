//
//  CLUTimeRelatedModuleViewController.h
//  Clue
//
//  Created by Ahmed Sulaiman on 2/4/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import "CLURootViewController.h"
#import "CLUTimeDistributionDelegate.h"
#import "CLUTimeRelatedModuleDelegate.h"
#import "CLUOutlineViewDataItem.h"

@interface CLUTimeRelatedModuleViewController : CLURootViewController <NSOutlineViewDataSource, NSOutlineViewDelegate, CLUTimeDistributionDelegate, CLUTimeRelatedModuleDelegate>

@property (nonatomic) id<CLUOutlineViewDataItem> rootOutlineViewObject;

- (void)configureStyleForOutlineView:(inout NSOutlineView *)outlineView andScrollView:(inout NSScrollView *)scrollView;

@end
