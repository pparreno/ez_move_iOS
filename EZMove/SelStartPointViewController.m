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
    self.mapView = [GMSMapView mapWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-45) camera:nil];
    
    // Get Current Location
    self.mapView.myLocationEnabled = YES;
    self.mapView.settings.myLocationButton = YES;
    locationManager = [[CLLocationManager alloc] init];
    [locationManager startUpdatingLocation];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:locationManager.location.coordinate.latitude
                                                            longitude:locationManager.location.coordinate.longitude
                                                                 zoom:16];
    [mapView animateToCameraPosition:camera];
    [self.view addSubview:mapView];
    self.mapView.delegate = self;
    
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

-(void)markStartingPoints
{
    CLLocationCoordinate2D startPos1 = CLLocationCoordinate2DMake(10.31700, 123.907825);
    GMSMarker *marker1 = [GMSMarker markerWithPosition:startPos1];
    marker1.map = mapView;
    [self mapView:mapView markerInfoWindow:marker1];
    CLLocationCoordinate2D startPos2 = CLLocationCoordinate2DMake(10.31899, 123.907900);
    GMSMarker *marker2 = [GMSMarker markerWithPosition:startPos2];
    marker2.title = @"Hello World";
    marker2.map = mapView;
}


// Set-up pop up infor window
- (UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker*)marker
{
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 175, 80)];
    customView.backgroundColor = [UIColor colorWithWhite:-1 alpha:0.5];
    
    UILabel *lbStartingPoint = [[UILabel alloc] init];
    lbStartingPoint.text = @"Set as start point?";
    lbStartingPoint.textColor = [UIColor whiteColor];
    lbStartingPoint.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    [lbStartingPoint setFrame:CGRectMake(5, 3, 150, 35)];
    
    UIButton *btnSet = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnSet setTitle:@"Set" forState:UIControlStateNormal];
    [btnSet setFrame:CGRectMake(5, 40, 80, 35)];
    [btnSet addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    [btnSet setBackgroundColor:[UIColor orangeColor]];
    [btnSet setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    UIButton *btnView = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnView setTitle:@"View" forState:UIControlStateNormal];
    [btnView setFrame:CGRectMake(90, 40, 80, 35)];
    [btnView addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    [btnView setBackgroundColor:[UIColor orangeColor]];
    [btnView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [customView addSubview:lbStartingPoint];
    [customView addSubview:btnSet];
    [customView addSubview:btnView];

    return customView;
}

@end
