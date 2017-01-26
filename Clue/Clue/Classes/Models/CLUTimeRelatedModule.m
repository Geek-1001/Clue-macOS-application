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
    if (!self) {
        return nil;
    }
    _rootDataDictionary = [NSMutableDictionary new];
    _rootDataItems = [self processJsonFileWithURL:url];
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
        NSDictionary *jsonItem = [self convertJsonString:separatedJsonStringItem];
        if (!jsonItem) { continue; }
        [dataItemsArray addObject:jsonItem];
    }
    
    return dataItemsArray;
}

- (NSDictionary *)convertJsonString:(NSString *)jsonString {
    if (jsonString == nil || jsonString.length == 0) {
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

@end
