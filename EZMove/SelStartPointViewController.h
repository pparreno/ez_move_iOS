//
//  SelStartPointViewController.h
//  EZMove
//
//  Created by Paul John Parreno on 8/17/13.
//  Copyright (c) 2013 Charles Anthony Yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface SelStartPointViewController : UIViewController <CLLocationManagerDelegate>


@property (nonatomic, strong) IBOutlet UIButton* someButton;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;


@end
