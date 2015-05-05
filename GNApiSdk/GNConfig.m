//
//  GNConfig.m
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 5/5/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import "GNConfig.h"

@implementation GNConfig

NSString *const kGNConfigGrantTypeClientCredentials = @"client_credentials";

- (instancetype)initWithClientId:(NSString *)clientId clientSecret:(NSString *)clientSecret {
    self = [super init];
    _grantType = kGNConfigGrantTypeClientCredentials;
    _clientId = clientId;
    _clientSecret = clientSecret;
    _sandbox = NO;
    return self;
}

@end
