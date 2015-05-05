//
//  GNBolPaymentMethod.m
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 5/5/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import "GNBolPaymentMethod.h"

@implementation GNBolPaymentMethod

- (instancetype)initWithMethod:(NSString *)method JSON:(NSJSONSerialization *)json {
    return [super initWithMethod:@"bol" JSON:json];
}

@end
