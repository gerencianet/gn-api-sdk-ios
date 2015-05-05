//
//  GNApiEndpoints.h
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 5/5/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import "GNApiAuth.h"
#import "GNMethod.h"
#import "GNPaymentMethod.h"
#import "GNError.h"


@protocol GNApiEndpointsDelegate <NSObject>

@optional
- (void) gnApiFetchPaymentMethodsFinished:(GNPaymentMethod *)paymentMethod error:(GNError *)error;

@end


@interface GNApiEndpoints : GNApiAuth

- (void)fetchPaymentMethods:(GNMethod *)method delegate:(id<GNApiEndpointsDelegate>)delegate;
- (void)fetchPaymentMethods:(GNMethod *)method completion:(void (^)(GNPaymentMethod *paymentMethod, GNError *error))completion;

@end