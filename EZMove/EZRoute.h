//
//  EZRoute.h
//  EZMove
//
//  Created by Paul John Parreno on 8/24/13.
//  Copyright (c) 2013 Charles Anthony Yu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMaps/GoogleMaps.h>

@interface EZRoute : NSObject

@property (nonatomic, strong) NSMutableArray *legsArray;



- (void) drawPolylineWithEncodedString: (NSString *) encodedString onGMSMapView: (GMSMapView *) mapView;

@end
