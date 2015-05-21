//
//  GNMethod.h
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 5/5/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GNMethod : NSObject

@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSNumber *total;

- (instancetype) initWithType:(NSString *)type total:(NSNumber *)number;


extern NSString *const kGNMethodTypeVisa;
extern NSString *const kGNMethodTypeMasterCard;
extern NSString *const kGNMethodTypeAmex;
extern NSString *const kGNMethodTypeDiners;
extern NSString *const kGNMethodTypeDiscover;
extern NSString *const kGNMethodTypeJCB;
extern NSString *const kGNMethodTypeElo;
extern NSString *const kGNMethodTypeAura;
extern NSString *const kGNMethodTypeBankingBillet;

@end
