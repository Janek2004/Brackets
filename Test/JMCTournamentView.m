//
//  JMCTournamentView.m
//  Test
//
//  Created by sadmin on 8/6/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//

#import "JMCTournamentView.h"
#import "JMCGameView.h"
#import "TournamentProtocol.h"
#import "Game.h"


#define GAME_WIDTH 200
#define MIN_GAME_HEIGHT 120
#define MIN_GAME_SPACE 25
#define MARGIN 25

@interface JMCTournamentView()
@property(nonatomic,strong)id <TournamentProtocol> tournament;

@end

@implementation JMCTournamentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


/**
 *  Initializer
 *
 *  @param tournament tournament that will be used to determine dimensions of the view
 *
 *  @return instance of the tournament view
 */

-(id)initWithTournament:(id<TournamentProtocol>) tournament{
    CGRect frame;
   
    NSUInteger game_width = GAME_WIDTH;
    NSUInteger min_game_height = MIN_GAME_HEIGHT;
    NSUInteger min_game_space = MIN_GAME_SPACE;
    NSUInteger margin = MARGIN;
    self.tournament = tournament;

    
    
    
    //calculate frame based on number of levels
    NSUInteger width = [tournament numberOfLevels]* game_width;
    //tournament
    NSUInteger gamesNr =[tournament maxNumberOfVerticalGames];
    NSUInteger height = (gamesNr -1 ) * min_game_space + gamesNr * min_game_height + 2 * margin;
    
    frame = CGRectMake(0, 0, width, height);
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //add games
        
    }
    return self;
}

/**
 *  Traverse a tree to to prepare information necassary for drawing the game views
 *
 *  @param root root of the tree
 */
-(void)addGames:(Game *)root{
    //?games for level?
    //that would be probably the easiest. Otherwise I could try to have breadth first traversal
    //I could have a method that returns
    //with a depth traversal I would have to start from the root which will be kind of akward
    //pehaps tournament should have a method for adding views??
    NSUInteger currentNodes=0;
    NSUInteger nextLevelNodes=0;
    NSUInteger currentLevel = 1;
    
    NSMutableArray * nodes= [NSMutableArray new];
    [nodes addObject:root]; //enqueue
    currentNodes++;
    
    while (nodes.count>0) {
        //dequee
        Game * g = [nodes lastObject];
        [nodes removeLastObject];
        currentNodes--;
        //draw game at certain level
        
        
        NSArray * children = [g getChildrenNodes];
        for(Game * g1 in children){
            [nodes addObject:g1];
        }
        
        if(currentNodes==0){
            currentNodes = nextLevelNodes;
            currentLevel++;
        }
    }
}

/**
 *  Draws game depending on level, index
 *
 *  @param level     level (1 is last)
 *  @param index     vertical index
 *  @param gameLevel all games
 */
-(void)drawGameAtLevel:(NSUInteger)level index:(NSUInteger)index totalNumberOfLevelGames:(NSUInteger)gameLevel{
    //if first level put game in the center
    //if second
    
    //we can start from 60
    //
    
    if(level == [_tournament numberOfLevels]){
        //index
      //  NSUInteger y = MARGIN + index * MIN_GAME_HEIGHT;
        
    }
    
    //last level games are on margin and than margin + game_height + space between
    //next level games are on (game at index) height/2.0 and so on
    //how can find how they relate to eachother? recursively?

    /*
    -
        -
    -
            -
    -
        -
    -
    
     calculate height span between first and last game in level one
     
     */
    
    NSUInteger max_game_span = CGRectGetHeight(self.frame)- 2 * (MARGIN + MIN_GAME_HEIGHT/2.0);
    
    //difference between levels / 1.5?
    //level down
    //first game will be from:
    //MARGIN + MIN_GAME_HEIGHT/2.0
    //MARGIN + MIN_GAME_HEIGHT/2.0 + second game_y+MIN_GAME_HEIGHT/2.0

    //second level first game will be previous first_game_y + first_game_width/2.0
}

-(void)checkGameY{
    NSUInteger level = 1;
    NSUInteger game_number = 2;
    
    NSUInteger game_height = 100;
    NSUInteger margin = 0;
    NSUInteger space = 25;
    NSUInteger gameY1= 0;
    NSUInteger gameY2= 0;
    
    for (int i =0; i<level; i++) {
        if(i==0){
            gameY1 = margin;
            game_height = 100;
            gameY2 = margin + game_height + space;
        
        }
        else{
            gameY1 = margin +game_height/2.0;
            gameY2 = gameY2 +game_height/2.0;
            margin = gameY1;
            space = space + game_height;
            game_height = gameY2 - gameY1;
        }
    }
    //so we have y and space so we can calculate easily where should we draw the games
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
