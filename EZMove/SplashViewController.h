//
//  SplashViewController.h
//  EZMove
//
//  Created by Charles Anthony Yu on 8/4/13.
//  Copyright (c) 2013 Charles Anthony Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SplashViewController : UIViewController

@property(nonatomic, strong) IBOutlet UIButton *btnStart;
@property(nonatomic, strong) IBOutlet UIButton *btnSavedTrips;

-(IBAction)startEZMove:(id)sender;
-(IBAction)goToSavedTrips:(id)sender;

@end
