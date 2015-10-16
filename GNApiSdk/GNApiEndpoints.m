//
//  GNApiEndpoints.m
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 5/5/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import "GNApiEndpoints.h"
#import "RSA.h"

@implementation GNApiEndpoints

NSString *const kGNApiRouteInstallments = @"/installments";
NSString *const kGNApiRouteSaveCard = @"/card";
NSString *const kGNApiRoutePublicRSAKey = @"/pubkey";

- (PMKPromise *)fetchInstallmentsWithMethod:(GNMethod *)method {
    NSDictionary *params = [method paramsDicionary];
    return [self request:kGNApiRouteInstallments method:@"GET" params:params]
    .then(^(NSDictionary *response){
        return [[GNPaymentData alloc] initWithMethod:method dictionary:response];
    });
}

- (PMKPromise *)paymentTokenForCreditCard:(GNCreditCard *)creditCard {
    NSDictionary *cardDict = [creditCard paramsDicionary];
    NSString *jsonCard = [self getJSONStringFromDictionary:cardDict];
    
    return [self encryptData:jsonCard]
    .then(^(NSString *encryptedData){
        NSDictionary *params = @{@"data":encryptedData};
        return [self request:kGNApiRouteSaveCard method:@"POST" params:params];
    })
    .then(^(NSDictionary *response){
        return [[GNPaymentToken alloc] initWithDictionary:response];
    });
}

- (PMKPromise *) encryptData:(NSString *)data {
    return [self request:kGNApiRoutePublicRSAKey method:@"GET" params:nil]
    .then(^(NSDictionary *response){
        NSString *rsaKey = response[@"data"];
        return [RSA encryptString:data publicKey:rsaKey];
    });
}

- (NSString *) getJSONStringFromDictionary:(NSDictionary *)dict {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
