//
//  GNToken.m
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 5/5/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import "GNToken.h"

@implementation GNToken

- (instancetype)initWithJSON:(NSJSONSerialization *)json {
    self = [super init];
    if(self) {
        _accessToken = [json valueForKey:@"access_token"];
        _expiresAt = [NSDate dateWithTimeIntervalSinceNow:3600];
    }
    return self;
}

- (BOOL)hasExpired {
    return [[NSDate date] compare:self.expiresAt] != NSOrderedAscending;
}



@end
