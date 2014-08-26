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

/**
 *  Setting up a score. It adds a set to a dictionary with sets
 *
 *  @param score1 <#score1 description#>
 *  @param score2 <#score2 description#>
 *  @param team1  <#team1 description#>
 *  @param team2  <#team2 description#>
 *  @param final  <#final description#>
 */
-(void)setScore:(NSNumber *)score1 andScore:(NSNumber *)score2 betweenTeam:(id)team1 andTeam2:(id)team2 final:(BOOL)final;

-(void)deleteScoreAtIndex:(NSUInteger)index;
-(id)getWinner;

-(NSUInteger )getPointsForTeam:(id)team won:(BOOL)won;
-(NSUInteger )getSetsForTeam:(id)team won:(BOOL)won;

@end
