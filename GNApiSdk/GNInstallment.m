//
//  GNInstallment.m
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 5/5/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import "GNInstallment.h"

@implementation GNInstallment

- (instancetype)initWithJSON:(NSJSONSerialization *)json {
    self = [super init];
    _parcels = [json valueForKey:@"installment"];
    _value = [json valueForKey:@"value"];
    _hasInterest = [json valueForKey:@"has_interest"];
    _currency = [json valueForKey:@"currency"];
    return self;
}

@end
