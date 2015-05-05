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

@end
