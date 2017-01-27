//
//  CLUViewStructure.h
//  Clue
//
//  Created by Ahmed Sulaiman on 1/24/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import "CLUTimeRelatedModule.h"
#import "CLUOutlineViewDataItem.h"
#import "CLUUIView.h"

@interface CLUViewStructure : CLUTimeRelatedModule <CLUOutlineViewDataItem>

- (CLUUIView *)rootViewItem;

@end
