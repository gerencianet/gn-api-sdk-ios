//
//  GNApiEndpoints.h
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 5/5/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import "GNApiAuth.h"
#import "GNMethod.h"
#import "GNPaymentData.h"
#import "GNError.h"
#import "GNCreditCard.h"
#import "GNPaymentToken.h"


@protocol GNApiEndpointsDelegate <NSObject>

@optional
- (void) gnApiFetchPaymentDataFinished:(GNPaymentData *)paymentData error:(GNError *)error;
- (void) gnApiPaymentTokenForCreditCardFinished:(GNPaymentToken *)paymentToken error:(GNError *)error;

@end


@interface GNApiEndpoints : GNApiAuth

@property (weak, nonatomic) id<GNApiEndpointsDelegate> delegate;

- (void)fetchPaymentDataWithMethod:(GNMethod *)method;
- (void)fetchPaymentDataWithMethod:(GNMethod *)method completion:(void (^)(GNPaymentData *paymentData, GNError *error))completion;

- (void)paymentTokenForCreditCard:(GNCreditCard *)creditCard;
- (void)paymentTokenForCreditCard:(GNCreditCard *)creditCard completion:(void (^)(GNPaymentToken *paymentToken, GNError *error))completion;

@end