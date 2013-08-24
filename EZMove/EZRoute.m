//
//  EZRoute.m
//  EZMove
//
//  Created by Paul John Parreno on 8/24/13.
//  Copyright (c) 2013 Charles Anthony Yu. All rights reserved.
//

#import "EZRoute.h"

@implementation EZRoute

-(void)drawPolylineWithEncodedString:(NSString *)encodedString onGMSMapView:(GMSMapView *)mapView
{
    GMSMutablePath *mutablePath = [GMSMutablePath pathFromEncodedPath:encodedString];
}

@end
