//
//  GNApiAuth.m
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 5/5/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import "GNApiAuth.h"
#import "GNToken.h"

@interface GNApiAuth ()

@property (strong, nonatomic) GNToken *token;

@end


@implementation GNApiAuth

NSString *const kGNApiRouteAuth = @"/authorize";

- (instancetype)initWithConfig:(GNConfig *)config {
    self = [super initWithConfig:config];
    return self;
}

- (BOOL) needsAuthorization {
    return !_token || [_token hasExpired];
}

- (NSDictionary *) authRequestData {
    return @{
             @"grant_type": self.config.grantType,
             @"client_secret": self.config.clientSecret,
             @"client_id": self.config.clientId
             };
}

- (NSDictionary *) requestParamsWithToken:(NSDictionary *)params {
    NSMutableDictionary *paramWithAuth = [params mutableCopy];
    [paramWithAuth addEntriesFromDictionary:@{@"access_token": _token.accessToken}];
    return paramWithAuth;
}

- (void) post:(NSString *)route params:(NSDictionary *)params callback:(void (^)(NSJSONSerialization *, GNError *))callback {
    if([self needsAuthorization]){
        [super post:kGNApiRouteAuth params:[self authRequestData] callback:^(NSJSONSerialization *json, GNError *error){
            if(!error){
                _token = [[GNToken alloc] initWithJSON:json];
                [super post:route params:[self requestParamsWithToken:params] callback:callback];
            }
            else {
                if(callback){
                    callback(nil, error);
                }
            }
        }];
    }
    else {
        [super post:route params:[self requestParamsWithToken:params] callback:callback];
    }
}

@end