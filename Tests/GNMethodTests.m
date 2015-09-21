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

@property (strong, nonatomic) GNMethod *method;

@end

@implementation GNMethodTests

- (void)setUp {
    _method = [[GNMethod alloc] initWithBrand:kGNMethodBrandMasterCard total:@(10000)];
}

- (void)tearDown {
    _method = nil;
}

- (void)testInitialization {
    XCTAssertNotNil(_method, @"GNMethod instance should not be nil");
    XCTAssertEqualObjects(_method.brand, kGNMethodBrandMasterCard, @"method brand should be equal mastercard");
    XCTAssertEqualObjects(_method.total, @(10000), @"method total should be equal 10000");
}

- (void) testParamsDictionary {
    NSDictionary *params = [_method paramsDicionary];
    NSDictionary *keyMap = @{@"brand": @"brand",
                             @"total": @"total"};
    for (NSString *paramKey in keyMap) {
        id methodValue = [_method valueForKey:[keyMap valueForKey:paramKey]];
        id paramValue = [params valueForKey:paramKey];
        XCTAssertEqual(paramValue, methodValue, @"params values should be equal the properties in GNMethod instance");
    }

}

@end
