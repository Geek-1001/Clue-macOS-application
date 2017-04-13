//
//  CLUTimeRelatedModuleTests.m
//  Clue
//
//  Created by Ahmed Sulaiman on 4/9/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CLUTimeRelatedModule.h"

@interface CLUTimeRelatedModuleTests : XCTestCase
@property (nonatomic) NSFileManager *fileManager;
@property (nonatomic) NSURL *testValidFileURLWithInvalidContent;
@property (nonatomic) NSURL *testInvalidFileURL;
@property (nonatomic) NSURL *testValidFileURLWithValidContent;
@property (nonatomic) NSDictionary *testInvalidModuleDictionary;
@end

@implementation CLUTimeRelatedModuleTests

- (void)setUp {
    [super setUp];
    
    _fileManager = [NSFileManager defaultManager];
    _testInvalidModuleDictionary = @{};
    NSData *testValidData = [@"{\"name\" : \"key\"}\n{\"name\" : \"key\"}" dataUsingEncoding:NSUTF8StringEncoding];;
    NSData *testInvalidData = [@"kj$#akj : {\"s\" : s} ahsd8982 kspossd" dataUsingEncoding:NSUTF8StringEncoding];
    
    _testValidFileURLWithInvalidContent = [NSURL fileURLWithPath:@"valid_module.json"];
    _testInvalidFileURL = [NSURL fileURLWithPath:@"invalid_module.json"];
    _testValidFileURLWithValidContent = [NSURL fileURLWithPath:@"valid_module_valid_content.json"];
    
    [_fileManager createFileAtPath:_testValidFileURLWithInvalidContent.path contents:testInvalidData attributes:nil];
    [_fileManager createFileAtPath:_testValidFileURLWithValidContent.path contents:testValidData attributes:nil];
}

- (void)tearDown {
    [_fileManager removeItemAtURL:_testValidFileURLWithInvalidContent error:nil];
    [_fileManager removeItemAtURL:_testValidFileURLWithValidContent error:nil];
    _testValidFileURLWithInvalidContent = nil;
    _testInvalidFileURL = nil;
    _fileManager = nil;
    _testValidFileURLWithValidContent = nil;
    _testInvalidModuleDictionary = nil;
    
    [super tearDown];
}

- (void)testInitWithURL_InvalidURL {
    CLUTimeRelatedModule *module = [[CLUTimeRelatedModule alloc] initWithURL:nil];
    XCTAssertNil(module, @"Time Related Module should be nil if URL is invalid");
}

- (void)testInitWithURL_ValidURL_FileNotExists {
    CLUTimeRelatedModule *module = [[CLUTimeRelatedModule alloc] initWithURL:_testInvalidFileURL];
    XCTAssertNil(module, @"Time Related Module should be nil if URL is valid but no file was found at the provided URL");
}

- (void)testInitWithURL_ValidURL_FileExists_WrongContent {
    CLUTimeRelatedModule *module = [[CLUTimeRelatedModule alloc] initWithURL:_testValidFileURLWithInvalidContent];
    XCTAssertNil(module, @"Time Related Module should be nil if URL is valid, file is valid but content is invalid");
}

- (void)testInitWithURL_ValidURL_ValidJSON {
    CLUTimeRelatedModule *module = [[CLUTimeRelatedModule alloc] initWithURL:_testValidFileURLWithValidContent];
    XCTAssertNotNil(module, @"Time related module should not be nil if URL and final JSON file are valid");
    XCTAssertEqual(module.currentTiestamp, 0, @"Current time of valid Time related module should be equal to 0 after initialization");
    XCTAssertNotNil(module.rootDataDictionary, @"Root data Dictionary should not be nil in valid Time Related Module");
    XCTAssertNotNil(module.rootDataItems, @"Root Data Items array should be valid if Time Related Module is valid and JSON is valid");
    XCTAssertEqual([module.rootDataItems count], 2, @"Root Data Items array cound should be 2 according to test data");
}

- (void)testUpdateCurrentTimestamp {
    CLUTimeRelatedModule *module = [[CLUTimeRelatedModule alloc] initWithURL:_testValidFileURLWithValidContent];
    [module updateCurrentTimestamp:23];
    XCTAssertEqual(module.currentTiestamp, 23, @"Time Related Module current timestamp should be equal to 23 according to test data");
}

@end
