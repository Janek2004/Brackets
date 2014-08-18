
//  Tournament.m
//  BracketsCommandLineOS

//  Created by sadmin on 6/21/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
// http://stackoverflow.com/questions/22859730/generate-a-single-elimination-tournament

#import "Tournament.h"
#import "Game.h"
#import "Team.h"
#import "Score.h"
#import "TournamentProtocol.h"
#import "TournamentUtilities.h"
#import "SingleElimination.h"

@interface Tournament()
    @property (nonatomic,strong)NSMutableArray * teams;
    @property (nonatomic,strong)NSMutableArray * winningTeams;
    @property (nonatomic,strong)NSMutableArray * losingTeams;
    @property (nonatomic,strong)NSMutableArray * players;
    @property (nonatomic,strong)NSMutableArray * stages;

    @property (nonatomic,strong)  NSString *  tournamentId;
    @property (nonatomic, assign) NSUInteger * currentTournamentIndex;

   // @property (nonatomic,strong) id<TournamentProtocol> tournament;

@end


@implementation Tournament
/**
 *  Default init method
 *
 *  @return instance of the tournament class
 */
-(instancetype)init{
    if(self = [ super init]){
        _teams   = [NSMutableArray new];
        _players = [NSMutableArray new];
        _winningTeams = [NSMutableArray new];
        _losingTeams = [NSMutableArray new];
        _stages = [NSMutableArray new];
        _tournamentId = [[NSUUID UUID]UUIDString];
        
    }
    return self;
}

#pragma mark public methods
-(NSUInteger)getTotalNumberOfTeams;{
    return self.tournament.numberOfTeams;
}


-(NSUInteger)getNumberOfGames{
    return self.tournament.numberOfGames;
}

-(NSString *)getTournamentId;{
    return _tournamentId;
}

-(id)getTournamentSchedule;{
  return  [self.tournament getTournamentSchedule];
    
}

-(void)setFormat:(TournamentMode)mode;{
    self.tournamentMode = mode;
    switch (mode) {
        case kSingleElimination:
            
            self.tournament = [SingleElimination new];
            [(SingleElimination *) self.tournament setTournamentTeams: self.teams];
           // [self.tournament buildBracketWithTeams:self.teams];
            
            break;
        case kDoubleElimination:
            
            break;
        case kRoundRobin:
            
            break;
            
        default:
            break;
    }

}


#pragma mark
-(id)getStage;{
    
    return nil;
}
-(void)addStageWithMode:(TournamentMode)mode;
{
        
}
-(void)removeStage:(id) stage;
{
    
}


/** Tournament Mode */
-(void)setTournamentMode:(TournamentMode)tournamentMode{
    _tournamentMode = tournamentMode;
}


-(instancetype)initWithNumberOfTeams:(int)numberofteams{
    self = [self init];
 
    return self;
}





-(void)addTeam:(NSString *)teamName{
    Team * team = [Team new];
    team.name = teamName;

    [self.teams addObject:team];
    int i =1;
    for(id team in self.teams){
        [team setGameSeed:[NSNumber numberWithInt:i]];
        i++;
    }
    
    [self.tournament buildBracketWithTeams:self.teams];
    
}

-(void)removeTeam:(id)team{
    [self.teams removeObject:team];
    
    [self.teams enumerateObjectsUsingBlock:^(Team * team, NSUInteger idx, BOOL *stop) {
         [team setGameSeed:[NSNumber numberWithInteger:idx]];
    }];

    [self.tournament buildBracketWithTeams:self.teams];
}


/**
 Methods for setting score for the game
*/
-(void)setScore:(id)score game:(id)game{
    [self.tournament setScore:score game:game];
}


-(id)getStatsForTeam:(id)team{
    if([self.teams containsObject:team]){
        return [team stats];
    }
    
    return NULL;
}
-(id)getTournamentTree;{
   return  [(SingleElimination *) self.tournament getTournamentRoot];
}


#pragma mark utilities

-(id)searchForGame:(id)game;{
    return [self.tournament searchForGame:(id)game];
}



@end
