//
//  GNMethod.h
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 5/5/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GNMethod : NSObject

@property (strong, nonatomic) NSString *brand;
@property (strong, nonatomic) NSNumber *total;

- (instancetype) initWithBrand:(NSString *)brand total:(NSNumber *)number;

- (NSDictionary *) paramsDicionary;

extern NSString *const kGNMethodBrandVisa;
extern NSString *const kGNMethodBrandMasterCard;
extern NSString *const kGNMethodBrandAmex;
extern NSString *const kGNMethodBrandDiners;
extern NSString *const kGNMethodBrandElo;
extern NSString *const kGNMethodBrandHipercard;
extern NSString *const kGNMethodBrandBankingBillet;

@end
