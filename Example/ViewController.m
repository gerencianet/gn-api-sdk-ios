//
//  ViewController.m
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 5/5/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import "ViewController.h"
#import "GNApiSdk.h"
#import "RegexKitLite.h"


@interface ViewController () <GNApiEndpointsDelegate>

@property (weak, nonatomic) IBOutlet UITextField *cardNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *cvvTextField;
@property (weak, nonatomic) IBOutlet UITextField *monthTextField;
@property (weak, nonatomic) IBOutlet UITextField *yearTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *cardBrandControl;
@property (weak, nonatomic) IBOutlet UILabel *serverResponseLabel;

@property (strong, nonatomic) NSArray *cardBrands;
@property (strong, nonatomic) GNPaymentMethod *paymentMethod;
@property (strong, nonatomic) GNApiEndpoints *gnApi;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     * SETUP YOUR CREDENTIALS TO USE THE TEST APP
     */
    GNConfig *gnConfig = [[GNConfig alloc] init];
    gnConfig.clientId = @"YOUR_CLIENT_ID";
    gnConfig.clientSecret = @"YOUR_CLIENT_SECRET";
    gnConfig.grantType = kGNConfigGrantTypeClientCredentials;
    gnConfig.sandbox = YES;
    
    _gnApi = [[GNApiEndpoints alloc] initWithConfig:gnConfig];
    _gnApi.delegate = self;
}


# pragma mark - IBActions

- (IBAction)onPayButtonPressed {
    if([self validate]){
        GNCreditCard *creditCard = [[GNCreditCard alloc] init];
        creditCard.number = _cardNumberTextField.text;
        creditCard.brand = _cardBrandControl.selectedSegmentIndex==0 ? kGNMethodNameVisa : kGNMethodNameMasterCard;
        creditCard.expirationMonth = _monthTextField.text;
        creditCard.expirationYear = _yearTextField.text;
        creditCard.cvv = _cvvTextField.text;
        
        [_gnApi paymentTokenForCreditCard:creditCard];
    }
}


# pragma mark - GNApiEndpointsDelegate

- (void)gnApiPaymentTokenForCreditCardFinished:(GNPaymentToken *)paymentToken error:(GNError *)error {
    if(!error){
        _serverResponseLabel.text = [NSString stringWithFormat:@"Your payment token is %@", paymentToken.token];
    }
    else {
        _serverResponseLabel.text = [NSString stringWithFormat:@"Error: %d - %@", error.code.intValue, error.message];
    }
}


# pragma mark - Helper

- (BOOL) validate {
    if(![_cardNumberTextField.text isMatchedByRegex:@"^[0-9]{16}$"]){
        [self alert:@"Card number must contain 16 numeric chars."];
        return NO;
    }
    else if(![_cvvTextField.text isMatchedByRegex:@"^[0-9]{3}$"]){
        [self alert:@"CVV must contain 3 numeric chars."];
        return NO;
    }
    else if(![_monthTextField.text isMatchedByRegex:@"^[0-9]{2}$"]){
        [self alert:@"Month must contain 2 numeric chars."];
        return NO;
    }
    else if(![_yearTextField.text isMatchedByRegex:@"^[0-9]{4}$"]){
        [self alert:@"Year must contain 4 numeric chars."];
        return NO;
    }
    return YES;
}

- (void) alert:(NSString *)message {
    [[[UIAlertView alloc] initWithTitle:@"Oops!" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
}

@end
