//
//  EZRoute.m
//  EZMove
//
//  Created by Paul John Parreno on 8/24/13.
//  Copyright (c) 2013 Charles Anthony Yu. All rights reserved.
//

#import "EZRoute.h"

@implementation EZRoute

+ (GMSPolyline *)generatePolylineWithEncodedString:(NSString *)encodedString
{
    GMSMutablePath *mutablePath = [GMSMutablePath pathFromEncodedPath:encodedString];
    GMSPolyline *polyLine = [GMSPolyline polylineWithPath:mutablePath];
    return polyLine;
}

@end
