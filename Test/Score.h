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


-(void)setScore:(id)score1 andScore:(id)score2 betweenTeam:(id)team1 andTeam2:(id)team2 final:(BOOL)final;

-(void)deleteScoreAtIndex:(NSUInteger)index;
-(id)getWinner;

-(NSUInteger )getPointsForTeam:(id)team won:(BOOL)won;
-(NSUInteger )getSetsForTeam:(id)team won:(BOOL)won;

@end
