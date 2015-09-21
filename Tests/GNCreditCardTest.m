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

@property (strong, nonatomic) GNCreditCard *creditCard;

@end

@implementation GNCreditCardTest

- (void)setUp {
    _creditCard = [[GNCreditCard alloc] initWithNumber:@"1000200030004000" brand:kGNMethodBrandDiners expirationMonth:@"12" expirationYear:@"2018" cvv:@"123"];
}

- (void)tearDown {
    _creditCard = nil;
}

- (void)testInitialization {
    _creditCard = [[GNCreditCard alloc] initWithNumber:@"1000200030004000" brand:kGNMethodBrandDiners expirationMonth:@"12" expirationYear:@"2018" cvv:@"123"];
    XCTAssertNotNil(_creditCard, @"GNCreditCard instance should not be nil");
    XCTAssertEqualObjects(_creditCard.number, @"1000200030004000", @"creditCard number should be equal to 1000200030004000");
    XCTAssertEqualObjects(_creditCard.brand, kGNMethodBrandDiners, @"creditCard brand should be equal to diners");
    XCTAssertEqualObjects(_creditCard.expirationMonth, @"12", @"creditCard expirationMonth should be equal to 12");
    XCTAssertEqualObjects(_creditCard.expirationYear, @"2018", @"creditCard expirationYear should be equal to 2018");
    XCTAssertEqualObjects(_creditCard.cvv, @"123", @"creditCard cvv should be equal to 123");
}

- (void) testParamsDictionary {
    NSDictionary *params = [_creditCard paramsDicionary];
    NSDictionary *keyMap = @{@"number": @"number",
                             @"brand": @"brand",
                             @"cvv": @"cvv",
                             @"expiration_month": @"expirationMonth",
                             @"expiration_year": @"expirationYear"};
    for (NSString *paramKey in keyMap) {
        id methodValue = [_creditCard valueForKey:[keyMap valueForKey:paramKey]];
        id paramValue = [params valueForKey:paramKey];
        XCTAssertEqual(paramValue, methodValue, @"params values should be equal the properties in GNCreditCard instance");
    }
    
}

@end
