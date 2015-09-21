//
//  GNApiEndpoints.m
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 5/5/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import "GNApiEndpoints.h"

@implementation GNApiEndpoints

NSString *const kGNApiRoutePaymentData = @"/installments";
NSString *const kGNApiRouteSaveCard = @"/card";

- (void)fetchPaymentDataWithMethod:(GNMethod *)method {
    [self fetchPaymentDataWithMethod:method completion:^(GNPaymentData *paymentData, GNError *error) {
        if(_delegate && [_delegate respondsToSelector:@selector(gnApiFetchPaymentDataFinished:error:)]){
            [_delegate gnApiFetchPaymentDataFinished:paymentData error:error];
        }
    }];
}

- (void)fetchPaymentDataWithMethod:(GNMethod *)method completion:(void (^)(GNPaymentData *paymentData, GNError *error))completion {
    NSDictionary *params = [method paramsDicionary];
    [self request:kGNApiRoutePaymentData method:@"GET" params:params callback:^(NSDictionary *response, GNError *error) {
        if(completion){
            GNPaymentData *paymentData;
            if(!error){
                paymentData = [[GNPaymentData alloc] initWithMethod:method dictionary:response];
            }
            completion(paymentData, error);
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
    NSDictionary *params = [creditCard paramsDicionary];
    [self request:kGNApiRouteSaveCard method:@"POST" params:params callback:^(NSDictionary *response, GNError *error) {
        if(completion){
            GNPaymentToken *paymentToken;
            if(!error){
                paymentToken = [[GNPaymentToken alloc] initWithDictionary:response];
            }
            completion(paymentToken, error);
        }
    }];
}

- (NSString *) getJSONStringFromDictionary:(NSDictionary *)dict {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
