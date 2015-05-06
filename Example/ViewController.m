//
//  ViewController.m
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 5/5/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import "ViewController.h"
#import "GNApiSdk.h"


@interface ViewController () <GNApiEndpointsDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GNConfig *config = [[GNConfig alloc] initWithClientId:@"Client_Id_b2aed0d7c655ea4bfe69b38375f3f56dc723ece8" clientSecret:@"Client_Secret_59092c0be17ed15ce35e63cef42ae7e6cf03ed75"];
    config.sandbox = YES;

    GNMethod *method = [[GNMethod alloc] initWithName:@"visa" total:@(5000)];
    GNCreditCard *creditCard = [[GNCreditCard alloc] initWithNumber:@"1234123412341234" brand:@"visa" expirationMonth:@"05" expirationYear:@"2019" cvv:@"129"];
    
    GNApiEndpoints *endpoints = [[GNApiEndpoints alloc] initWithConfig:config];
    endpoints.delegate = self;
    [endpoints fetchPaymentMethods:method];
    [endpoints paymentTokenForCreditCard:creditCard];
}

- (void)gnApiFetchPaymentMethodsFinished:(GNPaymentMethod *)paymentMethod error:(GNError *)error {
    NSLog(@"Fetch Payment: %@ - %@", error.message, error.code);
}

- (void)gnApiPaymentTokenForCreditCardFinished:(GNPaymentToken *)paymentMethod error:(GNError *)error {
    NSLog(@"Token credit: %@ - %@", error.message, error.code);
}

@end
