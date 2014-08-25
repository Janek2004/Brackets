//
//  Team.m
//  BracketsCommandLineOS
//
//  Created by sadmin on 6/21/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//

#import "Team.h"
#import "Stats.h"
#import "Score.h"

#import "Game.h"

@interface Team()
//stats
  

@end


@implementation Team

/**
 *  Default init method
 *
 *  @return instance of Team class
 */
-(instancetype)init{
    if(self = [super init]){
        _stats = [Stats new];
    }
    return self;
}
/**
 *  Resets stats
 */
-(void)resetStats;{
    [self.stats reset];
}
/**
 *  Updates current statistics of the team
 *
 *  @param score current score
 */
-(void)updateStatsWithScore:(id)score;{
 
    
    [self.stats  addGameResult:[score getPointsForTeam:self won:YES] negativePoints:[score getPointsForTeam:self won:NO] victory: [score getSetsForTeam:self won:YES] loss: [score getSetsForTeam:self won:NO]];

}
-(void)updateSeed:(NSNumber *)seed;{
    _gameSeed = seed;
}

//players
-(void)addPlayer:(id)player;{}
-(void)removePlayer:(id)player;{}
-(NSString *)description{
    NSMutableString * s = [NSMutableString new];
    if(self.gameSeed){
        [s appendString:[NSString stringWithFormat:@"Seed: %@",self.gameSeed]];
    }
    if(self.name){
        [s appendString:[NSString stringWithFormat:@"Name: %@",self.name]];
    }
    
//    if(self.loserteamId){
//        [s appendString:[NSString stringWithFormat:@"LoseId: %@",self.loserteamId]];
//    }
    
    return s;
    
}
@end
