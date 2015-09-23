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

- (PMKPromise *) request:(NSString *)route method:(NSString *)method params:(NSDictionary *)params {
    if(!_config.accountCode){
        [NSException raise:@"Account code not defined" format:@"Please setup your GN account code before making requests"];
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@", (_config.sandbox ? kGNApiBaseUrlSandbox : kGNApiBaseUrlProduction), route];
    AFHTTPRequestOperationManager *httpManager = [AFHTTPRequestOperationManager manager];
    [httpManager.requestSerializer setValue:_config.accountCode forHTTPHeaderField:@"account-code"];
    
    return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
        
        id successBlock = ^(AFHTTPRequestOperation *operation, id responseObject) {
            NSError *err = nil;
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableContainers error:&err];
            GNError *gnApiErr = nil;
            if(err){
                gnApiErr = [[GNError alloc] initWithCode:500 message:@"Invalid response data."];
                reject(gnApiErr);
            }
            else if([responseDict objectForKey:@"error"]){
                gnApiErr = [[GNError alloc] initWithDictionary:responseDict];
                reject(gnApiErr);
            }
            else {
                fulfill(responseDict);
            }
        };
        
        id failureBlock = ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSError *err;
            NSDictionary *responseDict;
            GNError *gnApiErr;
            if(operation.responseData){
                responseDict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableContainers error:&err];
            }
            if(!err && responseDict){
                gnApiErr = [[GNError alloc] initWithDictionary:responseDict];
            } else {
                gnApiErr = [[GNError alloc] initWithCode:500 message:@"Invalid response data."];
            }
            
            reject(gnApiErr);
        };
        
        
        if ([method isEqualToString:@"POST"]) {
            [httpManager POST:url parameters:params success:successBlock failure:failureBlock];
        } else if ([method isEqualToString:@"GET"]) {
            [httpManager GET:url parameters:params success:successBlock failure:failureBlock];
        }
    }];
}

@end
