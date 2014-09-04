//
//  Score.h
//  BracketsCommandLineOS
//
//  Created by sadmin on 7/4/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Score : NSObject
@property(nonatomic,strong) NSMutableArray * sets;
@property(nonatomic,strong,readonly) id team1;
@property(nonatomic,strong,readonly) id team2;
@property(nonatomic, assign) BOOL finalScore;

/**
 *  Setting up a score. It adds a set to a dictionary with sets
 *
 *  @param score1 team 1 score
 *  @param score2 team 2 score
 *  @param team1  team 1
 *  @param team2  team 2
 *  @param final  is it a final score?
 */
-(void)setScore:(NSNumber *)score1 andScore:(NSNumber *)score2 betweenTeam:(id)team1 andTeam2:(id)team2 atSetIndex:(NSUInteger)index;
/**
 *  Deletes set
 *
 *  @param index index of set
 */
-(void)deleteScoreAtIndex:(NSUInteger)index;
/**
 *  Who won?
 *
 *  @return team that won
 */
-(id)getWinner;

/**
 *  Calculates number of points positive or negatives
 *
 *  @param team team
 *  @param won
 *
 *  @return positive or negative points
 */
-(NSUInteger )getPointsForTeam:(id)team won:(BOOL)won;
/**
 *  Calculates number of sets won or lost
 *
 *  @param team team
 *  @param won  sets won or lost
 *
 *  @return number of sets won or lost
 */
-(NSUInteger )getSetsForTeam:(id)team won:(BOOL)won;

/**
 *  Get number of sets in the match
 *
 *  @return get number of sets
 */

-(NSUInteger)getSetsCount;


/**
 *  Return number of points of the team in set
 *
 *  @param setIndex index of set
 *  @param team     team
 *
 *  @return number of points
 */
-(NSUInteger)getPointsForSet:(NSUInteger )setIndex andTeam:(id)team;





@end
