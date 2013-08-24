//
//  EZLeg.h
//  EZMove
//
//  Created by Paul John Parreno on 8/24/13.
//  Copyright (c) 2013 Charles Anthony Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EZLeg : NSObject

@property (nonatomic, strong) NSMutableArray *stepsArray;
@property (nonatomic, strong) NSString *start_address;
@property (nonatomic, strong) NSString *end_address;

@end
