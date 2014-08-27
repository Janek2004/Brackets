//
//  ScoreEditTableViewCell.m
//  Brackets
//
//  Created by sadmin on 8/26/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//

#import "ScoreEditTableViewCell.h"

@implementation ScoreEditTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
