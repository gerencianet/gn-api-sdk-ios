//
//  GNConfigTests.m
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 6/26/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface GNConfigTests : XCTestCase

@end

@implementation GNConfigTests

- (void)testInitialization {
    GNConfig *config = [[GNConfig alloc] initWithAccountCode:@"my_account_code" sandbox:YES];
    XCTAssertNotNil(config, @"config should not be nil");
    XCTAssertEqualObjects(config.accountCode, @"my_account_code", @"config accountCode should be equal to 'my_account_code'");
    XCTAssertEqual(config.sandbox, YES, @"config sandbox should be equal to YES");
}

@end
