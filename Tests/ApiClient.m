//
//  ApiClient.m
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 6/25/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <AFNetworking/AFNetworking.h>
#import <OCMock/OCMock.h>
#import "GNApiSdk.h"

@interface ApiClient : XCTestCase

@end


@implementation ApiClient

- (void)setUp {
    
}

- (void)tearDown {
    
}

- (void)testAccountCodeNotDefined {
    GNConfig *config = [[GNConfig alloc] initWithAccountCode:nil sandbox:YES];
    GNApiEndpoints *gnApi = [[GNApiEndpoints alloc] initWithConfig:config];
    
    GNMethod *method = [[GNMethod alloc] initWithType:kGNMethodTypeVisa total:@(1000)];
    XCTAssertThrowsSpecificNamed([gnApi fetchPaymentDataWithMethod:method], NSException, @"Account code not defined");
}

- (void)testSuccessfulApiCall {
    
}

@end
