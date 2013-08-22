//
//  SelStartPointViewController.m
//  EZMove
//
//  Created by Paul John Parreno on 8/17/13.
//  Copyright (c) 2013 Charles Anthony Yu. All rights reserved.
//

#import "SelStartPointViewController.h"
#import "NewUserOptionViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface SelStartPointViewController ()

@end

@implementation SelStartPointViewController{
    GMSMapView *mapView_;
}
@synthesize locationManager, currentLocation;
@synthesize btnBack, btnNext, lbStartingPoint, viewBg;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Initialize map
    mapView_ = [GMSMapView mapWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) camera:nil];
    
    // Get Current Location
    mapView_.myLocationEnabled = YES;
    mapView_.settings.myLocationButton = YES;
    locationManager = [[CLLocationManager alloc] init];
    [locationManager startUpdatingLocation];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:locationManager.location.coordinate.latitude
                                                            longitude:locationManager.location.coordinate.longitude
                                                                 zoom:15];
    [mapView_ animateToCameraPosition:camera];
    //    CLLocationCoordinate2D curPosition = CLLocationCoordinate2DMake(locationManager.location.coordinate.latitude,locationManager.location.coordinate.longitude);
    [self.view insertSubview:mapView_ belowSubview:self.someButton];

    
    // Initialize layout
    [[self navigationController] setNavigationBarHidden:YES];
    [self.view addSubview:viewBg];
    [self.view addSubview:btnBack];
    [self.view addSubview:lbStartingPoint];
    [self.view addSubview:btnNext];

    
    // Show Modal Option
    NewUserOptionViewController *modalOptionVC = [[NewUserOptionViewController alloc]init];
    [self presentViewController:modalOptionVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
