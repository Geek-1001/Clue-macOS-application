//
//  CLURootViewController.m
//  Clue
//
//  Created by Ahmed Sulaiman on 12/3/16.
//  Copyright © 2016 Ahmed Sulaiman. All rights reserved.
//

#import "CLURootViewController.h"

@interface CLURootViewController ()

@end

@implementation CLURootViewController

- (CLUDocument * _Nullable)currentDocument {
    NSArray<CLUDocument *> *documents = [[NSDocumentController sharedDocumentController] documents];
    if (documents.count == 0) {
        return nil;
    }
    CLUDocument *document = [documents firstObject];
    return document;
}

@end
