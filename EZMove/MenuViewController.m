//
//  MenuViewController.m
//  EZMove
//
//  Created by Charles Anthony Yu on 8/15/13.
//  Copyright (c) 2013 Charles Anthony Yu. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController{
    NSArray *menuChoices;
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
    menuChoices = [NSArray arrayWithObjects:@"Current Trip", @"New Trip", @"Saved Trips", @"Routes", @"Settings", @"Help",nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Table View Methods

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [menuChoices count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *menuChoiceIdentifier = @"MenuItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:menuChoiceIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:menuChoiceIdentifier];
    }
    cell.textLabel.text = [menuChoices objectAtIndex:indexPath.row];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    return cell;
}

-(UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *viewFooter = [[UIView alloc] initWithFrame:CGRectMake(0 ,0 , 0, 0)];
    return viewFooter;
}

@end
