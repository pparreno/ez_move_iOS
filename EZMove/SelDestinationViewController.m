//
//  SelDestinationViewController.m
//  EZMove
//
//  Created by Charles Anthony Yu on 8/29/13.
//  Copyright (c) 2013 Charles Anthony Yu. All rights reserved.
//

#import "SelDestinationViewController.h"

@interface SelDestinationViewController ()

@end

@implementation SelDestinationViewController{
    BOOL isSearching;
    NSMutableArray *filteredList;
    NSArray *list;
}
@synthesize tbvDestinations, sbSearchDes;

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
    // Initialize attributes
    isSearching = NO;
    filteredList = [[NSMutableArray alloc] init];
    list = [NSArray arrayWithObjects:@"EZ-MOVE", @"Current Trip", @"New Trip", @"Saved Trips", @"Routes", @"Settings", @"Help",nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)filterListForSearchText:(NSString *)searchText
{
    [filteredList removeAllObjects]; //clears the array from all the string objects it might contain from the previous searches
    
    for (NSString *title in list) {
        NSRange nameRange = [title rangeOfString:searchText options:NSCaseInsensitiveSearch];
        if (nameRange.location != NSNotFound) {
            [filteredList addObject:title];
        }
    }
}

#pragma mark - UISearchDisplayControllerDelegate

- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller {
    //When the user taps the search bar, this means that the controller will begin searching.
    isSearching = YES;
}

- (void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller {
    //When the user taps the Cancel Button, or anywhere aside from the view.
    isSearching = NO;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterListForSearchText:searchString]; // The method we made in step 7
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterListForSearchText:[self.searchDisplayController.searchBar text]]; // The method we made in step 7
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (isSearching) {
        //If the user is searching, use the list in our filteredList array.
        return [filteredList count];
    } else {
        return [list count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSString *title;
    if (isSearching && [filteredList count]) {
        //If the user is searching, use the list in our filteredList array.
        title = [filteredList objectAtIndex:indexPath.row];
    } else {
        title = [list objectAtIndex:indexPath.row];
    }
    
    cell.textLabel.text = title;
    
    return cell;
}


@end
