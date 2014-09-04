//
//  JMCTournamentView.h
//  Test
//
//  Created by sadmin on 8/6/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TournamentProtocol.h"

@protocol TournamentView <NSObject>
-(void)gameInfo:(id)game;


@end

@interface JMCTournamentView : UIView
@property(nonatomic,assign) id<TournamentView> delegate;

-(id)initWithTournament:(id<TournamentProtocol>) tournament;
-(CGFloat)calculateHeight:(NSUInteger)nrVerticalGames;
-(CGRect)calculateGameFrameAtLevel:(NSUInteger)level index:(NSUInteger)index;

@end
