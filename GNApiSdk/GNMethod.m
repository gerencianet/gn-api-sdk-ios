//
//  GNMethod.m
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 5/5/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import "GNMethod.h"

@implementation GNMethod

NSString *const kGNMethodNameVisa = @"visa";
NSString *const kGNMethodNameMasterCard = @"mastercard";
NSString *const kGNMethodNameAmex = @"amex";
NSString *const kGNMethodNameDiners = @"diners";
NSString *const kGNMethodNameDiscover = @"discover";
NSString *const kGNMethodNameJCB = @"jcb";
NSString *const kGNMethodNameElo = @"elo";
NSString *const kGNMethodNameAura = @"aura";
NSString *const kGNMethodNameBoleto = @"bol";

- (instancetype)initWithName:(NSString *)name total:(NSNumber *)total {
    self = [super init];
    _name = name;
    _total = total;
    return self;
}

@end
