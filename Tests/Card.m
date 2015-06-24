//
//  Card.m
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 6/24/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <AFNetworking/AFNetworking.h>
#import <OCMock/OCMock.h>
#import "GNApiSdk.h"

@interface Card : XCTestCase

@property (strong, nonatomic) GNApiEndpoints *gnApi;

@end


@implementation Card

- (void)setUp {
    [super setUp];
    GNConfig *config = [[GNConfig alloc] initWithAccountCode:@"account_code" sandbox:YES];
    _gnApi = [[GNApiEndpoints alloc] initWithConfig:config];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testSend {
    XCTestExpectation *expect = [self expectationWithDescription:@"Save card async"];
    
    GNMethod *method = [[GNMethod alloc] initWithType:kGNMethodTypeVisa total:@(5000)];
    [_gnApi fetchPaymentDataWithMethod:method completion:^(GNPaymentData *paymentData, GNError *error) {
        [expect fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5 handler:^(NSError *error) {
        if(error){
            XCTFail(@"Expectation failed with error: %@", error);
        }
    }];
    
    XCTAssert(2==2, @"should be 2");
}

@end
