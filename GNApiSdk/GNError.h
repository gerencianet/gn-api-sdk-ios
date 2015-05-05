//
//  GNError.h
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 5/5/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GNError : NSObject

@property (strong, nonatomic, readonly) NSNumber *code;
@property (strong, nonatomic, readonly) NSString *message;

- (instancetype) initWithJSON:(NSJSONSerialization *)json;
- (instancetype) initWithCode:(NSNumber *)code message:(NSString *)message;

@end
