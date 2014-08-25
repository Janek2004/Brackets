//
//  SingleElimination.m
//  BracketsCommandLineOS
//
//  Created by sadmin on 7/7/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//
#import "Game.h"
#import "Team.h"
#import "SingleElimination.h"
#import "TournamentUtilities.h"
#import "Score.h"

@interface SingleElimination()

 @property (nonatomic,assign)  NSUInteger numberOfFirstRoundGames;
 @property (nonatomic,strong)  NSMutableArray * teams;
 @property (nonatomic,strong)  TournamentUtilities * utilities;
 @property (nonatomic,strong)  NSMutableDictionary * levelDictionary;
 @property (nonatomic,strong)  Game * root; // modified binary tree

@end

@implementation SingleElimination
/**
 *  Default initializer
 *
 *  @return instance of tournament
 */
-(instancetype)init{
    if(self = [super init]){
         self.utilities = [TournamentUtilities new];
         self.teams = [NSMutableArray new];
         self.levelDictionary = [@{} mutableCopy];
    }
    return self;
}

/**
 *  Set and replace array of tournament teams,
 *
 *  @param teams list of teams
 */
-(void)setTournamentTeams:(id)teams;{
    [self.teams removeAllObjects];
    [self.teams addObjectsFromArray:teams];
    
    [self buildBracketWithTeams:self.teams];
}


-(void)buildBracketWithTeams:(NSArray *)teams
{
    
     
    _numberOfGames = [self numberOfGamesForTeamsNumber:teams.count];
    _numberOfTeams = teams.count;
    
   [self createSEBracket:_numberOfTeams];
    
    
}


/**
 *  Returns first element of the tournament tree
 *
 *  @return root of the tree
 */
-(id)getTournamentRoot;
{
    return self.root;
}

/**
 *  Checks how many games are happenning on given level
 *
 *  @param level number of level
 *
 *  @return number of games in given level
 */
-(NSUInteger)getNumberOfGamesForLevel:(NSUInteger )level{
    if(self.levelDictionary.allKeys.count <level)return 0;

    return  [ [self.levelDictionary objectForKey:@(level) ]integerValue];;
}



/**
 *  Calculates the total number of games
 *
 *  @param teamsNumber number of teams
 *
 *  @return total number of games
 */
-(NSUInteger)numberOfGamesForTeamsNumber:(NSUInteger)teamsNumber{
    //calculate round 1
    NSUInteger closestPower =[self findClosestPower:teamsNumber];
    //NSLog(@"Closest Power %lu",(unsigned long)closestPower);
    NSUInteger gameCount = pow(2, closestPower);
    
    NSUInteger numberOfGamesInFirstRound = [self findNumberOfFirstRoundGames:gameCount andTeamsNumber:teamsNumber];
    
    NSUInteger num = gameCount/2;
    while (num/2>=1)
    {
        num = num/2;
        numberOfGamesInFirstRound+=num;
    }
    
    return numberOfGamesInFirstRound;
}


/**
 *  Calculates number of games in a first level of tournament. It's used to calculate size of the tournamanent view

 *
 *  @return maximum potential number of games
 */
-(NSUInteger)maxNumberOfVerticalGames{
    return [self maxNumberOfGamesForTeams:self.teams.count];
}

/**
 *  Calculate maximum number of games in first level. It's used to calculate size of the tournamanent view
 *
 *  @param numberOfTeams number of teams
 *
 *  @return number of games
 */

-(NSUInteger)maxNumberOfGamesForTeams:(NSUInteger)numberOfTeams{
    NSUInteger
    power = [self findClosestPower:numberOfTeams];
    return pow(2, power-1);
}

/**
 *  Closest power
 *
 *  @param teams number of teams
 *
 *  @return closest power of 2
 */
-(NSUInteger)findClosestPower:(NSUInteger)teams{
    NSUInteger k =1;
    NSUInteger power =0;
    while(k<teams){
        k = k*2;
        power++;
    }
    
    return power;
}


/**
 *  Implementation of property
 *
 *  @return number of levels in the tournament
 */
-(NSUInteger)numberOfLevels{
    
    NSUInteger numberOfLevels=0;
    if(!self.root)return 0;
    NSMutableArray * queue= [NSMutableArray new];
    [queue addObject:self.root];
    
    NSUInteger numberOfGamesCurrentLevel = 1;
    NSUInteger numberOfGamesNextLevel =0;
    while(queue.count>0){
        Game * g= queue.lastObject;
        [queue removeLastObject];
        numberOfGamesCurrentLevel--;
        
        NSArray *nodes =   g.getChildrenNodes;
        for(Game * child in nodes){
            //add to queue
            [queue insertObject:child atIndex:0];
            numberOfGamesNextLevel++;
        }
        if(numberOfGamesCurrentLevel==0){
            numberOfGamesCurrentLevel = numberOfGamesNextLevel;
            numberOfGamesNextLevel=0;
            numberOfLevels++;
        }
    }
    
  
   // [self  buildBracket];
    return numberOfLevels;
}




/**
 *  Calculate number of games in the first roun
 *
 *  @param gameCount   total number of games
 *  @param teamsNumber number of teams
 *
 *  @return number of games
 */
-(NSUInteger)findNumberOfFirstRoundGames:(NSUInteger)gameCount andTeamsNumber:(NSUInteger)teamsNumber{
    NSUInteger difference =gameCount - teamsNumber;
    NSUInteger k = gameCount/2.0 - difference;
    self.numberOfFirstRoundGames = k;
    
    return _numberOfFirstRoundGames;
}

/**
 *  Get Games in order
 *
 *  @return trournament chedule by games in order
 */
-(id)getTournamentSchedule;{
    NSMutableArray * games =[NSMutableArray new];
    if(!self.root)return nil;
    NSMutableArray * queue= [NSMutableArray new];

    
    [queue addObject:self.root];
    
    while(queue.count>0){
        Game * g= queue.lastObject;
        [queue removeLastObject];
        if(g.team1!=NULL &&g.team2!=NULL){
            [games addObject:g];
        }
        
        NSArray *nodes =   g.getChildrenNodes;
        for(Game * child in nodes){
            //add to queue
            [queue insertObject:child atIndex:0];
        }
    }
    
    
    [games sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"number" ascending:YES]]];
    
    
    return games;
}


-(Game *) createSEBracket:(NSUInteger) nrteams
{
    
    Game * finalGame;
    
    switch (nrteams) {
        case 3:
        {
            finalGame = [Game new];
            finalGame.number = @2;
            finalGame.displayIndex = 0;
            
            Game *g = [Game new];
            g.parent = finalGame;
            g.number = @1;
            g.team1 =self.teams[1];
            g.team2 =self.teams[2];
            g.displayIndex = 1;
            finalGame.right = g;
            finalGame.team1 = self.teams[0];
            
            
        } break;
        case 4:
        {
            finalGame = [Game new];
            finalGame.number = @3;
            Game *g = [Game new];
            g.parent = finalGame;
            g.number = @1;
            g.team1 =self.teams[0];
            g.team2 =self.teams[3];
            
            finalGame.left = g;
            
            Game *g1 = [Game new];
            g1.number = @2;
            
            g1.team1 = self.teams[1];
            g1.team2 = self.teams[2];
            g1.parent = finalGame;
            
            finalGame.right = g1;
            
        } break;
            
        case 5:
        {
            finalGame = [Game new];
            finalGame.number = @4;
            finalGame.displayIndex = 0;
            finalGame.defaultTeam1Text =@"W3";
            finalGame.defaultTeam2Text =@"W2";
           
            Game *g3 = [Game new];
            g3.parent = finalGame;
            g3.number = @3;
            g3.team1 =self.teams[0];
            g3.defaultTeam2Text = @"W1";
            g3.displayIndex = 0;
         
            finalGame.left = g3;
            
            Game *g2 = [Game new];
            g2.parent = finalGame;
            g2.number = @2;
            g2.team1 =self.teams[1];
            g2.team2 =self.teams[3];
            g2.displayIndex = 1;
            
            finalGame.right = g2;

            
            Game *g1 = [Game new];
            g1.number = @1;
            g1.displayIndex = 1;
            g1.team1 = self.teams[2];
            g1.team2 = self.teams[4];
           
            g1.parent = g3;
            g3.right = g1;
            

//            Game * g11 = [Game new];
//            g11.parent = g2;
//            g2.left = g11;
//            g11.number = @11;
//            g11.displayIndex = 1;
////
//            Game * g12 = [Game new];
//            g12.parent = g3;
//            g3.left = g12;
//            g12.number = @12;
//            g12.displayIndex = 2;
////
//            Game * g13 = [Game new];
//            g13.parent = g3;
//            g3.right = g13;
//            g13.number = @13;
//            g13.displayIndex = 0;

            
            
            
        } break;
            

        default: {return finalGame;}
            
    }
    _root = finalGame;
    
    return finalGame;
}

-(void)buildBracket;{
    if(self.numberOfGames==0){
        NSLog(@"Not enough Games");
        return;
    }
    
    if(!self.root) return;
    
    

}





-(void)updateStats{
    
    //for each game
    //check the score
    NSMutableDictionary * stats =[NSMutableDictionary new];
    if(!self.root)return;
    NSMutableArray * queue= [NSMutableArray new];
    
    [queue addObject:self.root];
    
    while(queue.count>0){
        Game * g= queue.lastObject;
        [queue removeLastObject];
        
        if(g.team1){
            //Resetting stats
            if(![stats objectForKey:[g.team1 gameSeed]]){
                [g.team1 resetStats];
                [stats setObject:g forKey:[g.team1 gameSeed]];
            }
            [g.team1 updateStatsWithScore:g.score];
            
        }
        
        if(g.team2) {
            if(![stats objectForKey:g.team2]){
                [g.team2 resetStats];
                [stats setObject:g forKey:[g.team2 gameSeed]];
            }
            [g.team2 updateStatsWithScore:g.score];
        }
        
        NSArray *nodes =   g.getChildrenNodes;
        for(Game * child in nodes){
            //add to queue
            [queue insertObject:child atIndex:0];
        }
    }
}

-(void)setScore:(id)score game:(id)game{
    Game * foundGame = [self searchForGame:game];
    foundGame.score = score;
    Team * winner = [score getWinner];
    
    if(winner){
        //get parent
        Game * parentGame = foundGame.parent;
        if(parentGame.left == foundGame){
            parentGame.team1 =winner;
        }
        if(parentGame.right == foundGame){
            parentGame.team2 =winner;
        }
    }
    
    //update team stats
    [self updateStats];
    [self.utilities getTeamsInOrder:self.teams];
}

-(id)searchForGame:(id)game;{
    return [self recursiveSearch:self.root search:game];
}

-(Game *)recursiveSearch:(Game *)game search:(Game *)element{
    if(game!=NULL){
        if([game.number isEqual:element.number]){
            return game;
        }
        
        Game * foundNode = [self recursiveSearch:game.left search:element];
        if(foundNode == NULL){
            foundNode = [self recursiveSearch:game.right search:element];
        }
        return foundNode;
    }
    else{
        return NULL;
    }
}

-(id)getTeamsInOrder;{
    
    return  [self.utilities getTeamsInOrder:self.teams];
}


@end
