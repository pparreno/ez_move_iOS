//
//  EZWSForGMSPolylineInfo.h
//  EZMove
//
//  Created by Paul John Parreno on 8/24/13.
//  Copyright (c) 2013 Charles Anthony Yu. All rights reserved.
//

#import "EZWebServiceRequest.h"

@interface EZWSForGMSPolylineInfo : EZWebServiceRequest

- (id)initWithStringRequest: (NSString *) requestString;

//for test purposes
- (id)initWithURL: (NSURL *) url withIsInbound: (BOOL) isInBound;

@end
