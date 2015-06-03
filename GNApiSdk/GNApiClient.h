//
//  GNApiClient.h
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 5/5/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "GNConfig.h"
#import "GNError.h"

@interface GNApiClient : NSObject

@property (strong, nonatomic) GNConfig *config;

- (instancetype) initWithConfig:(GNConfig *)config;
- (void) post:(NSString *)route params:(NSDictionary *)params callback:(void (^)(NSDictionary *response, GNError *error))callback;

@end
