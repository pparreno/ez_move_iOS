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
#import "EZRoute.h"

@interface SelStartPointViewController ()

@property (nonatomic, retain) GMSMapView *mapView;

@end

@implementation SelStartPointViewController{
  
    
}

@synthesize locationManager, currentLocation;
@synthesize someButton;
@synthesize mapView;

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
    self.mapView = [GMSMapView mapWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) camera:nil];
    
    // Get Current Location
    self.mapView.myLocationEnabled = YES;
    self.mapView.settings.myLocationButton = YES;
    locationManager = [[CLLocationManager alloc] init];
    [locationManager startUpdatingLocation];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:locationManager.location.coordinate.latitude
                                                            longitude:locationManager.location.coordinate.longitude
                                                                 zoom:15];
    [self.mapView animateToCameraPosition:camera];
    [self.view insertSubview:self.mapView belowSubview:self.someButton];

    
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
        NSArray *routeArray = [dictionary objectForKey:@"routes"];
        NSDictionary *routeItem = [routeArray objectAtIndex:0];
        NSDictionary *overviewPolylineDictionary = [routeItem objectForKey:@"overview_polyline"];
        NSString *encodedPolyline = [overviewPolylineDictionary valueForKey:@"points"];
        
        GMSPolyline *polyLine = [EZRoute generatePolylineWithEncodedString:encodedPolyline];
        polyLine.strokeWidth = 7.5f;
        polyLine.map = self.mapView;
        
        NSLog(@"ROUTES: %@", encodedPolyline);
        NSLog(@"POLYLINE: %@", polyLine);
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
