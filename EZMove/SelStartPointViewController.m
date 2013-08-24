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
#import "EZWSForGMSPolylineInfo.h"
#import "MBProgressHUD.h"

@interface SelStartPointViewController ()

@end

@implementation SelStartPointViewController{
    GMSMapView *mapView_;
}

@synthesize locationManager, currentLocation;
@synthesize someButton;

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
    
    
    self.title = NSLocalizedString(@"New Trip", @"New Trip");
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
    [self.view insertSubview:mapView_ belowSubview:self.someButton];

    
    // Initialize layout

    NewUserOptionViewController *modalOptionVC = [[NewUserOptionViewController alloc]init];
    [self presentViewController:modalOptionVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    MBProgressHUD *progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    EZWSForGMSPolylineInfo *polyLineWS = [[EZWSForGMSPolylineInfo alloc] initWithURL:nil];
    [polyLineWS.request setCompletionBlock:^{
        NSData *responseData = [polyLineWS.request responseData];
        NSError *error;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
        NSDictionary *routeDictionary = [dictionary objectForKey:@"routes"];
        NSLog(@"ROUTES: %@", routeDictionary);
        [progress hide:YES];
    }];
    
    [polyLineWS.request setFailedBlock:^{
        NSError *error = [polyLineWS.request error];
        NSLog(@"FAILURE DESCRIPTION %@", [error localizedDescription]);
        NSLog(@"FAILURE REASON %@", [error localizedFailureReason]);
        [progress hide:YES];
    }];
    
    [polyLineWS.request startAsynchronous];
    [progress show:YES];

    
}

@end
