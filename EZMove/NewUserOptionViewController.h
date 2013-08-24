//
//  NewUserOptionViewController.h
//  EZMove
//
//  Created by Charles Anthony Yu on 8/19/13.
//  Copyright (c) 2013 Charles Anthony Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewUserOptionViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIButton *btnManual;
@property (nonatomic, strong) IBOutlet UIButton *btnAutomatic;
@property (nonatomic, strong) IBOutlet UIView *contentView;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

- (IBAction)onManualSelected:(id)sender;
- (IBAction)onAutomaticSelected:(id)sender;

@end
