//
//  GNApiClient.m
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 5/5/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import "GNApiClient.h"


@implementation GNApiClient

NSString *const kGNApiBaseUrlProduction = @"https://api.gerencianet.com.br/v1";
NSString *const kGNApiBaseUrlSandbox = @"https://sandbox.gerencianet.com.br/v1";

- (instancetype)initWithConfig:(GNConfig *)config {
    self = [super init];
    _config = config;
    return self;
}

- (void)post:(NSString *)route params:(NSDictionary *)params callback:(void (^)(NSDictionary *, GNError *))callback {
    NSString *url = [NSString stringWithFormat:@"%@%@", (_config.sandbox ? kGNApiBaseUrlSandbox : kGNApiBaseUrlProduction), route];
    AFHTTPRequestOperationManager *httpManager = [AFHTTPRequestOperationManager manager];
    
    [httpManager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(callback){
            NSError *err = nil;
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableContainers error:&err];
            GNError *gnApiErr = nil;
            if(err){
                gnApiErr = [[GNError alloc] initWithCode:@(500) message:@"Invalid response data."];
                responseDict = nil;
            }
            else if([responseDict objectForKey:@"error"]){
                gnApiErr = [[GNError alloc] initWithDictionary:responseDict];
                responseDict = nil;
            }
            callback(responseDict, gnApiErr);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(callback){
            NSError *err;
            NSDictionary *responseDict;
            GNError *gnApiErr;
            if(operation.responseData){
                responseDict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableContainers error:&err];
            }
            if(!err && responseDict){
                gnApiErr = [[GNError alloc] initWithDictionary:responseDict];
            } else {
                gnApiErr = [[GNError alloc] initWithCode:@(500) message:@"Invalid response data."];
            }
            
            callback(nil, gnApiErr);
        }
    }];
}

@end
