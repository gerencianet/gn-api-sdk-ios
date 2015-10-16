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

@interface GNApiEndpointsTests : XCTestCase

@property (strong, nonatomic) GNConfig *config;
@property (strong, nonatomic) GNApiEndpoints *gnApi;
@property (strong, nonatomic) XCTestExpectation *apiExpectation;

@property (strong, nonatomic) GNMethod *method;
@property (strong, nonatomic) LSStubRequestDSL *installmentsStub;
@property (strong, nonatomic) NSString *installmentsResponseMock;


@property (strong, nonatomic) LSStubRequestDSL *pubkeyStub;
@property (strong, nonatomic) NSString *pubkeyResponseMock;

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
    _apiExpectation = [self expectationWithDescription:@"GNApi request"];
    
    _method = [[GNMethod alloc] initWithBrand:kGNMethodBrandVisa total:@(4500)];
    _installmentsStub = stubRequest(@"GET", [NSString stringWithFormat:@"%@%@", kGNApiBaseUrlSandbox, @"/installments?brand=visa&total=4500"]);
    _installmentsResponseMock = @"{\"code\":200,\"data\":{\"rate\":0,\"name\":\"visa\",\"installments\":[{\"installment\":1,\"has_interest\":false,\"value\":4500,\"currency\":\"45,00\",\"interest_percentage\":199},{\"installment\":2,\"has_interest\":true,\"value\":2341,\"currency\":\"23,41\",\"interest_percentage\":199},{\"installment\":3,\"has_interest\":true,\"value\":1591,\"currency\":\"15,91\",\"interest_percentage\":199},{\"installment\":4,\"has_interest\":true,\"value\":1217,\"currency\":\"12,17\",\"interest_percentage\":199},{\"installment\":5,\"has_interest\":true,\"value\":993,\"currency\":\"9,93\",\"interest_percentage\":199},{\"installment\":6,\"has_interest\":true,\"value\":844,\"currency\":\"8,44\",\"interest_percentage\":199},{\"installment\":7,\"has_interest\":true,\"value\":738,\"currency\":\"7,38\",\"interest_percentage\":199},{\"installment\":8,\"has_interest\":true,\"value\":659,\"currency\":\"6,59\",\"interest_percentage\":199},{\"installment\":9,\"has_interest\":true,\"value\":597,\"currency\":\"5,97\",\"interest_percentage\":199},{\"installment\":10,\"has_interest\":true,\"value\":548,\"currency\":\"5,48\",\"interest_percentage\":199},{\"installment\":11,\"has_interest\":true,\"value\":508,\"currency\":\"5,08\",\"interest_percentage\":199}]}}";
    
    _pubkeyResponseMock = @"{\"code\": 200, \"data\": \"-----BEGIN PUBLIC KEY-----\\nMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA1M+tSxv/wepGzrThSuVK\\nPcz/rbMkznDH38H2ak43cYgYSRNtgcBjJGPkl7G9CrJcdPRE1Yr4It5pMsZ2psgU\\nqIhVXUjr7lWSmE15cTW2iyDTt8IzeglG0CP1fZHYcye1+T7IQEw7Zby+/3CA/J7q\\nmniHSe7IgQL865NonKMNEK5n97L8mnjkD0BNX9SS7Z5r5/H94iVgATEAuWN8GDq7\\nV6kkTWmjtJZPK+A/NUoPX8l+Dc7sEbhPolJqIH4m7R5+jiYjDozLuDrm2lBzD3pF\\nqoY21qWAbKMSDndJXhF59oy7iR+KeT+ufqE21makK53hR+awcY/Yh3QNqFpzzc8F\\nGHX3QEj8nRALMDGIUesRIbXfBgZyzK9q9ZLcePqz1jTJYtPujh5iDFr8GTmxEA6j\\nRpPu/62HfJqBjPGafPfz9HYIwE1qpbzaUEfdRVnOB1AX4YHGOcIASf0ByVrjcjHT\\nR3l5RJsiV/IHW3CzyORbbCRvqoyb1NY6kfnFLaeQPc/EitckvayV5APJsVfJIwu4\\nmTv5abBDYB3PByXvlUph9r0ZLC0phQwPV87+DxI9f68PAhzzE6B7vbQckw2kceHR\\nvfQZH7JWL9WYD73oyvExcIKM5MkDEjj7a4KCCOnRlD8TSZF2x9C4uIHXSUCsaF6K\\nkj9VKScWHcKZoLXvXSUW2pMCAwEAAQ==\\n-----END PUBLIC KEY-----\\n\"}";
    _pubkeyStub = stubRequest(@"GET", [NSString stringWithFormat:@"%@%@", kGNApiBaseUrlSandbox, @"/pubkey"]);
    
    _creditCard = [[GNCreditCard alloc] initWithNumber:@"1000200030004000" brand:kGNMethodBrandVisa expirationMonth:@"09" expirationYear:@"2018" cvv:@"123"];
    _cardStub = stubRequest(@"POST", [NSString stringWithFormat:@"%@%@", kGNApiBaseUrlSandbox, @"/card"]);
    _cardResponseMock = @"{\"code\":200,\"data\":{\"payment_token\":\"98aedf334b07165f15ec7a80fdd157d32d86a8fa\",\"card_mask\": \"XXXXXXXXXXXX4000\"}}";
}

- (void)tearDown {
    [[LSNocilla sharedInstance] stop];
    [super tearDown];
}

- (void)testFetchInstallments {
    GNApiEndpoints *gnApi = [[GNApiEndpoints alloc] initWithConfig:_config];
    XCTAssertNotNil(gnApi, @"gnApi should not be nil");
    
    _installmentsStub.andReturn(200)
        .withHeaders(@{@"Content-Type": @"application/json"})
        .withBody(_installmentsResponseMock);
    
    [_gnApi fetchInstallmentsWithMethod:_method]
    .then(^(GNPaymentData *paymentData){
        [_apiExpectation fulfill];
        XCTAssertTrue([paymentData isKindOfClass:[GNPaymentData class]], @"paymentData should be an instance of GNPaymentData");
    })
    .catch(^(GNError *error){
        [_apiExpectation fulfill];
        XCTAssertNil(error, @"request should respond successfully");
    });
    
    [self waitForExpectationsWithTimeout:3.0 handler:nil];
}

- (void)testFetchInstallmentsError {
    _installmentsStub.andReturn(200)
        .withHeaders(@{@"Content-Type": @"application/json"});
    
    [_gnApi fetchInstallmentsWithMethod:_method]
    .then(^(GNPaymentData *paymentData){
        [_apiExpectation fulfill];
        XCTFail(@"request should return error");
    })
    .catch(^(GNError *error){
        [_apiExpectation fulfill];
        XCTAssertNotNil(error, @"error should not be nil");
    });
    
    [self waitForExpectationsWithTimeout:3.0 handler:nil];
}


- (void)testPaymentTokenForCreditCard {
    _pubkeyStub.andReturn(200)
        .withHeaders(@{@"Content-Type": @"application/json"})
        .withBody(_pubkeyResponseMock);
    
    _cardStub.andReturn(200)
        .withHeaders(@{@"Content-Type": @"application/json"})
        .withBody(_cardResponseMock);
    
    [_gnApi paymentTokenForCreditCard:_creditCard]
    .then(^(GNPaymentToken *paymentToken){
        [_apiExpectation fulfill];
        XCTAssertTrue([paymentToken isKindOfClass:[GNPaymentToken class]], @"paymentToken should be an instance of GNPaymentToken");
    })
    .catch(^(GNError *error){
        [_apiExpectation fulfill];
        XCTAssertNil(error, @"request should respond successfully");
    });
    
    [self waitForExpectationsWithTimeout:3.0 handler:nil];
}

- (void)testPaymentTokenForCreditCardError {
    _pubkeyStub.andReturn(200)
        .withHeaders(@{@"Content-Type": @"application/json"})
        .withBody(_pubkeyResponseMock);
    
    _cardStub.andReturn(200)
        .withHeaders(@{@"Content-Type": @"application/json"});
    
    [_gnApi paymentTokenForCreditCard:_creditCard]
    .then(^(GNPaymentData *paymentData){
        [_apiExpectation fulfill];
        XCTFail(@"card request should return error");
    })
    .catch(^(GNError *error){
        [_apiExpectation fulfill];
        XCTAssertEqualObjects(error.message, @"Invalid response data.", @"error message should be 'Invalid response data.'");
    });
    
    [self waitForExpectationsWithTimeout:3.0 handler:nil];
}

@end
