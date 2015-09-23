//
//  GNApiClientTests.m
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 6/26/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <Nocilla/Nocilla.h>

@interface GNApiClientTests : XCTestCase

@property (strong, nonatomic) GNConfig *config;
@property (strong, nonatomic) NSString *stubRoute;
@property (strong, nonatomic) LSStubRequestDSL *wsStub;

@end


@implementation GNApiClientTests

- (void)setUp {
    [super setUp];
    [[LSNocilla sharedInstance] start];
    _config = [[GNConfig alloc] initWithAccountCode:@"my_account_code" sandbox:YES];
    _stubRoute = @"/installments";
    _wsStub = stubRequest(@"POST", [NSString stringWithFormat:@"%@%@", kGNApiBaseUrlSandbox, _stubRoute]);
}

- (void)tearDown {
    [[LSNocilla sharedInstance] stop];
    [super tearDown];
}

- (void)testInitialization {
    GNApiClient *gnApiClient = [[GNApiClient alloc] initWithConfig:_config];
    XCTAssertNotNil(gnApiClient, @"gnApiClient should not be nil");
    XCTAssertTrue([gnApiClient.config isKindOfClass:[GNConfig class]], @"gnApiClient config property should be an instance of GNConfig");
}

- (void)testInvalidAccountCode {
    GNApiClient *gnApiClient = [[GNApiClient alloc] initWithConfig:nil];
    XCTAssertThrowsSpecificNamed([gnApiClient request:@"/postRoute" method:@"POST" params:nil], NSException, @"Account code not defined");
}

- (void) testSuccessfulResponse {
    XCTestExpectation *httpExpect = [self expectationWithDescription:@"GNApiClient post request"];
    GNApiClient *gnApiClient = [[GNApiClient alloc] initWithConfig:_config];
    
    _wsStub.andReturn(200)
    .withHeaders(@{@"Content-Type": @"application/json"})
    .withBody(@"{\"method\":\"visa\", \"total\":1200}");
    
    [gnApiClient request:_stubRoute method:@"POST" params:@{}]
    .then(^(NSDictionary *response){
        [httpExpect fulfill];
        XCTAssertEqualObjects([response valueForKey:@"method"], @"visa", @"response should have a method attribute with value 'visa'");
        XCTAssertEqualObjects([response valueForKey:@"total"], @(1200), @"response should have a total attribute with value 1200");
    })
    .catch(^(GNError *error){
        [httpExpect fulfill];
        XCTFail(@"request should respond successfully");
    });
    
    [self waitForExpectationsWithTimeout:3.0 handler:nil];
}

- (void) testSuccessfulResponseWithInvalidData {
    XCTestExpectation *httpExpect = [self expectationWithDescription:@"GNApiClient post request"];
    GNApiClient *gnApiClient = [[GNApiClient alloc] initWithConfig:_config];
    
    _wsStub.andReturn(200)
    .withHeaders(@{@"Content-Type": @"application/json"});
    
    [gnApiClient request:_stubRoute method:@"POST" params:@{}]
    .then(^(NSDictionary *response){
        [httpExpect fulfill];
        XCTFail(@"request should return error");
    })
    .catch(^(GNError *error){
        [httpExpect fulfill];
        XCTAssertEqual(error.code, 500, @"error code should be equal to 500");
        XCTAssertEqualObjects(error.message, @"Invalid response data.", @"error message should be equal to 'Invalid response data.'");
    });
    
    [self waitForExpectationsWithTimeout:3.0 handler:nil];
}

- (void) testSuccessfulResponseWithError {
    XCTestExpectation *httpExpect = [self expectationWithDescription:@"GNApiClient post request"];
    GNApiClient *gnApiClient = [[GNApiClient alloc] initWithConfig:_config];
    
    _wsStub.andReturn(200)
    .withHeaders(@{@"Content-Type": @"application/json"})
    .withBody(@"{\"error\":\"api error\", \"error_description\":\"invalid request params\", \"code\": 90034}");
    
    [gnApiClient request:_stubRoute method:@"POST" params:@{}]
    .then(^(NSDictionary *response){
        [httpExpect fulfill];
        XCTFail(@"request should return error");
    })
    .catch(^(GNError *error){
        [httpExpect fulfill];
        XCTAssertEqual(error.code, 90034, @"error code should be equal to 90034");
        XCTAssertEqualObjects(error.message, @"invalid request params", @"error message should be equal to 'invalid request params'");
    });
    
    [self waitForExpectationsWithTimeout:3.0 handler:nil];
}

- (void) testFailureResponse {
    XCTestExpectation *httpExpect = [self expectationWithDescription:@"GNApiClient post request"];
    GNApiClient *gnApiClient = [[GNApiClient alloc] initWithConfig:_config];
    
    _wsStub.andReturn(404)
    .withHeaders(@{@"Content-Type": @"application/json"});
    
    [gnApiClient request:_stubRoute method:@"POST" params:@{}]
    .then(^(NSDictionary *response){
        [httpExpect fulfill];
        XCTFail(@"request should return error");
    })
    .catch(^(GNError *error){
        [httpExpect fulfill];
        XCTAssertEqual(error.code, 500, @"error code should be equal to 500");
        XCTAssertEqualObjects(error.message, @"Invalid response data.", @"error message should be equal to 'Invalid response data.'");
    });
    
    [self waitForExpectationsWithTimeout:3.0 handler:nil];
}

- (void) testFailureResponseWithError {
    XCTestExpectation *httpExpect = [self expectationWithDescription:@"GNApiClient post request"];
    GNApiClient *gnApiClient = [[GNApiClient alloc] initWithConfig:_config];
    
    _wsStub.andReturn(500)
    .withHeaders(@{@"Content-Type": @"application/json"})
    .withBody(@"{\"error\":\"server_error\", \"error_description\":\"Internal server error\", \"code\":500}");
    
    [gnApiClient request:_stubRoute method:@"POST" params:nil]
    .then(^(NSDictionary *response){
        [httpExpect fulfill];
        XCTFail(@"request should return error");
    })
    .catch(^(GNError *error){
        [httpExpect fulfill];
        XCTAssertEqual(error.code, 500, @"error code should be equal to 500");
        XCTAssertEqualObjects(error.message, @"Internal server error", @"error message should be equal to 'Internal server error'");
    });
    
    [self waitForExpectationsWithTimeout:3.0 handler:nil];
}

@end
