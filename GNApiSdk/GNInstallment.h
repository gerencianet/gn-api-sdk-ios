//
//  GNInstallment.h
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 5/5/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GNInstallment : NSObject

@property (strong, nonatomic, readonly) NSNumber *parcels;
@property (strong, nonatomic, readonly) NSNumber *value;
@property (strong, nonatomic, readonly) NSNumber *hasInterest;
@property (strong, nonatomic, readonly) NSString *currency;

- (instancetype) initWithDictionary:(NSDictionary *)dictionary;

@end
