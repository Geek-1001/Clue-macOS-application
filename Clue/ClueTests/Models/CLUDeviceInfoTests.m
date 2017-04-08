//
//  CLUDeviceInfoTests.m
//  Clue
//
//  Created by Ahmed Sulaiman on 4/8/17.
//  Copyright © 2017 Ahmed Sulaiman. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CLUDeviceInfo.h"

@interface CLUDeviceInfoTests : XCTestCase
@property (nonatomic) NSURL *testValidFileURL;
@property (nonatomic) NSURL *testValidFileURLWithValidContent;
@property (nonatomic) NSURL *testInvalidFileURL;
@property (nonatomic) NSFileManager *fileManager;
@property (nonatomic) NSDictionary *testValidDeviceInfoContent;
@property (nonatomic) NSDictionary *testInvalidDeviceInfoContent;
@end

@implementation CLUDeviceInfoTests

- (void)setUp {
    [super setUp];
    _testInvalidDeviceInfoContent = @{@"batteryState" : @0,
                                      @"model" : @"iPhone",
                                      @"systemVersion" : @"10.2",
                                      @"batteryLvl" : @100,
                                      @"identifierForVendor" : @"A053F005-986D-421E-A8D6-5CF048789FB8"};
    _testValidDeviceInfoContent = @{@"batteryState" : @0,
                                    @"systemName" : @"iOS",
                                    @"model" : @"iPhone",
                                    @"systemVersion" : @"10.2",
                                    @"batteryLevel" : @100,
                                    @"name" : @"Test Device",
                                    @"identifierForVendor" : @"A053F005-986D-421E-A8D6-5CF048789FB8"};
    NSData *testValidData = [NSJSONSerialization dataWithJSONObject:_testValidDeviceInfoContent
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    NSString *testInvalidDeviceInfoContent = @"kjahsd8982kspossd";
    NSData *testInvalidData = [testInvalidDeviceInfoContent dataUsingEncoding:NSUTF8StringEncoding];
    
    _fileManager = [NSFileManager defaultManager];
    _testValidFileURL = [NSURL fileURLWithPath:@"valid_info.json"];
    _testInvalidFileURL = [NSURL fileURLWithPath:@"invalid_info.json"];
    _testValidFileURLWithValidContent = [NSURL fileURLWithPath:@"valid_info_valid_content.json"];
    
    [_fileManager createFileAtPath:_testValidFileURL.path contents:testInvalidData attributes:nil];
    [_fileManager createFileAtPath:_testValidFileURLWithValidContent.path contents:testValidData attributes:nil];
}

- (void)tearDown {
    [_fileManager removeItemAtURL:_testValidFileURL error:nil];
    [_fileManager removeItemAtURL:_testValidFileURLWithValidContent error:nil];
    _testValidFileURL = nil;
    _testInvalidFileURL = nil;
    
    [super tearDown];
}

- (void)testInitWithURL_InvalidURL {
    CLUDeviceInfo *deviceInfo = [[CLUDeviceInfo alloc] initWithURL:nil];
    XCTAssertNil(deviceInfo, @"Device Info should be nil if URL is invalid");
}

- (void)testInitWithURL_ValidURL_FileNotExists {
    XCTAssertFalse([_fileManager fileExistsAtPath:_testInvalidFileURL.path], @"Test file should not exists at path: %@", _testInvalidFileURL.path);
    
    CLUDeviceInfo *deviceInfo = [[CLUDeviceInfo alloc] initWithURL:_testInvalidFileURL];
    XCTAssertNil(deviceInfo, @"Device Info should be nil if there is no file at valid URL");
}

- (void)testInitWithURL_ValidURL_FileExists_WrongContent {
    XCTAssertTrue([_fileManager fileExistsAtPath:_testValidFileURL.path], @"Test file should exists at path: %@", _testValidFileURL.path);
    
    CLUDeviceInfo *deviceInfo = [[CLUDeviceInfo alloc] initWithURL:_testValidFileURL];
    XCTAssertNil(deviceInfo, @"Device Info should be nil if there is no file at valid URL");
}

- (void)testInitWithJSONRepresentation_InvalidJSON {
    CLUDeviceInfo *deviceInfo = [[CLUDeviceInfo alloc] initWithJSONRepresentation:nil];
    XCTAssertNil(deviceInfo, @"Device Info should be nil if JSON is invalid");
}

- (void)testInitWithJSONRepresentation_ValidJSON {
    CLUDeviceInfo *deviceInfo = [[CLUDeviceInfo alloc] initWithJSONRepresentation:_testValidDeviceInfoContent];
    XCTAssertNotNil(deviceInfo, @"Device Info can not be nil if JSON is valid");
    
    // Check all valus from test dictionary and actual valus from Device Info
    XCTAssertEqual(deviceInfo.batteryState, CLUBatteryStateUnknown, @"Device Info has incorrect battery state");
    XCTAssertEqualObjects(deviceInfo.systemName, @"iOS", @"Device Info has incorrect system name");
    XCTAssertEqualObjects(deviceInfo.model, @"iPhone", @"Device Info has incorrect model");
    XCTAssertEqualObjects(deviceInfo.systemVersion, @"10.2", @"Device Info has incorrect system version");
    XCTAssertEqual(deviceInfo.batteryLevel, 100, @"Device Info has incorrect battery level");
    XCTAssertEqualObjects(deviceInfo.name, @"Test Device", @"Device Info has incorrect name");
    XCTAssertEqualObjects(deviceInfo.identifierForVendor, @"A053F005-986D-421E-A8D6-5CF048789FB8", @"Device Info has incorrect identifier for vendor");
}

- (void)testInitWithJSONRepresentation_ValidJSON_InvalidContent {
    CLUDeviceInfo *deviceInfo = [[CLUDeviceInfo alloc] initWithJSONRepresentation:_testInvalidDeviceInfoContent];
    XCTAssertNotNil(deviceInfo, @"Device Info can not be nil if JSON is valid");
    
    // Check all valus from test dictionary and actual valus from Device Info
    XCTAssertEqual(deviceInfo.batteryState, CLUBatteryStateUnknown, @"Device Info has incorrect battery state");
    XCTAssertEqualObjects(deviceInfo.systemName, @"Undefined", @"Device Info has incorrect system name");
    XCTAssertEqualObjects(deviceInfo.model, @"iPhone", @"Device Info has incorrect model");
    XCTAssertEqualObjects(deviceInfo.systemVersion, @"10.2", @"Device Info has incorrect system version");
    XCTAssertEqual(deviceInfo.batteryLevel, 0, @"Device Info has incorrect battery level");
    XCTAssertEqualObjects(deviceInfo.name, @"Undefined", @"Device Info has incorrect name");
    XCTAssertEqualObjects(deviceInfo.identifierForVendor, @"A053F005-986D-421E-A8D6-5CF048789FB8", @"Device Info has incorrect identifier for vendor");
}

@end
