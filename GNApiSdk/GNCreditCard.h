//
//  GNCreditCard.h
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 5/5/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import "GNPaymentData.h"

@interface GNCreditCard : NSObject

@property (strong, nonatomic) NSString *number;
@property (strong, nonatomic) NSString *brand;
@property (strong, nonatomic) NSString *expirationMonth;
@property (strong, nonatomic) NSString *expirationYear;
@property (strong, nonatomic) NSString *cvv;

- (instancetype) initWithNumber:(NSString *)number brand:(NSString *)brand expirationMonth:(NSString *)expirationMonth expirationYear:(NSString *)expirationYear cvv:(NSString *)cvv;

- (NSDictionary *) paramsDicionary;

@end
