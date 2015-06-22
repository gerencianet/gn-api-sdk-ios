//
//  GNConfig.h
//  GNApiSdk
//
//  Created by Thomaz Feitoza on 5/5/15.
//  Copyright (c) 2015 Gerencianet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GNConfig : NSObject

@property (strong, nonatomic) NSString *accountCode;
@property (nonatomic) BOOL sandbox;

- (instancetype) initWithAccountCode:(NSString *)accountCode sandbox:(BOOL)sandbox;

@end
