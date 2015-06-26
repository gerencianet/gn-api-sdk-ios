//
//  GNPaymentDataTests.m
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 6/26/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@interface GNPaymentDataTests : XCTestCase

@end

@implementation GNPaymentDataTests

- (void)testInitialization {
    NSArray *installmentsArray = @[@{@"installment":@(1),
                                         @"value":@(10250),
                                         @"has_interest":[NSNumber numberWithBool:YES],
                                         @"currency":@"102,50"},
                                   @{@"installment":@(2),
                                     @"value":@(5125),
                                     @"has_interest":[NSNumber numberWithBool:YES],
                                     @"currency":@"51,25"}];
    
    NSDictionary *paymentDataDict = @{@"data": @{
                                              @"total":@(10000),
                                              @"rate":@(250),
                                              @"currency":@"110,00",
                                              @"interest_percentage":@(1),
                                              @"installments": installmentsArray}};
    
    GNMethod *method = OCMClassMock([GNMethod class]);
    GNPaymentData *paymentData = [[GNPaymentData alloc] initWithMethod:method dictionary:paymentDataDict];
    
    XCTAssertNotNil(paymentData, @"GNPaymentData instance should not be nil");
    XCTAssertEqualObjects(paymentData.total, @(10000), @"paymentData total should be equal to 10000");
    XCTAssertEqualObjects(paymentData.rate, @(250), @"paymentData rate should be equal to 250");
    XCTAssertEqualObjects(paymentData.currency, @"110,00", @"paymentData  currency should be equal to '110,00'");
    XCTAssertEqualObjects(paymentData.interestPercentage, @(1), @"paymentData interestPercentage should be");
    XCTAssertTrue(paymentData.installments.count==2, @"paymentData should have 2 installments");
}

@end
