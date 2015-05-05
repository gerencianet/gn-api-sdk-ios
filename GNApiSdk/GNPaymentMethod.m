//
//  GNPaymentMethod.m
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 5/4/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import "GNPaymentMethod.h"

@implementation GNPaymentMethod

- (instancetype)initWithJSON:(NSJSONSerialization *)json {
    self = [super init];
    
    NSJSONSerialization *methodJSON = [json valueForKey:@"method"];
    if(methodJSON){
        _total = [methodJSON valueForKey:@"total"];
        _rate = [methodJSON valueForKey:@"rate"];
        _currency = [methodJSON valueForKey:@"currency"];
        _total = [methodJSON valueForKey:@"total"];
        _interestPercentage = [methodJSON valueForKey:@"interest_percentage"];
        
        
    }
    return self;
}

@end
