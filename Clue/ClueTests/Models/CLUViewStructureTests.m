//
//  CLUViewStructureTests.m
//  Clue
//
//  Created by Ahmed Sulaiman on 4/9/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CLUViewStructure.h"

@interface CLUViewStructureTests : XCTestCase
@property (nonatomic) NSURL *validViewStructureFileURL;
@property (nonatomic) NSURL *invalidViewStructureFileURL;
@end

@implementation CLUViewStructureTests

- (void)setUp {
    [super setUp];
    NSBundle *bundle = [NSBundle bundleForClass:[CLUViewStructureTests class]];
    NSURL *resourcesURL = bundle.resourceURL;
    _validViewStructureFileURL = [resourcesURL URLByAppendingPathComponent:@"view-structure-module-valid.json"];
    _invalidViewStructureFileURL = [resourcesURL URLByAppendingPathComponent:@"view-structure-module-invalid.json"];
}

- (void)tearDown {
    _validViewStructureFileURL = nil;
    _invalidViewStructureFileURL = nil;
    [super tearDown];
}

- (void)testInitWithURL_InvalidJSON {
    CLUViewStructure *viewStructure = [[CLUViewStructure alloc] initWithURL:_invalidViewStructureFileURL];
    XCTAssertNil(viewStructure, @"View Stucture should be nil if JSON presented in invalid format");
}

- (void)testInitWithURL_ValidJSON {
    CLUViewStructure *viewStructure = [[CLUViewStructure alloc] initWithURL:_validViewStructureFileURL];
    XCTAssertNotNil(viewStructure, @"View Structure should be valid if JSON is valid and in valid format");
    
    XCTAssertNotNil(viewStructure.rootDataDictionary,
                    @"View Structure root data dictionary should be valid if initial json is valid");
    XCTAssertEqual(viewStructure.rootDataDictionary.count, 2,
                   @"View Structure root data dictionary should have 2 object inside according to test data");
    
    XCTAssertNotNil(viewStructure.rootDataItems,
                    @"View Structure root data items array should be valid if initial json if valid");
    XCTAssertEqual(viewStructure.rootDataItems.count, 2,
                   @"View Structure root data items array have 2 object inside according to test data");
    
    XCTAssertNotNil(viewStructure.rootViewItem,
                    @"View Structure root view item should be valid if root data dictionary \
                    is valid and has CLUUIView item for default timestamp (at start timestamp = 0)");
}

- (void)testUpdateCurrentTimestamp {
    CLUViewStructure *viewStructure = [[CLUViewStructure alloc] initWithURL:_validViewStructureFileURL];
    XCTAssertEqual(viewStructure.currentTiestamp, 0, @"View Structure default timestamp should be 0");
    
    CLUUIView *defaultRootView = [viewStructure rootViewItem];
    XCTAssertNotNil(defaultRootView,
                    @"View Structure root view item for default timestamp should be valid");
    
    [viewStructure updateCurrentTimestamp:1];
    XCTAssertEqual(viewStructure.currentTiestamp, 1,
                   @"View Structure default timestamp should be 1 after timestamp update");
    
    CLUUIView *updatedRootView = [viewStructure rootViewItem];
    XCTAssertNotNil(updatedRootView, @"View Structure root view item for updated timestamp should be valid");
    
    XCTAssertNotEqualObjects(defaultRootView, updatedRootView,
                             @"View Structure root view item for different timestamp should be different");
}

- (void)testNumberOfChilder {
    CLUViewStructure *viewStructure = [[CLUViewStructure alloc] initWithURL:_validViewStructureFileURL];
    NSInteger numberOfChildren = [viewStructure numberOfChildren];
    XCTAssertEqual(numberOfChildren, 1,
                   @"View Structure has only 1 children because  it's root item in Outline View");
}

- (void)testIsItemExpandable {
    CLUViewStructure *viewStructure = [[CLUViewStructure alloc] initWithURL:_validViewStructureFileURL];
    BOOL isItemExpandable = [viewStructure isItemExpandable];
    XCTAssertTrue(isItemExpandable,
                  @"View Structure has only 1 children item and its should be always expandable");
}

- (void)testChildAtIndex {
    CLUViewStructure *viewStructure = [[CLUViewStructure alloc] initWithURL:_validViewStructureFileURL];
    // Because View Structure has only 1 item we need to test only index = 0
    CLUUIView *childAtIndex = [viewStructure childAtIndex:0];
    XCTAssertNotNil(childAtIndex, @"View Structure child at index 0 can't be nil");
    XCTAssertEqualObjects(childAtIndex, [viewStructure rootViewItem],
                          @"View Structure root view item and child at index 0 should be equal");
}

- (void)testItemType {
    CLUViewStructure *viewStructure = [[CLUViewStructure alloc] initWithURL:_validViewStructureFileURL];
    CLUOutlineViewDataItemType itemType = [viewStructure itemType];
    XCTAssertEqual(itemType, CLUOutlineViewDataUndefinedItem,
                   @"View Structure item type should be equal to CLUOutlineViewDataUndefinedItem");
}

- (void)testItemName {
    CLUViewStructure *viewStructure = [[CLUViewStructure alloc] initWithURL:_validViewStructureFileURL];
    NSString *itemName = [viewStructure itemName];
    XCTAssertNotNil(itemName, @"View Structure item name should be valid");
    XCTAssertEqualObjects(itemName, @"Root View", @"View Structure item name should be equal to \"Root View\" string");
}

@end
