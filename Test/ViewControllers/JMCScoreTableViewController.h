//
//  JMCScoreTableViewController.h
//  Brackets
//
//  Created by Janusz Chudzynski on 8/26/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Score;
@interface JMCScoreTableViewController : UITableViewController
    @property (nonatomic,strong)Score * score;
@end
