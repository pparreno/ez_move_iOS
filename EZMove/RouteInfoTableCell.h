//
//  RouteInfoTableCell.h
//  EZMove
//
//  Created by Charles Anthony Yu on 8/21/13.
//  Copyright (c) 2013 Charles Anthony Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RouteInfoTableCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView *imgThumbnail;
@property (nonatomic, strong) IBOutlet UILabel *lbPlace;
@property (nonatomic, strong) IBOutlet UILabel *lbInstruction;
@property (nonatomic, strong) IBOutlet UILabel *lbFare;

@end
