//
//  DoubleElimination.m
//  BracketsCommandLineOS
//
//  Created by sadmin on 7/7/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//

#import "DoubleElimination.h"
#import "TournamentUtilities.h"

/**
 This variation of the tournament will have two nodes of tournament
  * winners - winners will have original number of teams let's say n
  * losers - will have half of the teams 
 
  How do we deal with buys
 
 Winners:
  a-
    1 a-
  b-     2-a
      c-
                Final: a -b
 
  Losers
   b-----
          3-b
        c-
 
 
 http://www.aropupu.fi/bracket/
 
 */

#import "Game.h"
#import "Team.h"

@interface DoubleElimination()

 @property (nonatomic,strong) Game*  secondFinalGame;
 @property (nonatomic,strong) NSMutableArray * teams;
@property (nonatomic,strong) TournamentUtilities * utilities;

@end

@implementation DoubleElimination

-(instancetype)init{
    self = [super init];
    if(self)
    {
        _utilities = [TournamentUtilities new];
    }
    return self;
}


/**
 *  Searches for gme
 *
 *  @param root root of the tree
 *
 *  @return game uyou are looking for
 */
-(Game*) searchForGame:(Game *) root{
    NSMutableArray * games =[NSMutableArray new];
    NSMutableArray * queue= [NSMutableArray new];
    
    [queue addObject:root];
    
    
    while(queue.count>0){
        Game * g= queue.lastObject;
        if([g.number isEqual:root.number]){
            return g;
            break;
        }
        
        [queue removeLastObject];
        //loop through all games at this level probably it can be called after the level is traversed
        
        if(g.team1!=NULL &&g.team2!=NULL){
            [games addObject:g];
        }
        
        NSArray *nodes =   g.getChildrenNodes;
        
        for(Game * child in nodes){
            [queue insertObject:child atIndex:0];
        }
        
    }
    return nil;
    
}

-(void)setScore:(id)score game:(id)game{
        
}



/**
 *  Returns number of games
 *
 *  @return number of games
 */
-(NSUInteger)numberOfGames{
    switch (self.numberOfTeams) {
        case 3:
            return 1;
            break;
            
        default:
            return 0;
            break;
    }
}


/**
 *  Setting up teams
 *
 *  @param teams teams
 */
-(void)setTournamentTeams:(id)teams{
    self.teams = teams;
}

-(void)buildBracketWithTeams:(NSArray *)teams{
    [self createDEBracket:teams.count];
}

-(Game *) createDEBracket:(NSUInteger) nrteams
{
    _secondFinalGame = [Game new];
    Game * finalGame = [Game new];
    Game * losers = [Game new];
    Game * winners = [Game new];
    
    switch (nrteams) {
        case 3:
        {
            _secondFinalGame.number = @5;
            finalGame.number = @4;
            losers.number= @3;
            winners.number =@2;
            
            Game *g = [Game new];
            g.number = @1;
            winners.right = g;
            g.parent = winners;
  
            losers.defaultTeam2Text = @"L4";
            losers.defaultTeam1Text =@"L1";
            losers.defaultTeam2Text =@"L2";

            
        }
            break;
            
        case 4:
        {
            _secondFinalGame.number = @7;
            finalGame.number = @6;
            losers.number= @5;
            winners.number =@3;
            
            Game *wg = [Game new];
            wg.number = @1;
            
            Game *wg1 = [Game new];
            wg1.number = @1;
            
            winners.right = wg;
            winners.left = wg1;
            
            losers.defaultTeam2Text = @"L6";
            losers.defaultTeam1Text = @"L3";
              
            Game * lg = [Game new];
            lg.number = @4;
            lg.defaultTeam1Text  = @"L1";
            lg.defaultTeam2Text  = @"L2";
        }
            break;
        default:
            break;
    }
    
    _secondFinalGame.left = finalGame;
    finalGame.parent = _secondFinalGame;
    finalGame.left = winners;
    finalGame.right =losers;
    
    winners.parent = finalGame;
    losers.parent = finalGame;
    
    
    return _secondFinalGame;
    
}
-(id)getTournamentSchedule;{
    return [self getTournamentSchedule:_secondFinalGame];
}

-(id)getTournamentSchedule:(Game *) root{
    NSMutableArray * games =[NSMutableArray new];
    NSMutableArray * queue= [NSMutableArray new];
    
    [queue addObject:root];
    
    
    while(queue.count>0){
        Game * g= queue.lastObject;
        [queue removeLastObject];
        //loop through all games at this level probably it can be called after the level is traversed
        
        if(g.team1!=NULL &&g.team2!=NULL){
            [games addObject:g];
        }
        
        NSArray *nodes =   g.getChildrenNodes;
        
        for(Game * child in nodes){
            [queue insertObject:child atIndex:0];
        }
        
    }
     [games sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"number" ascending:YES]]];
    
    return games;
}

-(id)getTeamsInOrder;{
    
    return  [self.utilities getTeamsInOrder:self.teams];
}


@end
