//
//  GNMethod.m
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 5/5/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import "GNMethod.h"

@implementation GNMethod

- (instancetype)initWithName:(NSString *)name total:(NSNumber *)total {
    self = [super init];
    _name = name;
    _total = total;
    return self;
}

@end
