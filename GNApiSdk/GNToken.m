//
//  GNToken.m
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 5/5/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import "GNToken.h"

@implementation GNToken

- (instancetype) initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    _accessToken = [dictionary objectForKey:@"access_token"];
    
    NSNumber *expiresSeconds = [dictionary objectForKey:@"expires_in"];
    _expiresAt = [NSDate dateWithTimeIntervalSinceNow:expiresSeconds.intValue];
    
    return self;
}

- (BOOL)hasExpired {
    return [[NSDate date] compare:self.expiresAt] != NSOrderedAscending;
}



@end
