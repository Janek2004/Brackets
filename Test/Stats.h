//
//  Stats.h
//  BracketsCommandLineOS
//
//  Created by sadmin on 7/2/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stats : NSObject

@property (nonatomic, assign) NSUInteger  numberOfVictories;
@property (nonatomic, assign) NSUInteger  numberOfLosses;
@property (nonatomic, assign) NSUInteger  numberOfPointsWon;
@property (nonatomic, assign) NSUInteger  numberOfPointsLost;
@property (nonatomic, assign) NSInteger  numberOfPointsDifference;
@property (nonatomic, assign) NSInteger  numberOfGames;

-(void)addGameResult:(NSUInteger)points  negativePoints:(NSUInteger)points2 victory:(NSUInteger)victories loss:(NSUInteger)loss;

- (id)getStatsForTournament:(id)tournament;
- (id)getLifetimeStatsForTeam:(id)team;
- (void)reset;


@end
