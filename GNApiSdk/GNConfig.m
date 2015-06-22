//
//  GNConfig.m
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 5/5/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import "GNConfig.h"

@implementation GNConfig

- (instancetype) initWithAccountCode:(NSString *)accountCode sandbox:(BOOL)sandbox {
    self = [super init];
    _accountCode = accountCode;
    _sandbox = sandbox;
    return self;
}

@end
