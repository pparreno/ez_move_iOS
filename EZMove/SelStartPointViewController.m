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
    // Get current location
    mapView_.myLocationEnabled = YES;
    
    //CLLocation *myLocation = mapView_.myLocation;
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:10.3178f
                                                            longitude:123.9050f
                                                                 zoom:17];
    mapView_ = [GMSMapView mapWithFrame:self.view.bounds camera:camera];
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(10.3178f, 123.9050f);
    GMSMarker *marker = [GMSMarker markerWithPosition:position];
    marker.title = @"You are here";
    marker.map = mapView_;
//    [self.view addSubview:mapView_];
    [self.view insertSubview:mapView_ belowSubview:self.someButton];
    
    
    // Initialize navigation bar
    self.title = @"New Trip";
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:40/255.0f green:48/255.0f blue:50/255.0f alpha:1.0f];
    
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
