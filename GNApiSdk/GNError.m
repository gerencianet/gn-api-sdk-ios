//
//  GNError.m
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 5/5/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import "GNError.h"

@implementation GNError

- (instancetype)initWithJSON:(NSJSONSerialization *)json {
    self = [super init];
    _code = [json valueForKey:@"code"];
    _message = [json valueForKey:@"error_description"];
    return self;
}

- (instancetype)initWithCode:(NSNumber *)code message:(NSString *)message {
    self = [super init];
    _code = code;
    _message = message;
    return self;
}

@end
