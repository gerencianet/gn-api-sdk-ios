//
//  GNMethod.h
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 5/5/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GNMethod : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSNumber *total;

- (instancetype) initWithName:(NSString *)name total:(NSNumber *)number;


extern NSString *const kGNMethodNameVisa;
extern NSString *const kGNMethodNameMasterCard;
extern NSString *const kGNMethodNameAmex;
extern NSString *const kGNMethodNameDiners;
extern NSString *const kGNMethodNameDiscover;
extern NSString *const kGNMethodNameJCB;
extern NSString *const kGNMethodNameElo;
extern NSString *const kGNMethodNameAura;
extern NSString *const kGNMethodNameBoleto;

@end
