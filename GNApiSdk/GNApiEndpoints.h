//
//  GNApiEndpoints.h
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 5/5/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import "GNApiClient.h"
#import "GNMethod.h"
#import "GNPaymentData.h"
#import "GNError.h"
#import "GNCreditCard.h"
#import "GNPaymentToken.h"


@interface GNApiEndpoints : GNApiClient

- (PMKPromise *)fetchInstallmentsWithMethod:(GNMethod *)method;
- (PMKPromise *)paymentTokenForCreditCard:(GNCreditCard *)creditCard;

@end