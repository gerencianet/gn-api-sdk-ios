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
@property (nonatomic) BOOL isAuthenticating;
@property (strong, nonatomic) NSMutableArray *requestQueue;

@end


@implementation GNApiAuth

NSString *const kGNApiRouteAuth = @"/authorize";

- (instancetype)initWithConfig:(GNConfig *)config {
    self = [super initWithConfig:config];
    self.isAuthenticating = NO;
    self.requestQueue = [[NSMutableArray alloc] init];
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

- (NSDictionary *) dictionaryFromRequest:(NSString *)route params:(NSDictionary *)params callback:(void (^)(NSJSONSerialization *, GNError *))callback {
    return @{
             @"route":route,
             @"params":params,
             @"callback":callback
             };
}

- (void) post:(NSString *)route params:(NSDictionary *)params callback:(void (^)(NSJSONSerialization *, GNError *))callback {
    if([self needsAuthorization]){
        NSDictionary *requestDictionary = [self dictionaryFromRequest:route params:params callback:callback];
        [_requestQueue addObject:requestDictionary];
        if(!_isAuthenticating){
            _isAuthenticating = YES;
            [super post:kGNApiRouteAuth params:[self authRequestData] callback:^(NSJSONSerialization *json, GNError *error){
                self.isAuthenticating = NO;
                if(!error){
                    _token = [[GNToken alloc] initWithJSON:json];
                    for (NSDictionary *request in _requestQueue) {
                        NSString *route = [request valueForKey:@"route"];
                        NSDictionary *params = [request valueForKey:@"params"];
                        id callback = [request valueForKey:@"callback"];
                        [super post:route params:[self requestParamsWithToken:params] callback:callback];
                    }
                    [_requestQueue removeAllObjects];
                }
                else {
                    if(callback){
                        callback(nil, error);
                    }
                }
            }];
        }
    }
    else {
        [super post:route params:[self requestParamsWithToken:params] callback:callback];
    }
}

@end