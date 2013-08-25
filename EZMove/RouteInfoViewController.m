//
//  RouteInfoViewController.m
//  EZMove
//
//  Created by Charles Anthony Yu on 8/17/13.
//  Copyright (c) 2013 Charles Anthony Yu. All rights reserved.
//

#import "RouteInfoViewController.h"
#import "RouteInfoTableCell.h"

@interface RouteInfoViewController ()

@end

@implementation RouteInfoViewController{
    NSArray *routePlaces;
    NSArray *routeInstructions;
    NSArray *routeFares;
    NSArray *routeIcons;
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
    routePlaces = [NSArray arrayWithObjects:@"Cebu City Hall",@"Stop near Julie's Bakeshop",@"Stop in front of SOGO Hotel",@"Carbon Market", nil];
    routeInstructions = [NSArray arrayWithObjects:@"Ride 13C jeepney to next point.",@"Cross the road and ride 12L to next point.",@"Cross the road and walk to next point to reach Carbon Market",@"", nil];
    routeFares = [NSArray arrayWithObjects:@"Fare: P12.00",@"Fare: P8.00",@"Fare: P8.00",@"", nil];
    routeIcons = [NSArray arrayWithObjects: [UIImage imageNamed:@"ic_start.png"], [UIImage imageNamed:@"ic_node.png"], [UIImage imageNamed:@"ic_node.png"], [UIImage imageNamed:@"ic_end.png"],nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDatasource 

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [routePlaces count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tripStopsIdentifier = @"RouteInfoTableCell";
    RouteInfoTableCell *cell = (RouteInfoTableCell*)[tableView dequeueReusableCellWithIdentifier:tripStopsIdentifier];
    if(cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RouteInfoTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        UIView *v = [[UIView alloc] init];
    	v.backgroundColor = [UIColor colorWithRed:0.11 green:0.643 blue:0.545 alpha:1]; /*#1ca48b*/
        cell.selectedBackgroundView = v;
    }
    cell.lbPlace.text = [routePlaces objectAtIndex:indexPath.row];
    cell.lbPlace.lineBreakMode = NSLineBreakByWordWrapping;
    cell.lbPlace.numberOfLines = 2;
    [cell.lbPlace sizeToFit];
    cell.lbInstruction.text = [routeInstructions objectAtIndex:indexPath.row];
    cell.lbInstruction.lineBreakMode = NSLineBreakByWordWrapping;
    cell.lbInstruction.numberOfLines = 2;
    [cell.lbInstruction sizeToFit];
    cell.lbFare.text = [routeFares objectAtIndex:indexPath.row];
    cell.imgThumbnail.image = [routeIcons objectAtIndex:indexPath.row];
    return cell;
}

-(UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *viewFooter = [[UIView alloc] initWithFrame:CGRectMake(0 ,0 , 0, 0)];
    return viewFooter;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}

@end
