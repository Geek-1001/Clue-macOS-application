//
//  CLUUIViewTests.m
//  Clue
//
//  Created by Ahmed Sulaiman on 4/12/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CLUUIView.h"

@interface CLUUIViewTests : XCTestCase
@property (nonatomic) NSDictionary *validViewJSONRepresentation;
@property (nonatomic) NSDictionary *validViewInvalidSunviewsJSONRepresentation;
@property (nonatomic) NSDictionary *invalidViewJSONRepresentation;
@end

@implementation CLUUIViewTests

- (void)setUp {
    [super setUp];
    
    NSBundle *bundle = [NSBundle bundleForClass:[CLUUIViewTests class]];
    NSURL *resourcesURL = bundle.resourceURL;
    NSURL *validViewJSONURL = [resourcesURL URLByAppendingPathComponent:@"view-valid.json"];
    NSURL *validViewInvalidSubviewsJSONURL = [resourcesURL URLByAppendingPathComponent:@"view-valid-subviews-invalid.json"];
    NSURL *invalidViewJSONURL = [resourcesURL URLByAppendingPathComponent:@"view-invalid.json"];
    
    _validViewJSONRepresentation = [self jsonRepresentationForURL:validViewJSONURL];
    _validViewInvalidSunviewsJSONRepresentation = [self jsonRepresentationForURL:validViewInvalidSubviewsJSONURL];
    _invalidViewJSONRepresentation = [self jsonRepresentationForURL:invalidViewJSONURL];
}

- (void)tearDown {
    _validViewJSONRepresentation = nil;
    _validViewInvalidSunviewsJSONRepresentation = nil;
    _invalidViewJSONRepresentation = nil;
    
    [super tearDown];
}

- (NSDictionary *)jsonRepresentationForURL:(NSURL *)url {
    NSError *error;
    NSString *jsonString = [NSString stringWithContentsOfFile:url.path
                                                     encoding:NSUTF8StringEncoding
                                                        error:&error];
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    return [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
}

- (void)testInitWithJSONRepresentation_ValidViewJSON {
    CLUUIView *view = [[CLUUIView alloc] initWithJSONRepresentation:_validViewJSONRepresentation];
    XCTAssertNotNil(view, @"View should not be nil if json is valid");
    XCTAssertNotNil(view.properties, @"View properties array should be valid if JSON is valid");
    XCTAssertNotNil(view.subviews, @"View subviews array should be valid if JSON is valid");
    
    XCTAssertEqualObjects(view.className, @"UIView",
                          @"View class name should be equal to \"UIView\" according to test data");
    
    XCTAssertEqual(view.subviews.count, 1, @"View subviews count should be 1 according to test data");
    XCTAssertEqual(view.properties.count, 5, @"View properties array count should be 5 according to test data");
}

- (void)testInitWithJSONRepresentation_ValidViewJSON_InvalidSubviews {
    CLUUIView *view = [[CLUUIView alloc] initWithJSONRepresentation:_validViewInvalidSunviewsJSONRepresentation];
    XCTAssertNotNil(view, @"View should be valid even if subviews array is empty");
    XCTAssertNotNil(view.subviews, @"View subviews array should always be valid");
    XCTAssertEqual(view.subviews.count, 0,
                   @"View subviews array should be emoty if view json is valid and subviews are invalid");
}

- (void)testInitWithJSONRepresentation_InvalidViewJSON {
    CLUUIView *view = [[CLUUIView alloc] initWithJSONRepresentation:_invalidViewJSONRepresentation];
    XCTAssertNil(view, @"View should be nil if there are no \"class\" and \"properties\" onbects in JSON");
}

- (void)testNumberOfChilder {
    CLUUIView *view = [[CLUUIView alloc] initWithJSONRepresentation:_validViewJSONRepresentation];
    XCTAssertEqual([view numberOfChildren], 2, @"View should have 2 children: properties and subviews array");
}

- (void)testIsItemExpandable {
    CLUUIView *view = [[CLUUIView alloc] initWithJSONRepresentation:_validViewJSONRepresentation];
    XCTAssertTrue(view.isItemExpandable, @"View item should always be expandable because it has 2 children");
}

- (void)testChildAtIndex {
    CLUUIView *view = [[CLUUIView alloc] initWithJSONRepresentation:_validViewJSONRepresentation];
    for (NSNumber *number in @[@0, @1]) {
        id childAtIndex = [view childAtIndex:[number integerValue]];
        XCTAssertNotNil(childAtIndex, @"View child at index:%ld should be valid", [number longValue]);
    }
}

- (void)testItemType {
    CLUUIView *view = [[CLUUIView alloc] initWithJSONRepresentation:_validViewJSONRepresentation];
    CLUOutlineViewDataItemType itemType = [view itemType];
    XCTAssertEqual(itemType, CLUOutlineViewDataUIViewItem,
                   @"View item type should be CLUOutlineViewDataUIViewItem according to test data");
}

- (void)testItemName {
    CLUUIView *view = [[CLUUIView alloc] initWithJSONRepresentation:_validViewJSONRepresentation];
    XCTAssertEqualObjects(view.itemName,
                          @"UIView", @"View item name should be equal to class valud, UIView according to test data");
}

@end
