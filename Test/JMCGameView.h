//
//  JMCGameView.h
//  Test
//
//  Created by sadmin on 8/3/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol GameEvents
-(void)showTeamInfo:(id)sender;
-(void)showGameInfo:(id)sender;

@end

@interface JMCGameView : UIView
@property (nonatomic,weak) id<GameEvents> delegate;
-(id)initWithGame:(id)game andFrame:(CGRect)frame;

@end
