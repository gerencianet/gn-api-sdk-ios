//
//  ViewController.m
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 5/5/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import "ViewController.h"
#import "GNApiSdk.h"


@interface ViewController () <UIPickerViewDataSource, UIPickerViewDelegate, GNApiEndpointsDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *cardBrandPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *methodsPickerView;
@property (weak, nonatomic) IBOutlet UITextField *totalValueTextField;
@property (weak, nonatomic) IBOutlet UITextField *cardNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *monthTextField;
@property (weak, nonatomic) IBOutlet UITextField *yearTextField;
@property (weak, nonatomic) IBOutlet UITextField *cvvTextField;
@property (weak, nonatomic) IBOutlet UILabel *paymentTokenLabel;

@property (strong, nonatomic) NSArray *cardBrands;
@property (strong, nonatomic) GNPaymentMethod *paymentMethod;
@property (strong, nonatomic) GNApiEndpoints *gnApi;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _cardBrands = @[kGNMethodNameAmex, kGNMethodNameAura, kGNMethodNameDiners, kGNMethodNameDiscover, kGNMethodNameElo, kGNMethodNameJCB, kGNMethodNameMasterCard, kGNMethodNameVisa];
    _cardBrandPickerView.dataSource = self;
    _cardBrandPickerView.delegate = self;
    [_cardBrandPickerView selectRow:3 inComponent:0 animated:NO];
    
    _methodsPickerView.dataSource = self;
    _methodsPickerView.delegate = self;
    
    
    GNConfig *gnConfig = [[GNConfig alloc] init];
    gnConfig.clientId = @"Client_Id_b2aed0d7c655ea4bfe69b38375f3f56dc723ece8";
    gnConfig.clientSecret = @"Client_Secret_59092c0be17ed15ce35e63cef42ae7e6cf03ed75";
    gnConfig.grantType = kGNConfigGrantTypeClientCredentials;
    gnConfig.sandbox = YES;
    
    _gnApi = [[GNApiEndpoints alloc] initWithConfig:gnConfig];
    _gnApi.delegate = self;
}


# pragma mark - IBActions

- (IBAction)getMethodsButtonPressed {
    NSString *methodName = _cardBrands[[_cardBrandPickerView selectedRowInComponent:0]];
    NSNumber *totalValue = [[NSNumberFormatter alloc] numberFromString:_totalValueTextField.text];
    GNMethod *method = [[GNMethod alloc] initWithName:methodName total:totalValue];
    [_gnApi fetchPaymentMethods:method];
}

- (IBAction)getPaymentTokenButtonPressed {
    GNCreditCard *creditCard = [[GNCreditCard alloc] init];
    creditCard.number = _cardNumberTextField.text;
    creditCard.brand = _cardBrands[[_cardBrandPickerView selectedRowInComponent:0]];
    creditCard.expirationMonth = _monthTextField.text;
    creditCard.expirationYear = _yearTextField.text;
    creditCard.cvv = _cvvTextField.text;
    
    [_gnApi paymentTokenForCreditCard:creditCard];
}


# pragma mark - UIPickerViewDelegate / UIPickerViewDataSource

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if(pickerView==_cardBrandPickerView){
        return _cardBrands.count;
    }
    else if(pickerView==_methodsPickerView){
        if(_paymentMethod){
            return _paymentMethod.installments.count;
        } else {
            return 0;
        }
    }
    return 0;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    if(!view){
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        view = label;
    }
    
    if(pickerView==_cardBrandPickerView){
        [(UILabel *)view setText:_cardBrands[row]];
    } else if(pickerView==_methodsPickerView){
        GNInstallment *installment = _paymentMethod.installments[row];
        NSString *text = [NSString stringWithFormat:@"%dx de R$%@", installment.parcels.intValue, installment.currency];
        [(UILabel *)view setText:text];
    }
    return view;
}


#pragma mark - GNApiEndpointsDelegate

- (void)gnApiFetchPaymentMethodsFinished:(GNPaymentMethod *)paymentMethod error:(GNError *)error {
    if(!error){
        _paymentMethod = paymentMethod;
        [_methodsPickerView reloadAllComponents];
    }
    else {
        NSLog(@"%@", error);
    }
}

- (void)gnApiPaymentTokenForCreditCardFinished:(GNPaymentToken *)paymentToken error:(GNError *)error {
    if(!error){
        _paymentTokenLabel.text = [NSString stringWithFormat:@"Payment token: %@", paymentToken.token];
    }
    else {
        NSLog(@"%@", error.message);
    }
}

@end
