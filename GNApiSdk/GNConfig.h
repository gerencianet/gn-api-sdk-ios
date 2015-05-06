//
//  GNConfig.h
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 5/5/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GNConfig : NSObject

@property (strong, nonatomic) NSString *clientId;
@property (strong, nonatomic) NSString *clientSecret;
@property (strong, nonatomic, readonly) NSString *grantType;
@property (nonatomic) BOOL sandbox;


- (instancetype) initWithClientId:(NSString *)clientId clientSecret:(NSString *)clientSecret;

@end
