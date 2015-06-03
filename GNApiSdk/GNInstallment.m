//
//  GNInstallment.m
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 5/5/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import "GNInstallment.h"

@implementation GNInstallment

- (instancetype) initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    _parcels = [dictionary objectForKey:@"installment"];
    _value = [dictionary objectForKey:@"value"];
    _hasInterest = [dictionary objectForKey:@"has_interest"];
    _currency = [dictionary objectForKey:@"currency"];
    return self;
}

@end
