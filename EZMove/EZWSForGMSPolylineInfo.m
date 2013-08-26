//
//  EZWSForGMSPolylineInfo.m
//  EZMove
//
//  Created by Paul John Parreno on 8/24/13.
//  Copyright (c) 2013 Charles Anthony Yu. All rights reserved.
//

#import "EZWSForGMSPolylineInfo.h"

//#define DUMMY_URL @"https://maps.googleapis.com/maps/api/directions/json?origin=10.31068,123.917888&destination=10.318795,123.903735&sensor=false&waypoints=10.316006,123.913666|10.317948,123.908409"
#define DUMMY_URL_OUTBOUND @"https://maps.googleapis.com/maps/api/directions/json?origin=10.31068,123.917888&destination=10.318795,123.903735&sensor=false&waypoints=optimize:true|10.318919,123.911914|10.3195,123.908929|10.316343,123.908883|10.316156,123.906072|10.317402,123.903382|10.320231,123.904043"
#define DUMMY_URL_INBOUND @"https://maps.googleapis.com/maps/api/directions/json?origin=10.318795,123.903735&destination=10.31068,123.917888&sensor=false&waypoints=optimize:true|10.316003,123.906131|10.316306,123.909017|10.320416,123.910908|10.31356,123.917949|10.309631,123.919996"

@implementation EZWSForGMSPolylineInfo

-(id)initWithStringRequest:(NSString *)requestString
{
    self = [super init];
    if(self)
    {
        NSURL *url = [NSURL URLWithString:[requestString stringByAddingPercentEscapesUsingEncoding:
                                           NSASCIIStringEncoding]];
        self.request = [ASIHTTPRequest requestWithURL:url];
    }
    
    return self;
}

- (id)initWithURL:(NSURL *)url withIsInbound:(BOOL)isInBound
{
    self = [super init];
    if(self)
    {
        NSString *urlString;
        if (!isInBound) {
            urlString = [NSString stringWithFormat:@"%@",DUMMY_URL_OUTBOUND];
        } else {
            urlString = [NSString stringWithFormat:@"%@",DUMMY_URL_INBOUND];
        }
        
        //Create a URL object.
        NSURL *myURL = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:
                                           NSASCIIStringEncoding]];
        self.request = [ASIHTTPRequest requestWithURL:myURL];
    }
    
    return self;
}


@end
