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
#import "AppDelegate.h"
#import "SelDestinationViewController.h"

@interface SelStartPointViewController ()

@property (nonatomic, retain) GMSMapView *mapView;

@end

@implementation SelStartPointViewController{
  
    UIBarButtonItem *btnNext;
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
    
    self.title = NSLocalizedString(@"Starting Point", @"Starting Point");
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
    btnNext = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.rightBarButtonItem = btnNext;
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
    [self.navigationItem.rightBarButtonItem setAction:@selector(nextBtnClicked)];
    
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

    EZWSForGMSPolylineInfo *polyLineWS = [[EZWSForGMSPolylineInfo alloc] initWithURL:nil withIsInbound:NO];
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
        polyLine.strokeColor = [UIColor greenColor];
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
    
    
    EZWSForGMSPolylineInfo *polyLineWSInbound = [[EZWSForGMSPolylineInfo alloc] initWithURL:nil withIsInbound:YES];
    [polyLineWSInbound.request setCompletionBlock:^{
        NSData *responseData = [polyLineWSInbound.request responseData];
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
    
    [polyLineWSInbound.request setFailedBlock:^{
        NSError *error = [polyLineWSInbound.request error];
        NSLog(@"FAILURE DESCRIPTION %@", [error localizedDescription]);
        NSLog(@"FAILURE REASON %@", [error localizedFailureReason]);
        [progress hide:YES];
    }];

    
    [polyLineWS.request startAsynchronous];
    [polyLineWSInbound.request startAsynchronous];
    [progress show:YES];

    
}

-(void)markStartingPoints
{
    CLLocationCoordinate2D startPos1 = CLLocationCoordinate2DMake(10.31700, 123.907825);
    GMSMarker *marker1 = [GMSMarker markerWithPosition:startPos1];
    [marker1 setAnimated:YES];
    marker1.map = mapView;
    
    CLLocationCoordinate2D startPos2 = CLLocationCoordinate2DMake(10.31899, 123.907900);
    GMSMarker *marker2 = [GMSMarker markerWithPosition:startPos2];
    marker2.title = @"Hello World";
    [marker2 setAnimated:YES];
    marker2.map = mapView;
}


-(BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select An Action" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"Cancel" otherButtonTitles: @"Set as Starting Point", @"View Details", nil];
    [actionSheet showInView:self.view];
    
    return YES;
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            // Cancel
            break;
        case 1:
            // Set as Starting Point
            [self.navigationItem.rightBarButtonItem setEnabled:YES];
            break;
        case 2:
            // View Details
            break;
        default:
            break;
    }
}

-(void)nextBtnClicked
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    SelDestinationViewController *selDesVC = [[SelDestinationViewController alloc] init];
    [appDelegate.appNavController pushViewController:selDesVC animated:YES];
}

@end
