//
//  GNPaymentData.m
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 5/4/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import "GNPaymentData.h"
#import "GNInstallment.h"

@implementation GNPaymentData

- (instancetype) initWithMethod:(GNMethod *)method dictionary:(NSDictionary *)dictionary {
    self = [super init];
    dictionary = [dictionary valueForKey:@"data"];
    
    _methodBrand = method.brand;
    _total = [dictionary objectForKey:@"total"];
    _rate = [dictionary objectForKey:@"rate"];
    _currency = [dictionary objectForKey:@"currency"];
    _interestPercentage = [dictionary objectForKey:@"interest_percentage"];
    
    NSMutableArray *installments = [[NSMutableArray alloc] init];
    NSArray *installmentsData = [dictionary objectForKey:@"installments"];
    for (NSDictionary *instDict in installmentsData) {
        GNInstallment *installment = [[GNInstallment alloc] initWithDictionary:instDict];
        [installments addObject:installment];
    }
    _installments = installments;
    return self;
}

@end
