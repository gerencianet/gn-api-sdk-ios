//
//  GNError.h
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 5/5/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GNError : NSError

@property (strong, nonatomic, readonly) NSString *message;

- (instancetype) initWithDictionary:(NSDictionary *)dictionary;
- (instancetype) initWithCode:(NSInteger)code message:(NSString *)message;

extern NSString *const kGNErrorApiDomain;

@end
