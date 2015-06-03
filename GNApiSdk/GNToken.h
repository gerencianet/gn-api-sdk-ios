//
//  GNToken.h
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 5/5/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GNToken : NSObject

@property (strong, nonatomic, readonly) NSString *accessToken;
@property (strong, nonatomic, readonly) NSDate *expiresAt;

- (instancetype) initWithDictionary:(NSDictionary *)dictionary;
- (BOOL) hasExpired;

@end
