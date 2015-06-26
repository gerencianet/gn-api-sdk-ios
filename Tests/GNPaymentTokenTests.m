//
//  GNPaymentTokenTests.m
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 6/26/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface GNPaymentTokenTests : XCTestCase

@end

@implementation GNPaymentTokenTests

- (void)testInitialization {
    NSDictionary *paymentTokenDict = @{@"data": @{
                                               @"payment_token": @"ad8f76s87dv6s9d8689w657asd6f7W6E5FA78S6D578",
                                               @"card_mask": @"XXXXXXXXXXXX1234"}};
    GNPaymentToken *paymentToken = [[GNPaymentToken alloc] initWithDictionary:paymentTokenDict];
    XCTAssertNotNil(paymentToken, @"GNPaymentToken instance should not be nil");
    XCTAssertEqualObjects(paymentToken.token, @"ad8f76s87dv6s9d8689w657asd6f7W6E5FA78S6D578", @"paymentToken token should be equal to 'ad8f76s87dv6s9d8689w657asd6f7W6E5FA78S6D578'");
    XCTAssertEqualObjects(paymentToken.cardMask, @"XXXXXXXXXXXX1234", @"paymentToken cardMask should be equal to 'ad8f76s87dv6s9d8689w657asd6f7W6E5FA78S6D578'");
}

@end
