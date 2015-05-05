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

- (void)fetchPaymentMethods:(GNMethod *)method delegate:(id<GNApiEndpointsDelegate>)delegate {
    [self fetchPaymentMethods:method completion:^(GNPaymentMethod *paymentMethod, GNError *error) {
        if([delegate respondsToSelector:@selector(gnApiFetchPaymentMethodsFinished:error:)]){
            [delegate gnApiFetchPaymentMethodsFinished:paymentMethod error:error];
        }
    }];
}

- (void)fetchPaymentMethods:(GNMethod *)method completion:(void (^)(GNPaymentMethod *paymentMethod, GNError *error))completion {
    NSDictionary *params = @{@"data": [self getJSONStringFromDictionary:@{@"method": method.name, @"total": method.total}]};
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

- (NSString *) getJSONStringFromDictionary:(NSDictionary *)dict {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
