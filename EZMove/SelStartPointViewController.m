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
                                                                 zoom:16];
    [mapView_ animateToCameraPosition:camera];
    [self.view addSubview:mapView_];

    
    // Initialize layout
    NewUserOptionViewController *modalOptionVC = [[NewUserOptionViewController alloc]init];
    [self presentViewController:modalOptionVC animated:YES completion:nil];
    UIBarButtonItem *btnNext = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.rightBarButtonItem = btnNext;
    
    // Display possible starting points
    [self markStartingPoints];
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

-(void)markStartingPoints
{
    CLLocationCoordinate2D startPos1 = CLLocationCoordinate2DMake(10.31700, 123.907825);
    GMSMarker *marker1 = [GMSMarker markerWithPosition:startPos1];
    marker1.map = mapView_;
    [self mapView:mapView_ markerInfoWindow:marker1];
    CLLocationCoordinate2D startPos2 = CLLocationCoordinate2DMake(10.31899, 123.907900);
    GMSMarker *marker2 = [GMSMarker markerWithPosition:startPos2];
    marker2.title = @"Hello World";
    marker2.map = mapView_;
}

-(UIView *)mapView:(GMSMapView *) aMapView markerInfoWindow:(GMSMarker*) marker
{
    UIView *view = [[UIView alloc]init];
    //customize the UIView, for example, in your case, add a UILabel as the subview of the view
    UILabel *txt = [[UILabel alloc] init];
    txt.text = @"HELLO!!!";
    [view addSubview: txt];
    return view;
}

@end
