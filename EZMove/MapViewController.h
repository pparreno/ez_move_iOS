//
//  MapViewController.h
//  EZMove
//
//  Created by Charles Anthony Yu on 8/4/13.
//  Copyright (c) 2013 Charles Anthony Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapViewController : UIViewController
@property (nonatomic, strong) IBOutlet UIButton *btnLocate;

- (IBAction)getCurrentLocation:(id)sender;
@end
