//
//  GNInstallmentTests.m
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 6/26/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface GNInstallmentTests : XCTestCase

@end

@implementation GNInstallmentTests

- (void)testInitialization {
    NSDictionary *installmentDict = @{@"installment":@(4),
                                      @"value":@(1550),
                                      @"has_interest":[NSNumber numberWithBool:YES],
                                      @"currency":@"15,50"};
    GNInstallment *installment = [[GNInstallment alloc] initWithDictionary:installmentDict];
    XCTAssertNotNil(installment, @"GNInstallment instance should not be nil");
    XCTAssertEqualObjects(installment.parcels, @(4), @"installment parcels should be equal to 4");
    XCTAssertEqualObjects(installment.value, @(1550), @"installment value should be equal to 1550");
    XCTAssertEqualObjects(installment.hasInterest, @(1), @"installment hasInterest should be equal to 1");
    XCTAssertEqualObjects(installment.currency, @"15,50", @"installment currency should be equal to '15,50'");
}

@end
