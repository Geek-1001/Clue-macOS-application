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

@interface CLUDocument : NSDocument

@property (nonatomic, readonly) CLUVideo *video;
@property (nonatomic, readonly) CLUDeviceInfo *deviceInfo;

@end

