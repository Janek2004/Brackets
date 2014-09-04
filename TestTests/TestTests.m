//
//  TestTests.m
//  TestTests
//
//  Created by sadmin on 8/3/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//


#import <XCTest/XCTest.h>
#import "SingleElimination.h"
#import "Tournament.h"
#import "Game.h"
#import "Stats.h"
#import "Score.h"
#import "Team.h"
#import "TournamentProtocol.h"
#import "JMCTournamentView.h"



//#import "To"

@interface TestTests : XCTestCase
    @property(nonatomic,strong) SingleElimination * singleElimination;
@end

@implementation TestTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _singleElimination = [[SingleElimination alloc]init];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testHeight{
    Tournament * t = [[Tournament alloc]init];
    
    [t addTeam:@"Janek / Taylor"];
    [t addTeam:@"Keith/Megan "];
    [t addTeam:@"Charlie/Chelsea"];
    [t addTeam:@"Eric/Meghan"];
//    [t addTeam:@"Jack/Michelle"];
//    [t addTeam:@"Ian/Patchi"];
//    [t addTeam:@"Mallory/Zack"];
//  [t addTeam:@"Ian/Patchi"];
// [t addTeam:@"Mallory/Zack"];
    [t setFormat:kSingleElimination];

    NSUInteger nrgames = [t.tournament maxNumberOfVerticalGames];
    //for 4 teams that should be 2
    assert(nrgames == 2);
    
    JMCTournamentView * tv = [[JMCTournamentView alloc]initWithTournament:t.tournament];
    assert([tv calculateHeight:nrgames]==315);
    
    t = [[Tournament alloc]init];
    
    [t addTeam:@"Janek / Taylor"];
    [t addTeam:@"Keith/Megan "];
    [t addTeam:@"Charlie/Chelsea"];
    [t addTeam:@"Eric/Meghan"];
    [t addTeam:@"Jack/Michelle"];
    [t addTeam:@"Ian/Patchi"];
    [t addTeam:@"Mallory/Zack"];
    //  [t addTeam:@"Ian/Patchi"];
    // [t addTeam:@"Mallory/Zack"];
    [t setFormat:kSingleElimination];
    
    nrgames = [t.tournament maxNumberOfVerticalGames];
    //for 4 teams that should be 2
    assert(nrgames == 4);
    
    tv = [[JMCTournamentView alloc]initWithTournament:t.tournament];
    assert([tv calculateHeight:nrgames]==605);
   
}

-(void)testPlacement{
    Tournament * t = [[Tournament alloc]init];
    
    [t addTeam:@"Janek / Taylor"];
    [t addTeam:@"Keith/Megan "];
    [t addTeam:@"Charlie/Chelsea"];
    [t addTeam:@"Eric/Meghan"];

    [t addTeam:@"Janek / Taylor"];
    [t addTeam:@"Keith/Megan "];
    [t addTeam:@"Charlie/Chelsea"];
    [t addTeam:@"Eric/Meghan"];

    
    
    [t setFormat:kSingleElimination];
    
    JMCTournamentView * tv = [[JMCTournamentView alloc]initWithTournament:t.tournament];
    CGRect frame = [tv calculateGameFrameAtLevel:3 index:3];
    
    
    NSLog(@"a ");
    
    
}



-(void)test8TeamSingleElimination{
    Tournament * t = [[Tournament alloc]init];
    
    [t addTeam:@"Janek / Taylor"];
    [t addTeam:@"Keith/Megan "];
    [t addTeam:@"Charlie/Chelsea"];
    [t addTeam:@"Eric/Meghan"];
    [t addTeam:@"Jack/Michelle"];
    [t addTeam:@"Ian/Patchi"];
    [t addTeam:@"Mallory/Zack"];
    [t addTeam:@"Ian/Patchi"];
    
    
    // [t addTeam:@"Mallory/Zack"];
    
    [t setFormat:kSingleElimination];

    displayBracket([t.tournament getTournamentRoot]);
}


-(void)testSingleElimination{
    Tournament * t = [[Tournament alloc]init];
    
    [t addTeam:@"Janek / Taylor"];
    [t addTeam:@"Keith/Megan "];
    [t addTeam:@"Charlie/Chelsea"];
    [t addTeam:@"Eric/Meghan"];
    [t addTeam:@"Jack/Michelle"];
    [t addTeam:@"Ian/Patchi"];
    [t addTeam:@"Mallory/Zack"];
    [t addTeam:@"Ian/Patchi"];
  
    
    // [t addTeam:@"Mallory/Zack"];
    
    [t setFormat:kSingleElimination];
    
   // assert([t getTotalNumberOfTeams] == 7 );
    NSUInteger maxVG = [t.tournament maxNumberOfVerticalGames];
    //assuming the number of teams is 7
    assert(maxVG == 4);
    
    
    
    Game * g1 = [Game new];
    g1.number =@1;
    
    Game * g2 = [Game new];
    g2.number =@2;
    
    Game * g3 = [Game new];
    g3.number =@3;
    
    Game * game = [t searchForGame: g1];
    Game * game2 = [t searchForGame: g2];
    Game * game3 = [t searchForGame: g3];
    
    NSLog(@"Game is: %@",game);
    
    Score * s = [Score new];
    
    [s setScore:@21 andScore:@13 betweenTeam:game.team1 andTeam2:game.team2 atSetIndex:0];
    [s setScore:@15 andScore:@21 betweenTeam:game.team1 andTeam2:game.team2 atSetIndex:1];;
    
    [t setScore:s game:game];
    
    // [game setScore:s];
    
    assert([s getPointsForTeam:game.team1 won:YES] == 36);
    assert([s getPointsForTeam:game.team1 won:NO] == 34);
    assert([s getSetsForTeam:game.team1 won:YES]==1);
    assert([s getSetsForTeam:game.team2 won:NO]==1);
    
    
    [s setScore:@21 andScore:@19 betweenTeam:game.team1 andTeam2:game.team2 atSetIndex:0];;
    [t setScore:s game:game];
    
    assert([s getSetsForTeam:game.team1 won:YES]==2);
    // [t updateStats];
    
    NSLog(@"Stats of the team %@ %@", [game.team1 name], [game.team1 stats]);
    NSLog(@"Stats of the team %@ %@", [game.team2 name], [game.team2 stats]);
    
    id winner = [s getWinner];
    NSLog(@"Winner is: %@ ",winner);
    
    //Testing Order
    assert([[game.team1 stats] compare:[game.team2 stats]]== NSOrderedDescending);
    assert([[game.team2 stats] compare:[game.team1 stats]]== NSOrderedAscending);
    assert([[game2.team2 stats] compare:[game.team2 stats]]== NSOrderedAscending);
    assert([[game2.team2 stats] compare:[game2.team1 stats]]== NSOrderedSame);
    
    Score * s1 = [Score new];
    
    [s1 setScore:@21 andScore:@11 betweenTeam:game2.team1 andTeam2:game2.team2 atSetIndex:0];;
    [s1 setScore:@21 andScore:@15 betweenTeam:game2.team1 andTeam2:game2.team2 atSetIndex:1];
    
    [t setScore:s1 game:game2];
    
    Score * s2 = [Score new];
    [s2 setScore:@21 andScore:@19 betweenTeam:game3.team1 andTeam2:game3.team2 atSetIndex:0];
    [s2 setScore:@21 andScore:@19 betweenTeam:game3.team1 andTeam2:game3.team2 atSetIndex:1];
    
    [t setScore:s2 game:game3];
    
    
    NSLog(@"Stats of the team %@ %@", [game2.team1 name], [game2.team1 stats]);
    //get teams
    //NSLog(@"Teams in order: %@ ",[t getTeamsInOrder]);
    
    NSLog(@"Get Schedule: %@", [t getTournamentSchedule]);

}

void displayBracket(Game * root){
    NSMutableArray * games =[NSMutableArray new];
    NSMutableArray * queue= [NSMutableArray new];
    NSUInteger nodesInNextLevel = 0;
    NSUInteger nodesInCurrentLevel = 0;
    
    
    [queue addObject:root];
    
    
    while(queue.count>0){
        Game * g= queue.lastObject;
        NSLog(@"Game %@ ",g);
        
        [queue removeLastObject];
        nodesInCurrentLevel--;
        
        //loop through all games at this level probably it can be called after the level is traversed
        
        if(g.team1!=NULL &&g.team2!=NULL){
            [games addObject:g];
        }
        
        NSArray *nodes =   g.getChildrenNodes;
        
        for(Game * child in nodes){
            [queue insertObject:child atIndex:0];
            nodesInNextLevel++;
        }
        
        if(nodesInCurrentLevel == 0){
            //here we know all the nodes on current level so we should determine what to do with the losers
            NSLog(@"_______");
            nodesInCurrentLevel = nodesInNextLevel;
            nodesInNextLevel = 0;
            
        }
    }
}


@end
