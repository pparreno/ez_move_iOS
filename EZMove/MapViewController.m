//
//  MapViewController.m
//  EZMove
//
//  Created by Charles Anthony Yu on 8/4/13.
//  Copyright (c) 2013 Charles Anthony Yu. All rights reserved.
//

#import "MapViewController.h"
#import "PKRevealController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface MapViewController ()

@end

@implementation MapViewController{
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
    // Initialize map
    mapView_ = [GMSMapView mapWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-45) camera:nil];
    
    // Get Current Location
    mapView_.myLocationEnabled = YES;
    mapView_.settings.myLocationButton = YES;
    locationManager = [[CLLocationManager alloc] init];
    [locationManager startUpdatingLocation];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:locationManager.location.coordinate.latitude
                                                            longitude:locationManager.location.coordinate.longitude
                                                                 zoom:15];
    [mapView_ animateToCameraPosition:camera];
    CLLocationCoordinate2D curPosition = CLLocationCoordinate2DMake(locationManager.location.coordinate.latitude,locationManager.location.coordinate.longitude);

    
    // Dummy values
    CLLocationCoordinate2D destination = CLLocationCoordinate2DMake(10.3297f, 123.9072f);
    GMSMarker *desMarker = [GMSMarker markerWithPosition:destination];
    desMarker.icon = [GMSMarker markerImageWithColor:[UIColor redColor]];
    desMarker.map = mapView_;
    GMSMutablePath *path = [GMSMutablePath path];
    [path addCoordinate:curPosition];
    [path addCoordinate:destination];
    GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
    polyline.strokeColor = [UIColor redColor];
    polyline.strokeWidth = 10;
    polyline.map = mapView_;
    [self.view addSubview:mapView_];

    
    // Initialize navigation bar
    self.title = @"TRIP";
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:40/255.0f green:48/255.0f blue:50/255.0f alpha:1.0f];
    
    // Initialize navbar buttons
    UIImage *imgInfoRightIcon = [UIImage imageNamed:@"ic_info.png"];
    UIImage *menuLeftIcon = [UIImage imageNamed:@"ic_menu.png"];
    
    if (self.navigationController.revealController.type & PKRevealControllerTypeLeft)
    {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:menuLeftIcon style:UIBarButtonItemStylePlain target:self action:@selector(showLeftView:)];
    }
    
    if (self.navigationController.revealController.type & PKRevealControllerTypeRight)
    {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:imgInfoRightIcon style:UIBarButtonItemStylePlain target:self action:@selector(showRightView:)];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark PKRevealViewController

- (void)showLeftView:(id)sender
{
    if (self.navigationController.revealController.focusedController == self.navigationController.revealController.leftViewController)
    {
        [self.navigationController.revealController showViewController:self.navigationController.revealController.frontViewController];
    }
    else
    {
        [self.navigationController.revealController showViewController:self.navigationController.revealController.leftViewController];
    }
}

- (void)showRightView:(id)sender
{
    if (self.navigationController.revealController.focusedController == self.navigationController.revealController.rightViewController)
    {
        [self.navigationController.revealController showViewController:self.navigationController.revealController.frontViewController];
    }
    else
    {
        [self.navigationController.revealController showViewController:self.navigationController.revealController.rightViewController];
    }
}

#pragma mark CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"latitude: %f longitude: %f",newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    self.currentLocation = newLocation;    
    if(newLocation.horizontalAccuracy <= 100.0f) {
        [locationManager stopUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if(error.code == kCLErrorDenied) {
        [locationManager stopUpdatingLocation];
    } else if(error.code == kCLErrorLocationUnknown) {
        // retry
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error retrieving location"
                                                        message:[error description]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

@end
