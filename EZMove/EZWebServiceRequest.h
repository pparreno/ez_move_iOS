//
//  EZWebServiceRequest.h
//  EZMove
//
//  Created by Paul John Parreno on 8/24/13.
//  Copyright (c) 2013 Charles Anthony Yu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface EZWebServiceRequest : NSObject

@property (nonatomic, weak) ASIHTTPRequest *request;

@end
