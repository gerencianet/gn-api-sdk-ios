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

@property (weak, nonatomic) IBOutlet UISegmentedControl *methodTypeControl;
@property (weak, nonatomic) IBOutlet UITextField *totalValueTextField;
@property (weak, nonatomic) IBOutlet UIButton *getPaymentDataButton;

@property (weak, nonatomic) IBOutlet UITextField *cardNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *cvvTextField;
@property (weak, nonatomic) IBOutlet UITextField *monthTextField;
@property (weak, nonatomic) IBOutlet UITextField *yearTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *cardBrandControl;
@property (weak, nonatomic) IBOutlet UIButton *getPaymentTokenButton;

@property (weak, nonatomic) IBOutlet UILabel *serverResponseLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

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

- (IBAction)onGetPaymentDataButtonPressed {
    if([self validateGetPaymentData]){
        NSString *methodType;
        switch (_methodTypeControl.selectedSegmentIndex) {
            default:
                methodType = kGNMethodTypeVisa;
                break;
            case 1:
                methodType = kGNMethodTypeMasterCard;
                break;
            case 2:
                methodType = kGNMethodTypeBankingBillet;
                break;
        }
        
        NSString *totalValueString = _totalValueTextField.text;
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        NSNumber *totalValue = [formatter numberFromString:totalValueString];
        totalValue = @(totalValue.doubleValue * 100);
        
        GNMethod *gnMethod = [[GNMethod alloc] initWithType:methodType total:totalValue];
        [_gnApi fetchPaymentDataWithMethod:gnMethod];
        [self setLoading:YES];
    }
}

- (IBAction)onPayButtonPressed {
    if([self validatePay]){
        GNCreditCard *creditCard = [[GNCreditCard alloc] init];
        creditCard.number = _cardNumberTextField.text;
        creditCard.brand = _cardBrandControl.selectedSegmentIndex==0 ? kGNMethodTypeVisa : kGNMethodTypeMasterCard;
        creditCard.expirationMonth = _monthTextField.text;
        creditCard.expirationYear = _yearTextField.text;
        creditCard.cvv = _cvvTextField.text;
        
        [_gnApi paymentTokenForCreditCard:creditCard];
        [self setLoading:YES];
    }
}


# pragma mark - GNApiEndpointsDelegate

- (void)gnApiFetchPaymentDataFinished:(GNPaymentData *)paymentData error:(GNError *)error {
    [self setLoading:NO];
    if(!error){
        NSString *response = [NSString stringWithFormat:@"Method Type: %@\n", paymentData.methodType];
        if(paymentData.installments.count==0){
            response = [NSString stringWithFormat:@"%@Total: R$%.2f\nRate: R$%.2f", response, paymentData.total.doubleValue/100, paymentData.rate.doubleValue/100];
        }
        else {
            response = [response stringByAppendingString:@"Installments:\n"];
            for(GNInstallment *installment in paymentData.installments){
                response = [NSString stringWithFormat:@"%@%dx R$%.2f\n", response, installment.parcels.intValue, installment.value.doubleValue/100 ];
            }
        }
        
        _serverResponseLabel.text = [NSString stringWithFormat:@"Route: /payment/data\n%@", response];
    } else {
        _serverResponseLabel.text = [NSString stringWithFormat:@"Route: /payment/data\nError: %d - %@", error.code.intValue, error.message];
    }
}

- (void)gnApiPaymentTokenForCreditCardFinished:(GNPaymentToken *)paymentToken error:(GNError *)error {
    [self setLoading:NO];
    if(!error){
        _serverResponseLabel.text = [NSString stringWithFormat:@"Route: /card\nYour payment token is %@", paymentToken.token];
    }
    else {
        _serverResponseLabel.text = [NSString stringWithFormat:@"Route: /card\nError: %d - %@", error.code.intValue, error.message];
    }
}


# pragma mark - Helper

- (BOOL) validateGetPaymentData {
    if(![_totalValueTextField.text isMatchedByRegex:@"^[0-9]+(\\.[0-9]{2})?$"]){
        [self alert:@"Insert a valid total value."];
        return NO;
    }
    return YES;
}

- (BOOL) validatePay {
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

- (void) setLoading:(BOOL)isLoading {
    if(isLoading){
        [_activityIndicator startAnimating];
        [_getPaymentDataButton setEnabled:NO];
        [_getPaymentTokenButton setEnabled:NO];
    }
    else {
        [_activityIndicator stopAnimating];
        [_getPaymentDataButton setEnabled:YES];
        [_getPaymentTokenButton setEnabled:YES];
    }
}

@end
