//
//  SavedTripsViewController.m
//  EZMove
//
//  Created by Charles Anthony Yu on 8/5/13.
//  Copyright (c) 2013 Charles Anthony Yu. All rights reserved.
//

#import "SavedTripsViewController.h"

@interface SavedTripsViewController ()

@end

@implementation SavedTripsViewController
@synthesize btnBack;

- (IBAction)backToMenu:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
