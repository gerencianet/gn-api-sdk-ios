//
//  GNApiEndpointsTests.m
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 6/26/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <Nocilla/Nocilla.h>

@interface GNApiEndpointsTests : XCTestCase <GNApiEndpointsDelegate>

@property (strong, nonatomic) GNConfig *config;
@property (strong, nonatomic) GNApiEndpoints *gnApi;
@property (strong, nonatomic) XCTestExpectation *apiExpectation;

@property (strong, nonatomic) GNMethod *method;
@property (strong, nonatomic) LSStubRequestDSL *paymentDataStub;
@property (strong, nonatomic) NSString *paymentDataResponseMock;

@property (strong, nonatomic) GNCreditCard *creditCard;
@property (strong, nonatomic) LSStubRequestDSL *cardStub;
@property (strong, nonatomic) NSString *cardResponseMock;

@end

@implementation GNApiEndpointsTests

- (void)setUp {
    [super setUp];
    [[LSNocilla sharedInstance] start];
    _config = [[GNConfig alloc] initWithAccountCode:@"my_account_code" sandbox:YES];
    _gnApi = [[GNApiEndpoints alloc] initWithConfig:_config];
    _gnApi.delegate = self;
    _apiExpectation = [self expectationWithDescription:@"GNApi request"];
    
    _method = [[GNMethod alloc] initWithType:kGNMethodTypeVisa total:@(4500)];
    _paymentDataStub = stubRequest(@"POST", [NSString stringWithFormat:@"%@%@", kGNApiBaseUrlSandbox, @"/payment/data"]);
    _paymentDataResponseMock = @"{\"code\":200,\"data\":{\"rate\":0,\"name\":\"visa\",\"installments\":[{\"installment\":1,\"has_interest\":false,\"value\":4500,\"currency\":\"45,00\",\"interest_percentage\":199},{\"installment\":2,\"has_interest\":true,\"value\":2341,\"currency\":\"23,41\",\"interest_percentage\":199},{\"installment\":3,\"has_interest\":true,\"value\":1591,\"currency\":\"15,91\",\"interest_percentage\":199},{\"installment\":4,\"has_interest\":true,\"value\":1217,\"currency\":\"12,17\",\"interest_percentage\":199},{\"installment\":5,\"has_interest\":true,\"value\":993,\"currency\":\"9,93\",\"interest_percentage\":199},{\"installment\":6,\"has_interest\":true,\"value\":844,\"currency\":\"8,44\",\"interest_percentage\":199},{\"installment\":7,\"has_interest\":true,\"value\":738,\"currency\":\"7,38\",\"interest_percentage\":199},{\"installment\":8,\"has_interest\":true,\"value\":659,\"currency\":\"6,59\",\"interest_percentage\":199},{\"installment\":9,\"has_interest\":true,\"value\":597,\"currency\":\"5,97\",\"interest_percentage\":199},{\"installment\":10,\"has_interest\":true,\"value\":548,\"currency\":\"5,48\",\"interest_percentage\":199},{\"installment\":11,\"has_interest\":true,\"value\":508,\"currency\":\"5,08\",\"interest_percentage\":199}]}}";
    
    _creditCard = [[GNCreditCard alloc] initWithNumber:@"1000200030004000" brand:kGNMethodTypeVisa expirationMonth:@"09" expirationYear:@"2018" cvv:@"123"];
    _cardStub = stubRequest(@"POST", [NSString stringWithFormat:@"%@%@", kGNApiBaseUrlSandbox, @"/card"]);
    _cardResponseMock = @"{\"code\":200,\"data\":{\"payment_token\":\"98aedf334b07165f15ec7a80fdd157d32d86a8fa\",\"card_mask\": \"XXXXXXXXXXXX4000\"}}";
}

- (void)tearDown {
    [[LSNocilla sharedInstance] stop];
    [super tearDown];
}

- (void)testFetchPaymentData {
    _paymentDataStub.andReturn(200)
        .withHeaders(@{@"Content-Type": @"application/json"})
        .withBody(_paymentDataResponseMock);
    
    [_gnApi fetchPaymentDataWithMethod:_method completion:^(GNPaymentData *paymentData, GNError *error) {
        [_apiExpectation fulfill];
        XCTAssertNil(error, @"error should be nil");
        XCTAssertTrue([paymentData isKindOfClass:[GNPaymentData class]], @"paymentData should be an instance of GNPaymentData");
    }];
    
    [self waitForExpectationsWithTimeout:3.0 handler:nil];
}

- (void)testFetchPaymentDataDelegate {
    _paymentDataStub.andReturn(200)
        .withHeaders(@{@"Content-Type": @"application/json"})
        .withBody(_paymentDataResponseMock);
    
    [_gnApi fetchPaymentDataWithMethod:_method];
    [self waitForExpectationsWithTimeout:3.0 handler:nil];
}

- (void)gnApiFetchPaymentDataFinished:(GNPaymentData *)paymentData error:(GNError *)error {
    [_apiExpectation fulfill];
    XCTAssertNil(error, @"error should be nil");
    XCTAssertTrue([paymentData isKindOfClass:[GNPaymentData class]], @"paymentData should be an instance of GNPaymentData");
}

- (void)testFetchPaymentDataError {
    _paymentDataStub.andReturn(200)
        .withHeaders(@{@"Content-Type": @"application/json"});
    
    [_gnApi fetchPaymentDataWithMethod:_method completion:^(GNPaymentData *paymentData, GNError *error) {
        [_apiExpectation fulfill];
        XCTAssertNotNil(error, @"error should not be nil");
        XCTAssertNil(paymentData, @"paymentData should be nil");
    }];
    
    [self waitForExpectationsWithTimeout:3.0 handler:nil];
}


- (void)testPaymentTokenForCreditCard {
    _cardStub.andReturn(200)
        .withHeaders(@{@"Content-Type": @"application/json"})
        .withBody(_cardResponseMock);
    
    [_gnApi paymentTokenForCreditCard:_creditCard completion:^(GNPaymentToken *paymentToken, GNError *error) {
        [_apiExpectation fulfill];
        XCTAssertNil(error, @"error should be nil");
        XCTAssertTrue([paymentToken isKindOfClass:[GNPaymentToken class]], @"paymentToken should be an instance of GNPaymentToken");
    }];
    
    [self waitForExpectationsWithTimeout:3.0 handler:nil];
}

- (void)testPaymentTokenForCreditCardDelegate {
    _cardStub.andReturn(200)
    .withHeaders(@{@"Content-Type": @"application/json"})
    .withBody(_cardResponseMock);
    
    [_gnApi paymentTokenForCreditCard:_creditCard];
    [self waitForExpectationsWithTimeout:3.0 handler:nil];
}

- (void)gnApiPaymentTokenForCreditCardFinished:(GNPaymentToken *)paymentToken error:(GNError *)error {
    [_apiExpectation fulfill];
    XCTAssertNil(error, @"error should be nil");
    XCTAssertTrue([paymentToken isKindOfClass:[GNPaymentToken class]], @"paymentToken should be an instance of GNPaymentToken");
}

- (void)testPaymentTokenForCreditCardError {
    _cardStub.andReturn(200)
    .withHeaders(@{@"Content-Type": @"application/json"});
    
    [_gnApi paymentTokenForCreditCard:_creditCard completion:^(GNPaymentToken *paymentToken, GNError *error) {
        [_apiExpectation fulfill];
        XCTAssertNotNil(error, @"error should not be nil");
        XCTAssertNil(paymentToken, @"paymentToken should be nil");
    }];
    
    [self waitForExpectationsWithTimeout:3.0 handler:nil];
}

@end
