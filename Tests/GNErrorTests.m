//
//  GNErrorTests.m
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 6/26/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface GNErrorTests : XCTestCase

@end

@implementation GNErrorTests

- (void)testInitWithCodeAndString {
    GNError *error = [[GNError alloc] initWithCode:404 message:@"Not found"];
    XCTAssertNotNil(error, @"GNError instance should not be nil");
    XCTAssertEqual(error.code, 404, @"error code should be equal 404");
    XCTAssertEqualObjects(error.message, @"Not found", @"error message should be equal to 'Not found'");
}

- (void)testInitWithDictionary {
    NSDictionary *errorDict = @{ @"code":@(500), @"error_description":@"Server error"};
    GNError *error = [[GNError alloc] initWithDictionary:errorDict];
    XCTAssertNotNil(error, @"GNError instance should not be nil");
    XCTAssertEqual(error.code, 500);
    XCTAssertEqualObjects(error.message, @"Server error");
}

- (void)testDetailedErrorDescription {
    NSDictionary *detailedErrorDict = @{ @"property":@"credit_card", @"message": @"The property is invalid"};
    NSDictionary *errorDict = @{ @"code":@(34), @"error_description":detailedErrorDict};
    GNError *error = [[GNError alloc] initWithDictionary:errorDict];
    XCTAssertEqualObjects(error.message, @"message: The property is invalid. property: credit_card. ", @"error message is incorrect");
}

@end
