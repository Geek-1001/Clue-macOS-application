//
//  CLUTimeRelatedModule.m
//  Clue
//
//  Created by Ahmed Sulaiman on 1/24/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import "CLUTimeRelatedModule.h"

@interface CLUTimeRelatedModule()

@end

@implementation CLUTimeRelatedModule

- (instancetype)initWithURL:(NSURL *)url {
    self = [super init];
    if (!self || !url) {
        return nil;
    }
    _rootDataItems = [self processJsonFileWithURL:url];
    if (!_rootDataItems) {
        return nil;
    }
    _currentTiestamp = 0;
    _rootDataDictionary = [NSMutableDictionary new];
    return self;
}

- (NSMutableArray *)processJsonFileWithURL:(NSURL *)url {
    NSError *error = nil;
    NSString *jsonString = [NSString stringWithContentsOfFile:url.path
                                                     encoding:NSUTF8StringEncoding
                                                        error:&error];
    if (error) {
        // TODO: add json error handling
        return nil;
    }
    NSArray<NSString *> *separatedJsonString = [jsonString componentsSeparatedByString:@"\n"];
    NSMutableArray<NSDictionary *> *dataItemsArray = [NSMutableArray new];
    
    for (NSString *separatedJsonStringItem in separatedJsonString) {
        // Skip empty strings from json file
        if (separatedJsonStringItem.length == 0) {
            continue;
        }
        NSDictionary *jsonItem = [self convertJsonString:separatedJsonStringItem];
        if (!jsonItem) {
            // There should be no invalid json items at all. If single json item is invalid - fail initialization
            return nil;
        }
        [dataItemsArray addObject:jsonItem];
    }
    
    return dataItemsArray;
}

- (NSDictionary *)convertJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSError *error;
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    if (error) {
        // TODO: handler json parsing error
        return nil;
    }
    return jsonDictionary;
}

- (void)updateCurrentTimestamp:(NSInteger)timestamp {
    _currentTiestamp = timestamp;
    NSNumber *timestampKey = [NSNumber numberWithInteger:timestamp];
    if ([_rootDataDictionary objectForKey:timestampKey] && _delegate) {
//        CLUTimeRelatedModule *moduleCopy = [self copy]; // TODO: implement (id)copyWithZone:(NSZone *)zone
        [_delegate timeRelatedModule:self didChangeWithTimestamp:timestamp];
    }
}

@end
