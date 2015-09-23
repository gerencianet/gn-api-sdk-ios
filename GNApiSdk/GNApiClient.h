//
//  GNApiClient.h
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 5/5/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import <PromiseKit/PromiseKit.h>
#import "GNConfig.h"
#import "GNError.h"

@interface GNApiClient : NSObject

@property (strong, nonatomic) GNConfig *config;

- (instancetype) initWithConfig:(GNConfig *)config;
- (PMKPromise *) request:(NSString *)route method:(NSString *)method params:(NSDictionary *)params;

extern NSString *const kGNApiBaseUrlProduction;
extern NSString *const kGNApiBaseUrlSandbox;

@end
