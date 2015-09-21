//
//  GNMethod.m
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 5/5/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import "GNMethod.h"

@implementation GNMethod

NSString *const kGNMethodBrandVisa = @"visa";
NSString *const kGNMethodBrandMasterCard = @"mastercard";
NSString *const kGNMethodBrandAmex = @"amex";
NSString *const kGNMethodBrandDiners = @"diners";
NSString *const kGNMethodBrandDiscover = @"discover";
NSString *const kGNMethodBrandJCB = @"jcb";
NSString *const kGNMethodBrandElo = @"elo";
NSString *const kGNMethodBrandAura = @"aura";
NSString *const kGNMethodBrandBankingBillet = @"banking_billet";

- (instancetype)initWithBrand:(NSString *)brand total:(NSNumber *)total {
    self = [super init];
    _brand = brand;
    _total = total;
    return self;
}

- (NSDictionary *)paramsDicionary {
    return [self dictionaryWithValuesForKeys:@[@"brand", @"total"]];
}

@end
