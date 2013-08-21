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
    // Get current location
    mapView_.myLocationEnabled = YES;
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:10.3178f
                                                            longitude:123.9050f
                                                                 zoom:15];
    mapView_ = [GMSMapView mapWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-45) camera:camera];
    mapView_.myLocationEnabled = YES;
    CLLocationCoordinate2D curPosition = CLLocationCoordinate2DMake(10.3178f,123.9050f);
//    GMSMarker *curPosMarker = [GMSMarker markerWithPosition:curPosition];
//    curPosMarker.title = @"You are here";
//    curPosMarker.map = mapView_;
    
    // Dummy values
    CLLocationCoordinate2D place1 = CLLocationCoordinate2DMake(10.3250f, 123.9060f);
    CLLocationCoordinate2D place2 = CLLocationCoordinate2DMake(10.3270f, 123.9027f);
    CLLocationCoordinate2D place3 = CLLocationCoordinate2DMake(10.3300f, 123.9040f);
    GMSMarker *marker1 = [GMSMarker markerWithPosition:place1];
    marker1.icon = [GMSMarker markerImageWithColor:[UIColor greenColor]];
    marker1.map = mapView_;
    GMSMarker *marker2 = [GMSMarker markerWithPosition:place2];
    marker2.icon = [GMSMarker markerImageWithColor:[UIColor orangeColor]];
    marker2.map = mapView_;
    GMSMarker *marker3 = [GMSMarker markerWithPosition:place3];
    marker3.icon = [GMSMarker markerImageWithColor:[UIColor blueColor]];
    marker3.map = mapView_;
    GMSMutablePath *path1 = [GMSMutablePath path];
    [path1 addCoordinate:curPosition];
    [path1 addCoordinate:place1];
    GMSPolyline *polyline1 = [GMSPolyline polylineWithPath:path1];
    polyline1.strokeColor = [UIColor greenColor];
    polyline1.strokeWidth = 10;
    polyline1.map = mapView_;
    GMSMutablePath *path2 = [GMSMutablePath path];
    [path2 addCoordinate:place1];
    [path2 addCoordinate:place2];
    GMSPolyline *polyline2 = [GMSPolyline polylineWithPath:path2];
    polyline2.strokeColor = [UIColor orangeColor];
    polyline2.strokeWidth = 10;
    polyline2.map = mapView_;
    GMSMutablePath *path3 = [GMSMutablePath path];
    [path3 addCoordinate:place2];
    [path3 addCoordinate:place3];
    GMSPolyline *polyline3 = [GMSPolyline polylineWithPath:path3];
    polyline3.strokeColor = [UIColor blueColor];
    polyline3.strokeWidth = 10;
    polyline3.map = mapView_;
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
    
    mapView_.settings.myLocationButton = YES;
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
    self.currentLocation = newLocation;    
    if(newLocation.horizontalAccuracy <= 100.0f) {
        [locationManager stopUpdatingLocation];
    }
    // Plot current location
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:newLocation.coordinate.latitude
                                                            longitude:newLocation.coordinate.longitude
                                                                 zoom:15];
    mapView_ = [GMSMapView mapWithFrame:self.view.bounds camera:camera];
    CLLocationCoordinate2D curPosition = CLLocationCoordinate2DMake(newLocation.coordinate.latitude,newLocation.coordinate.longitude);
    GMSMarker *curPosMarker = [GMSMarker markerWithPosition:curPosition];
    curPosMarker.title = @"You are here";
    curPosMarker.map = mapView_;
    
    
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
