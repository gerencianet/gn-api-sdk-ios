//
//  GNPaymentToken.m
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 5/5/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import "GNPaymentToken.h"

@implementation GNPaymentToken

- (instancetype)initWithJSON:(NSJSONSerialization *)json {
    self = [super init];
    if(self){
        _token = [[json valueForKey:@"card"] valueForKey:@"payment_token"];
    }
    return self;
}

@end
