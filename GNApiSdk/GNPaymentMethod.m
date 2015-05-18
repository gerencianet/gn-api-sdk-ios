//
//  GNPaymentMethod.m
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 5/4/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import "GNPaymentMethod.h"
#import "GNInstallment.h"

@implementation GNPaymentMethod

- (instancetype)initWithMethod:(NSString *)methodName JSON:(NSJSONSerialization *)json {
    self = [super init];
    _methodName = methodName;
    NSJSONSerialization *methodJSON = [json valueForKey:@"method"];
    if(methodJSON){
        _total = [methodJSON valueForKey:@"total"];
        _rate = [methodJSON valueForKey:@"rate"];
        _currency = [methodJSON valueForKey:@"currency"];
        _interestPercentage = [methodJSON valueForKey:@"interest_percentage"];
        
        NSMutableArray *installments = [[NSMutableArray alloc] init];
        NSArray *installmentsData = [methodJSON valueForKey:@"installments"];
        for (NSJSONSerialization *installmentJSON in installmentsData) {
            GNInstallment *installment = [[GNInstallment alloc] initWithJSON:installmentJSON];
            [installments addObject:installment];
        }
        _installments = installments;
    }
    return self;
}

@end
