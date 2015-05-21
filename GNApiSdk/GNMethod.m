//
//  GNMethod.m
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 5/5/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import "GNMethod.h"

@implementation GNMethod

NSString *const kGNMethodTypeVisa = @"visa";
NSString *const kGNMethodTypeMasterCard = @"mastercard";
NSString *const kGNMethodTypeAmex = @"amex";
NSString *const kGNMethodTypeDiners = @"diners";
NSString *const kGNMethodTypeDiscover = @"discover";
NSString *const kGNMethodTypeJCB = @"jcb";
NSString *const kGNMethodTypeElo = @"elo";
NSString *const kGNMethodTypeAura = @"aura";
NSString *const kGNMethodTypeBankingBillet = @"banking_billet";

- (instancetype)initWithType:(NSString *)type total:(NSNumber *)total {
    self = [super init];
    _type = type;
    _total = total;
    return self;
}

@end
