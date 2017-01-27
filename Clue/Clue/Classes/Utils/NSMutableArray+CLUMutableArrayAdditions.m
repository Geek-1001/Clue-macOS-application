//
//  NSMutableArray+CLUMutableArrayAdditions.m
//  Clue
//
//  Created by Ahmed Sulaiman on 1/25/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import "NSMutableArray+CLUMutableArrayAdditions.h"
#import <objc/runtime.h>

static void *ArrayNamePropertyKey = &ArrayNamePropertyKey;
static void *ArrayTypePropertyKey = &ArrayTypePropertyKey;

@implementation NSMutableArray (CLUMutableArrayAdditions)

- (NSInteger)numberOfChildren {
    return self.count;
}

- (BOOL)isItemExpandable {
    return self.count != 0;
}

- (id _Nonnull)childAtIndex:(NSInteger)index {
    return self[index];
}

- (NSString * _Nonnull)itemName {
    return [self arrayName] ? : @"Undefined";
}

- (NSString *)arrayName {
    return objc_getAssociatedObject(self, ArrayNamePropertyKey);
}

- (void)setArrayName:(NSString *)name {
    objc_setAssociatedObject(self, ArrayNamePropertyKey, name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)arrayType {
    return objc_getAssociatedObject(self, ArrayTypePropertyKey);
}

- (void)setArrayType:(NSNumber *)type {
    objc_setAssociatedObject(self, ArrayTypePropertyKey, type, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CLUOutlineViewDataItemType)itemType {
    NSNumber *arrayType = [self arrayType];
    CLUOutlineViewDataItemType type =  [arrayType integerValue];
    return type;
}

@end
