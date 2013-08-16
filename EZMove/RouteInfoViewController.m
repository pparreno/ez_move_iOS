//
//  RouteInfoViewController.m
//  EZMove
//
//  Created by Charles Anthony Yu on 8/17/13.
//  Copyright (c) 2013 Charles Anthony Yu. All rights reserved.
//

#import "RouteInfoViewController.h"

@interface RouteInfoViewController ()

@end

@implementation RouteInfoViewController{
    NSArray *routePoints;
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
    // Initialization
    routePoints = [NSArray arrayWithObjects:@"Cebu City Hall",@"Stop near Julie's Bakeshop",@"Stop in front of SOGO Hotel",@"Carbon Market", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Table View Methods

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [routePoints count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tripStopsIdentifier = @"TripStop";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tripStopsIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tripStopsIdentifier];
    }
    cell.textLabel.text = [routePoints objectAtIndex:indexPath.row];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    [cell.textLabel setFont:[UIFont fontWithName:@"Verdana" size:18.0]];
    return cell;
}

-(UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *viewFooter = [[UIView alloc] initWithFrame:CGRectMake(0 ,0 , 0, 0)];
    return viewFooter;
}

@end
