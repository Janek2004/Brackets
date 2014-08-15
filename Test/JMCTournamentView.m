//
//  JMCTournamentView.m
//  Test
//
//  Created by sadmin on 8/6/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//

#import "JMCTournamentView.h"
#import "JMCGameView.h"

#import "Game.h"


#define GAME_WIDTH 200
#define MIN_GAME_HEIGHT 120
#define MIN_GAME_SPACE 25
#define MARGIN 25

@interface JMCTournamentView()
{
    NSUInteger numberOfLevels;
}
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

    numberOfLevels = [tournament numberOfLevels];
    
    //calculate frame based on number of levels
    NSUInteger width = numberOfLevels * game_width;

    //tournament
    NSUInteger gamesNr =[tournament maxNumberOfVerticalGames];
    NSUInteger height = (gamesNr -1 ) * min_game_space + gamesNr * min_game_height + 2 * margin;
    
    frame = CGRectMake(0, 0, width, height);
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //add games
        [self addGames:[tournament getTournamentRoot]];
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
    NSUInteger currentIndex = 0;
    while (nodes.count>0) {
        //dequee
        Game * g = [nodes lastObject];
        [self drawGame:g atLevel:currentLevel index:currentIndex];
        currentIndex ++;
        
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
            currentIndex = 0;
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
-(void)drawGame:(Game*)game atLevel:(NSUInteger)level index:(NSUInteger)index{
    //if first level put game in the center
    //if second
    
    //we can start from 60
    //
    //reverse levels
    //if level =1 -> maxlevels level 2 => max Level -1
    //if level =3 -> maxlevels-2 level 4 => max Level -5
    
    //maxlevels -(level -1)
    //maxLevels - (level -1)
    
    NSUInteger levelToDraw = numberOfLevels -(level -1);
    
    NSUInteger game_number = index + 1;
    NSUInteger game_height = 100;
    NSUInteger margin = 10;
    NSUInteger space = 25;
    NSUInteger gameY1= 0;
    NSUInteger gameY2= 0;
    
    
    gameY1 = margin;
    
    gameY2 = margin + game_height + space;
    
    
    for (int i =1; i<levelToDraw; i++) {

            gameY1 = margin +game_height/2.0;
            gameY2 = gameY2 +game_height/2.0;
            margin = gameY1;
            space = space + game_height;
            game_height = gameY2 - gameY1;
     }
    
    gameY1 = margin + (game_number -1)* game_height + (game_number -1)*space;
    
    CGRect frame = CGRectMake(level * GAME_WIDTH, gameY1, GAME_WIDTH, game_height);
    
    JMCGameView * gm = [[JMCGameView alloc]initWithGame:game andFrame:frame];
    [self addSubview:gm];
    
}

-(void)checkGameY{
    NSUInteger level = 1;
    NSUInteger game_number = 2;
    NSUInteger game_height = 100;
    NSUInteger margin = 10;
    NSUInteger space = 25;
    NSUInteger gameY1= 0;
    NSUInteger gameY2= 0;
    
    
    gameY1 = margin;
   
    gameY2 = margin + game_height + space;

    
    for (int i =0; i<level; i++) {
        if(i==0){
            
        }
        else{
            gameY1 = margin +game_height/2.0;
            gameY2 = gameY2 +game_height/2.0;
            margin = gameY1;
            space = space + game_height;
            game_height = gameY2 - gameY1;
        }
    }
    
    gameY1 = margin + (game_number -1)* game_height + (game_number -1)*space;
    
    CGRectMake(level * GAME_WIDTH, gameY1, GAME_WIDTH, game_height);
    
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
