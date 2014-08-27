//
//  ScoreEditTableViewCell.h
//  Brackets
//
//  Created by sadmin on 8/26/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScoreEditTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UITextField *score1TextField;
@property (strong, nonatomic) IBOutlet UITextField *score2TextField;
@property (strong, nonatomic) IBOutlet UILabel *setIndexLabel;

@property (copy) void (^addSet)(NSIndexPath *row);
@property (strong, nonatomic) IBOutlet UIButton *addSetButton;

@end
