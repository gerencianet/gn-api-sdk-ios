//
//  GNMethodTests.m
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 6/26/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface GNMethodTests : XCTestCase

@end

@implementation GNMethodTests

- (void)testInitialization {
    GNMethod *method = [[GNMethod alloc] initWithType:kGNMethodTypeMasterCard total:@(10000)];
    XCTAssertNotNil(method, @"GNMethod instance should not be nil");
    XCTAssertEqualObjects(method.type, kGNMethodTypeMasterCard, @"method type should be equal mastercard");
    XCTAssertEqualObjects(method.total, @(10000), @"method total should be equal 10000");
}

@end
