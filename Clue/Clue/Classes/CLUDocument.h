//
//  Document.h
//  Clue
//
//  Created by Ahmed Sulaiman on 11/5/16.
//  Copyright © 2016 Ahmed Sulaiman. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CLUVideo.h"
#import "CLUDeviceInfo.h"
#import "CLUViewStructure.h"
#import "CLUNetwork.h"
#import "CLUUserInteractions.h"

@interface CLUDocument : NSDocument

@property (nonatomic, readonly) CLUVideo *video;
@property (nonatomic, readonly) CLUDeviceInfo *deviceInfo;
@property (nonatomic, readonly) CLUViewStructure *viewStructure;
@property (nonatomic, readonly) CLUNetwork *network;
@property (nonatomic, readonly) CLUUserInteractions *userInteractions;

@end

