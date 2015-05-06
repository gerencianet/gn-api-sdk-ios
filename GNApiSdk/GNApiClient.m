//
//  GNApiClient.m
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 5/5/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import "GNApiClient.h"


@implementation GNApiClient

NSString *const kGNApiBaseUrlProduction = @"https://api.gerencianet.com.br";
NSString *const kGNApiBaseUrlSandbox = @"https://sandbox.gerencianet.com.br";

- (instancetype)initWithConfig:(GNConfig *)config {
    self = [super init];
    _config = config;
    return self;
}

- (void)post:(NSString *)route params:(NSDictionary *)params callback:(void (^)(NSJSONSerialization *, GNError *))callback {
    NSString *url = [NSString stringWithFormat:@"%@%@", (_config.sandbox ? kGNApiBaseUrlSandbox : kGNApiBaseUrlProduction), route];
    AFHTTPRequestOperationManager *httpManager = [AFHTTPRequestOperationManager manager];
    
    [httpManager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(callback){
            NSError *err = nil;
            NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableContainers error:&err];
            GNError *gnApiErr = nil;
            if(err){
                gnApiErr = [[GNError alloc] initWithCode:@(500) message:@"Invalid response data."];
            }
            else if([json valueForKey:@"error"]){
                gnApiErr = [[GNError alloc] initWithJSON:json];
                json = nil;
            }
            callback(json, gnApiErr);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(callback){
            NSError *err;
            NSJSONSerialization *jsonErr;
            GNError *gnApiErr;
            if(operation.responseData){
                jsonErr = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableContainers error:&err];
            }
            if(!err && jsonErr){
                gnApiErr = [[GNError alloc] initWithJSON:jsonErr];
            } else {
                gnApiErr = [[GNError alloc] initWithCode:@(500) message:@"Invalid response data."];
            }
            callback(nil, gnApiErr);
        }
    }];
}

@end
