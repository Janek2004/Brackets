//
//  Score.m
//  BracketsCommandLineOS
//
//  Created by sadmin on 7/4/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//

#import "Score.h"

#define SCORE1_KEY  @"score1"
#define SCORE2_KEY  @"score2"
#define TEAM1_KEY   @"team1"
#define TEAM2_KEY   @"team2"
#define FINAL_KEY   @"final"

@interface Score()

@end


@implementation Score
-(instancetype)init{
    self = [super init];
    if(self)
    {
        _sets = [NSMutableArray new];
    }
    return self;
}
/**
 *  Deletes set
 *
 *  @param index index of set
 */
-(void)deleteScoreAtIndex:(NSUInteger)index;{
    [_sets removeObjectAtIndex:index];
}

/**
 *  Setting up a score. It adds a set to a dictionary with sets
 *
 *  @param score1 team 1 score
 *  @param score2 team 2 score
 *  @param team1  team 1
 *  @param team2  team 2
 *  @param final  is it a final score?
 */
-(void)setScore:(NSNumber *)score1 andScore:(NSNumber *)score2 betweenTeam:(id)team1 andTeam2:(id)team2 final:(BOOL)final;{
    
     NSMutableDictionary * dict = [NSMutableDictionary new];
     [dict setObject:score1 forKey:SCORE1_KEY];
     [dict setObject:score2 forKey:SCORE2_KEY];
    
     [dict setObject:team1 forKey:TEAM1_KEY];
     [dict setObject:team2 forKey:TEAM2_KEY];
     [dict setObject:@(final) forKey:FINAL_KEY];
    
    
     if(!self.team1) _team1 = team1;
     if(!self.team2) _team2 = team2;
     assert(self.team1== team1);
     assert(self.team2== team2);
    
    [_sets addObject:dict];
}



/**
 *  Who won?
 *
 *  @return team that won
 */
-(id)getWinner;{
    id winner;
    NSUInteger team1=0;
    NSUInteger team2=0;
    for (NSDictionary * dict in self.sets){
        if([[dict objectForKey:SCORE1_KEY]integerValue] > [[dict objectForKey:SCORE2_KEY]integerValue])
        {
            team1++;
        }
        else{
            team2++;
        }
    }
    if(team1==team2) return nil; // no winner
    winner = (team1 > team2)?self.team1:self.team2; 
    return winner;
}


/**
 *  Return number of points of the team in set
 *
 *  @param setIndex index of set
 *  @param team     team
 *
 *  @return number of points
 */
-(NSUInteger)getPointsForSet:(NSUInteger )setIndex andTeam:(id)team{
    assert(setIndex > self.sets.count-1);
    NSDictionary * dict = self.sets[setIndex];
    assert([[dict objectForKey:TEAM1_KEY]isEqual:team]||[[dict objectForKey:TEAM2_KEY]isEqual:team]);
   
    if([[dict objectForKey:TEAM1_KEY]isEqual:team]){
        return [[dict objectForKey:SCORE1_KEY]integerValue];

    }
    if([[dict objectForKey:TEAM2_KEY]isEqual:team]){
        return [[dict objectForKey:SCORE2_KEY]integerValue];
    }
    
    return 0;
}



/**
 *  Calculates number of points positive or negatives
 *
 *  @param team team
 *  @param won
 *
 *  @return positive or negative points
 */
-(NSUInteger )getPointsForTeam:(id)team won:(BOOL)won{
    NSUInteger  pointsWon =0;
    NSUInteger  pointsLost =0;
    
    
    for (NSDictionary * dict in self.sets){
        if([[dict objectForKey:TEAM1_KEY]isEqual:team]){
            pointsWon+=[[dict objectForKey:SCORE1_KEY]integerValue];
        }
        else{
           pointsLost+=[[dict objectForKey:SCORE1_KEY]integerValue];
        }
       
        if([[dict objectForKey:TEAM2_KEY]isEqual:team]){
            pointsWon+=[[dict objectForKey:SCORE2_KEY]integerValue];
        }
        else{
            pointsLost+=[[dict objectForKey:SCORE2_KEY]integerValue];
        }
    }
    
    if(won){
        return pointsWon;
    }
    else{
        return pointsLost;
    }
}

/**
 *  Calculates number of sets won or lost
 *
 *  @param team team
 *  @param won  sets won or lost
 *
 *  @return number of sets won or lost
 */
-(NSUInteger )getSetsForTeam:(id)team won:(BOOL)won{
    NSUInteger setsWon = 0;
    NSUInteger setsLost = 0;
    
    for (NSDictionary * dict in self.sets){
        //only finished games
        if([[dict objectForKey:FINAL_KEY]isEqual:@1]){
            //check for team
            if([[dict objectForKey:TEAM1_KEY]isEqual:team]){
                if([[dict objectForKey:SCORE1_KEY]integerValue] > [[dict objectForKey:SCORE2_KEY]integerValue]){
                    if(won){
                        setsWon ++;
                    }
                }

                if([[dict objectForKey:SCORE1_KEY]integerValue] < [[dict objectForKey:SCORE2_KEY]integerValue]){
                    if(!won){
                        setsLost ++;
                    }
                }
            }
 
            if([[dict objectForKey:TEAM2_KEY]isEqual:team]){
                if([[dict objectForKey:SCORE1_KEY]integerValue] > [[dict objectForKey:SCORE2_KEY]integerValue]){
                    if(!won){
                        setsLost++;
                    }
                }
                
                if([[dict objectForKey:SCORE1_KEY]integerValue] < [[dict objectForKey:SCORE2_KEY]integerValue]){
                    if(won){
                        setsWon ++;
                    }
                }
            }
        }
    }
    if(won) return setsWon;
    
    return setsLost;
}

/**
 *  Get number of sets in the match
 *
 *  @return get number of sets
 */
-(NSUInteger)getSetsCount;{
    return self.sets.count;
}



@end
