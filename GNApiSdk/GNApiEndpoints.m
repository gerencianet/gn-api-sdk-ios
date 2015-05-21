//
//  GNApiEndpoints.m
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 5/5/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import "GNApiEndpoints.h"

@implementation GNApiEndpoints

NSString *const kGNApiRoutePaymentMethods = @"/payment/methods";
NSString *const kGNApiRouteSaveCard = @"/card";

- (void)fetchPaymentMethods:(GNMethod *)method {
    [self fetchPaymentMethods:method completion:^(GNPaymentMethod *paymentMethod, GNError *error) {
        if(_delegate && [_delegate respondsToSelector:@selector(gnApiFetchPaymentMethodsFinished:error:)]){
            [_delegate gnApiFetchPaymentMethodsFinished:paymentMethod error:error];
        }
    }];
}

- (void)fetchPaymentMethods:(GNMethod *)method completion:(void (^)(GNPaymentMethod *paymentMethod, GNError *error))completion {
    NSDictionary *params = [self encapsulateParams: @{@"data": method.name, @"total": method.total}];
    [self post:kGNApiRoutePaymentMethods params:params callback:^(NSJSONSerialization *json, GNError *error) {
        if(completion){
            GNPaymentMethod *payMethod;
            if(!error){
                payMethod = [[GNPaymentMethod alloc] initWithMethod:method.name JSON:json];
            }
            completion(payMethod, error);
        }
    }];
}

- (void)paymentTokenForCreditCard:(GNCreditCard *)creditCard {
    [self paymentTokenForCreditCard:creditCard completion:^(GNPaymentToken *paymentToken, GNError *error) {
        if(_delegate && [_delegate respondsToSelector:@selector(gnApiPaymentTokenForCreditCardFinished:error:)]){
            [_delegate gnApiPaymentTokenForCreditCardFinished:paymentToken error:error];
        }
    }];
}

- (void)paymentTokenForCreditCard:(GNCreditCard *)creditCard completion:(void (^)(GNPaymentToken *, GNError *))completion {
    NSDictionary *params = [self encapsulateParams: @{
                                                      @"brand": creditCard.brand,
                                                      @"number": creditCard.number,
                                                      @"cvv": creditCard.cvv,
                                                      @"expiration_month": creditCard.expirationMonth,
                                                      @"expiration_year": creditCard.expirationYear
                                                    }];
    [self post:kGNApiRouteSaveCard params:params callback:^(NSJSONSerialization *json, GNError *error) {
        if(completion){
            GNPaymentToken *paymentToken;
            if(!error){
                paymentToken = [[GNPaymentToken alloc] initWithJSON:json];
            }
            completion(paymentToken, error);
        }
    }];
}


- (NSDictionary *) encapsulateParams:(NSDictionary *)params {
    return @{@"data":[self getJSONStringFromDictionary:params]};
}

- (NSString *) getJSONStringFromDictionary:(NSDictionary *)dict {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
