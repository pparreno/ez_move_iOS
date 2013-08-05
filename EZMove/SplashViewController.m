//
//  SplashViewController.m
//  EZMove
//
//  Created by Charles Anthony Yu on 8/4/13.
//  Copyright (c) 2013 Charles Anthony Yu. All rights reserved.
//

#import "SplashViewController.h"
#import "MapViewController.h"
#import "SavedTripsViewController.h"

@interface SplashViewController ()

@end

@implementation SplashViewController

@synthesize btnStart;
@synthesize btnSavedTrips;

-(IBAction)startEZMove:(id)sender
{
    MapViewController *vcMaps = [[MapViewController alloc]init];
    [self presentViewController:vcMaps animated:YES completion:nil];
}

-(IBAction)goToSavedTrips:(id)sender
{
    SavedTripsViewController *vcSavedTrips = [[SavedTripsViewController alloc]init];
    [self presentViewController:vcSavedTrips animated:YES completion:nil];
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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
