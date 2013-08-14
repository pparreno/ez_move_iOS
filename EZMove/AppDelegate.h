//
//  AppDelegate.h
//  EZMove
//
//  Created by Charles Anthony Yu on 8/4/13.
//  Copyright (c) 2013 Charles Anthony Yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeNavViewController.h"
#import "PKRevealController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) IBOutlet UIWindow *window;
@property (nonatomic, strong, readwrite) PKRevealController *revealController;

@end
