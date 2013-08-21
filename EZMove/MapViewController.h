//
//  MapViewController.h
//  EZMove
//
//  Created by Charles Anthony Yu on 8/4/13.
//  Copyright (c) 2013 Charles Anthony Yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewController : UIViewController <CLLocationManagerDelegate>
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;
@end
