//
//  NewUserOptionViewController.m
//  EZMove
//
//  Created by Charles Anthony Yu on 8/19/13.
//  Copyright (c) 2013 Charles Anthony Yu. All rights reserved.
//

#import "NewUserOptionViewController.h"

@interface NewUserOptionViewController ()

@end

@implementation NewUserOptionViewController

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

- (IBAction)onManualSelected:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onAutomaticSelected:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
