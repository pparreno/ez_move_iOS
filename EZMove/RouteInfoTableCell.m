//
//  RouteInfoTableCell.m
//  EZMove
//
//  Created by Charles Anthony Yu on 8/21/13.
//  Copyright (c) 2013 Charles Anthony Yu. All rights reserved.
//

#import "RouteInfoTableCell.h"

@implementation RouteInfoTableCell

@synthesize imgThumbnail = _imgThumbnail;
@synthesize lbPlace = _lbPlace;
@synthesize lbInstruction = _lbInstruction;
@synthesize lbFare = _lbFare;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
