//
//  Stats.m
//  BracketsCommandLineOS
//
//  Created by sadmin on 7/2/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//

#import "Stats.h"
@interface Stats()
@property(nonatomic,strong) NSMutableDictionary * history;
@end

@implementation Stats

-(instancetype)initWithTournamentId:(id)tournament{
    self = [super init];
    if(self)
    {
        
    }
    return self;
}

-(void)reset;{
    self.numberOfVictories = 0;
    self.numberOfLosses = 0;
    self.numberOfPointsLost=0;
    self.numberOfPointsWon =0;
    self.numberOfPointsDifference=0;
}

-(id)getStatsForTournament:(id)tournament;{
    return nil;
}

-(id)getLifetimeStatsForTeam:(id)team;{
    return nil;
}


-(void)addGameResult:(NSUInteger)points  negativePoints:(NSUInteger)points2 victory:(NSUInteger)victories loss:(NSUInteger)loss{
    
    
    self.numberOfPointsWon +=points;
    self.numberOfPointsLost+=points2;
    self.numberOfVictories +=victories;
    self.numberOfLosses +=loss;
    self.numberOfPointsDifference = self.numberOfPointsWon-self.numberOfPointsLost;
    self.numberOfGames = self.numberOfVictories + self.numberOfLosses;

}

-(void)addGameResult:(id)game score:(id)score tournament:(id)tournament;{
    //store games history somewhere
    
}


-(NSString *)description{
    return [NSString stringWithFormat:@"Victories: %lu \n Losses: %lu \n Points Won \n %lu Points Lost %lu \n Difference %ld",(unsigned long)self.numberOfVictories, (unsigned long)self.numberOfLosses, (unsigned long)self.numberOfPointsWon, (unsigned long)self.numberOfPointsLost,(long)self.numberOfPointsDifference];
}


- (NSComparisonResult)compare:(Stats *)other
{
    
    if(self.numberOfGames==0 && other.numberOfGames>0 ){
        return NSOrderedAscending;
    }
    if(self.numberOfGames>0 && other.numberOfGames==0){
        return NSOrderedDescending;
    }
    
    if(self.numberOfVictories == other.numberOfVictories && self.numberOfPointsDifference==other.numberOfPointsDifference){
        return NSOrderedSame;
    }
    if(self.numberOfVictories == other.numberOfVictories && self.numberOfPointsDifference>other.numberOfPointsDifference){
        return NSOrderedDescending;
    }
    
    if(self.numberOfVictories == other.numberOfVictories && self.numberOfPointsDifference<other.numberOfPointsDifference){
        return NSOrderedAscending;
    }
    
    if(self.numberOfVictories > other.numberOfVictories)
    {
        return NSOrderedDescending;
    }
    
    if(self.numberOfVictories < other.numberOfVictories)
    {
        return NSOrderedAscending;
    }
    
    
    
    return NSOrderedSame;
}





@end
