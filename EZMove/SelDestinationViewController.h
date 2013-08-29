//
//  SelDestinationViewController.h
//  EZMove
//
//  Created by Charles Anthony Yu on 8/29/13.
//  Copyright (c) 2013 Charles Anthony Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelDestinationViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate, UISearchBarDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tbvDestinations;
@property (nonatomic, strong) IBOutlet UISearchBar *sbSearchDes;


@end
