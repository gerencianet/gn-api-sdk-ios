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


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *methodBrandControl;
@property (weak, nonatomic) IBOutlet UITextField *totalValueTextField;
@property (weak, nonatomic) IBOutlet UIButton *getInstallmentsButton;

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
    
    GNConfig *gnConfig = [[GNConfig alloc] initWithAccountCode:@"YOUR_ACCOUNT_CODE" sandbox:YES];
    _gnApi = [[GNApiEndpoints alloc] initWithConfig:gnConfig];
}


# pragma mark - IBActions

- (IBAction)onGetInstallmentsButtonPressed {
    if([self validateGetInstallments]){
        NSArray *methods = @[kGNMethodBrandVisa, kGNMethodBrandMasterCard, kGNMethodBrandBankingBillet];
        NSString *methodBrand = methods[_methodBrandControl.selectedSegmentIndex];
        
        NSString *totalValueString = _totalValueTextField.text;
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        NSNumber *totalValue = [formatter numberFromString:totalValueString];
        totalValue = @(totalValue.doubleValue * 100);
        
        GNMethod *gnMethod = [[GNMethod alloc] initWithBrand:methodBrand total:totalValue];
        
        
        // API call and response handling
        [_gnApi fetchInstallmentsWithMethod:gnMethod]
        .then(^(GNPaymentData *paymentData) {
            [self setLoading:NO];
            NSString *response = [NSString stringWithFormat:@"Method Brand: %@\n", paymentData.methodBrand];
            if(paymentData.installments.count==0){
                response = [NSString stringWithFormat:@"%@Total: R$%.2f\nRate: R$%.2f", response, paymentData.total.doubleValue/100, paymentData.rate.doubleValue/100];
            }
            else {
                response = [response stringByAppendingString:@"Installments:\n"];
                for(GNInstallment *installment in paymentData.installments){
                    response = [NSString stringWithFormat:@"%@%dx R$%.2f\n", response, installment.parcels.intValue, installment.value.doubleValue/100 ];
                }
            }
            
            _serverResponseLabel.text = [NSString stringWithFormat:@"Route: /installments\n%@", response];
        })
        .catch(^(GNError *error) {
            [self setLoading:NO];
            _serverResponseLabel.text = [NSString stringWithFormat:@"Route: /installments\nError: %ld - %@", (long)error.code, error.message];
        });
        
        [self setLoading:YES];
        [self.view endEditing:YES];
    }
}

- (IBAction)onPayButtonPressed {
    if([self validatePay]){
        GNCreditCard *creditCard = [[GNCreditCard alloc] init];
        creditCard.number = _cardNumberTextField.text;
        creditCard.brand = _cardBrandControl.selectedSegmentIndex==0 ? kGNMethodBrandVisa : kGNMethodBrandMasterCard;
        creditCard.expirationMonth = _monthTextField.text;
        creditCard.expirationYear = _yearTextField.text;
        creditCard.cvv = _cvvTextField.text;
        
        // API call and response handling
        [_gnApi paymentTokenForCreditCard:creditCard]
        .then(^(GNPaymentToken *paymentToken) {
            [self setLoading:NO];
            _serverResponseLabel.text = [NSString stringWithFormat:@"Route: /card\nYour payment token for the card %@ is %@", paymentToken.cardMask, paymentToken.token];
        })
        .catch(^(GNError *error){
            [self setLoading:NO];
            _serverResponseLabel.text = [NSString stringWithFormat:@"Route: /card\nError: %ld - %@", (long)error.code, error.message];
        });
        
        [self setLoading:YES];
        [self.view endEditing:YES];
    }
}


# pragma mark - Helper

- (BOOL) validateGetInstallments {
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
        [_getInstallmentsButton setEnabled:NO];
        [_getPaymentTokenButton setEnabled:NO];
    }
    else {
        [_activityIndicator stopAnimating];
        [_getInstallmentsButton setEnabled:YES];
        [_getPaymentTokenButton setEnabled:YES];
    }
}

@end
