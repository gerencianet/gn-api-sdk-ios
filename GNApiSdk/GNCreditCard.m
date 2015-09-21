//
//  GNCreditCard.m
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 5/5/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import "GNCreditCard.h"

@implementation GNCreditCard

- (instancetype)initWithNumber:(NSString *)number brand:(NSString *)brand expirationMonth:(NSString *)expirationMonth expirationYear:(NSString *)expirationYear cvv:(NSString *)cvv {
    self = [super init];
    _number = number;
    _brand = brand;
    _expirationMonth = expirationMonth;
    _expirationYear = expirationYear;
    _cvv = cvv;
    return self;
}

- (NSDictionary *)paramsDicionary {
    return @{@"number": self.number,
             @"brand": self.brand,
             @"cvv": self.cvv,
             @"expiration_month": self.expirationMonth,
             @"expiration_year": self.expirationYear };
}

@end
