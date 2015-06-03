//
//  GNPaymentToken.m
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 5/5/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import "GNPaymentToken.h"

@implementation GNPaymentToken

- (instancetype) initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    dictionary = [dictionary valueForKey:@"data"];
    _token = [dictionary objectForKey:@"payment_token"];
    _cardMask = [dictionary objectForKey:@"card_mask"];
    return self;
}

@end
