//
//  AppDelegate.m
//  EZMove
//
//  Created by Charles Anthony Yu on 8/4/13.
//  Copyright (c) 2013 Charles Anthony Yu. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeNavViewController.h"
#import "MapViewController.h"
#import "MenuViewController.h"
#import "RoutesViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Google Maps API Key
    [GMSServices provideAPIKey:@"AIzaSyD3myOe2BRIHkxTWwQoxSWHOLrIXWWYhOM"];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Step 1: Create your controllers.
    MapViewController *mapVC = [[MapViewController alloc] init];
    HomeNavViewController *homeNavVC = [[HomeNavViewController alloc] initWithRootViewController:mapVC];
    MenuViewController *menuVC = [[MenuViewController alloc] init];
    RoutesViewController *rightVC = [[RoutesViewController alloc] init];
    
    // Step 3: Instantiate your PKRevealController.
    self.revealController = [PKRevealController revealControllerWithFrontViewController:homeNavVC leftViewController:menuVC rightViewController:rightVC options:nil];

    // Step 4: Set it as your root view controller.
    self.window.rootViewController = self.revealController;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
