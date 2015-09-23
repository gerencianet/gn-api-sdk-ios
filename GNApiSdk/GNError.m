//
//  GNError.m
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 5/5/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import "GNError.h"

@implementation GNError

NSString *const kGNErrorApiDomain = @"GNErrorApiDomain";

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSInteger code = [[dictionary objectForKey:@"code"] integerValue];
    self = [super initWithDomain:kGNErrorApiDomain code:code userInfo:nil];
    _message = [self stringFromErrorObject: [dictionary objectForKey:@"error_description"]];
    return self;
}

- (instancetype)initWithCode:(NSInteger)code message:(NSString *)message {
    self = [super initWithDomain:kGNErrorApiDomain code:code userInfo:nil];
    _message = message;
    return self;
}

- (NSString *) stringFromErrorObject:(id)object {
    NSString *err = @"";
    if([object isKindOfClass:[NSString class]]){
        return object;
    }
    else if([object isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dictionary = object;
        for (NSString *key in dictionary) {
            id value = [object objectForKey:key];
            err = [err stringByAppendingFormat:@"%@: %@. ", key, [self stringFromErrorObject:value]];
        }
    }
    return err;
}

@end
