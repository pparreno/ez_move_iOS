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
@property (nonatomic, strong) IBOutlet UIView *viewBg;
@property (nonatomic, strong) IBOutlet UIButton *btnBack;
@property (nonatomic, strong) IBOutlet UIButton *btnNext;
@property (nonatomic, strong) IBOutlet UILabel *lbStartingPoint;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;
@end
