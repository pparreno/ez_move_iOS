//
//  MenuViewController.m
//  EZMove
//
//  Created by Charles Anthony Yu on 8/15/13.
//  Copyright (c) 2013 Charles Anthony Yu. All rights reserved.
//

#import "MenuViewController.h"
#import "SelStartPointViewController.h"
#import "AppDelegate.h"

@interface MenuViewController ()

@end

@implementation MenuViewController{
    NSArray *menuItems;
    NSArray *menuImages;
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
    // Initialize choices in menu
    menuItems = [NSArray arrayWithObjects:@"EZ-MOVE", @"Current Trip", @"New Trip", @"Saved Trips", @"Routes", @"Settings", @"Help",nil];
    menuImages = [NSArray arrayWithObjects: [[UIImage alloc] init], [UIImage imageNamed:@"btn-current.png"], [UIImage imageNamed:@"btn-new-trip.png"], [UIImage imageNamed:@"btn-saved.png"], [UIImage imageNamed:@"btn-route.png"], [UIImage imageNamed:@"btn-settings.png"], [UIImage imageNamed:@"btn-help.png"],nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark UITableViewDatasource 

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [menuItems count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *menuChoiceIdentifier = @"MenuItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:menuChoiceIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:menuChoiceIdentifier];
    }
    
    if(indexPath.row == 0) {
        [cell.textLabel setFont:[UIFont fontWithName:@"Verdana-Bold" size:19.0]];
        [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
    } else {
        UIView *v = [[UIView alloc] init];
    	v.backgroundColor = [UIColor orangeColor];
    	cell.selectedBackgroundView = v;
        [cell.textLabel setFont:[UIFont fontWithName:@"Verdana" size:18.0]];
    }
    
    cell.textLabel.text = [menuItems objectAtIndex:indexPath.row];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    cell.imageView.image = [menuImages objectAtIndex:indexPath.row];
    
   
    
    return cell;
}

-(UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *viewFooter = [[UIView alloc] initWithFrame:CGRectMake(0 ,0 , 0, 0)];
    return viewFooter;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            break;
        case 2:
        {
            NSLog(@"didSelectRowAtIndexPath #2");
            SelStartPointViewController *selStartDestViewController = [[SelStartPointViewController alloc] init];
            AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
            [appDelegate.revealController showViewController:appDelegate.revealController.frontViewController animated:YES completion:^(BOOL finished) {
              [appDelegate.appNavController pushViewController:selStartDestViewController animated:YES];
            }];
        }
            break;
        default:
            break;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end