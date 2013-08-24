//
//  EZWSForGMSPolylineInfo.m
//  EZMove
//
//  Created by Paul John Parreno on 8/24/13.
//  Copyright (c) 2013 Charles Anthony Yu. All rights reserved.
//

#import "EZWSForGMSPolylineInfo.h"

#define DUMMY_URL @"https://maps.googleapis.com/maps/api/directions/json?origin=10.31068,123.917888&destination=10.318795,123.903735&sensor=false&waypoints=10.316006,123.913666|10.317948,123.908409"

@implementation EZWSForGMSPolylineInfo

-(id)initWithURL:(NSURL *)url
{
    self = [super init];
    if(self)
    {
//        self.request = [ASIHTTPRequest requestWithURL:url];
        NSString *urlString = [NSString stringWithFormat:@"%@",DUMMY_URL];
        //Create a URL object.
        NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:
                                           NSASCIIStringEncoding]];
        self.request = [ASIHTTPRequest requestWithURL:url];
    }
    
    return self;
}


@end
