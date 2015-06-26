//
//  GNCreditCardTest.m
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 6/26/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface GNCreditCardTest : XCTestCase

@end

@implementation GNCreditCardTest

- (void)testInitialization {
    GNCreditCard *creditCard = [[GNCreditCard alloc] initWithNumber:@"1000200030004000" brand:kGNMethodTypeDiners expirationMonth:@"12" expirationYear:@"2018" cvv:@"123"];
    XCTAssertNotNil(creditCard, @"GNCreditCard instance should not be nil");
    XCTAssertEqualObjects(creditCard.number, @"1000200030004000", @"creditCard number should be equal to 1000200030004000");
    XCTAssertEqualObjects(creditCard.brand, kGNMethodTypeDiners, @"creditCard brand should be equal to diners");
    XCTAssertEqualObjects(creditCard.expirationMonth, @"12", @"creditCard expirationMonth should be equal to 12");
    XCTAssertEqualObjects(creditCard.expirationYear, @"2018", @"creditCard expirationYear should be equal to 2018");
    XCTAssertEqualObjects(creditCard.cvv, @"123", @"creditCard cvv should be equal to 123");
}

@end
