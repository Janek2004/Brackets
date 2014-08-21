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


#define GAME_WIDTH 160
#define MIN_GAME_HEIGHT 120
#define MIN_GAME_SPACE 25
#define MARGIN 0

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
     self.tournament = tournament;
    numberOfLevels = [tournament numberOfLevels];
    
    //calculate frame based on number of levels
    NSUInteger width = numberOfLevels * game_width;

    //tournament
     NSUInteger gamesNr =[self.tournament maxNumberOfVerticalGames];
    
    
    frame = CGRectMake(0, 0, width, [self calculateHeight:gamesNr]);
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //add games
      NSMutableDictionary * md =  [self addGames:[tournament getTournamentRoot]];
    //    displayBracket1([tournament getTournamentRoot]);
        
        
        NSLog(@"%s %@ ",__PRETTY_FUNCTION__,md);
    }
    return self;
}

-(CGFloat)calculateHeight:(NSUInteger)nrVerticalGames{
  
    CGFloat height = (nrVerticalGames -1 ) * MIN_GAME_SPACE + nrVerticalGames * MIN_GAME_HEIGHT + 2 * MARGIN ;
    return height;
}

void displayBracket1(Game * root){
    NSMutableArray * games =[NSMutableArray new];
    NSMutableArray * queue= [NSMutableArray new];
    NSUInteger nodesInNextLevel = 0;
    NSUInteger nodesInCurrentLevel = 1;
    
    NSUInteger currentLevel = 0;
    [queue addObject:root];
    
    NSMutableDictionary * md = [NSMutableDictionary new];
    while(queue.count>0){
        Game * g= queue.lastObject;
        NSLog(@"Game %@ ",g);
        
        NSMutableArray * ma = [md objectForKey:@(currentLevel)];
        if(!ma){ma = [NSMutableArray new];}
        [ma addObject:g];
        [md setObject:ma forKey:@(currentLevel)];
        
        
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
            currentLevel++;
            
        }
    }
    
    NSLog(@"VC %s %@",__PRETTY_FUNCTION__, md);
    
    
}



/**
 *  Traverse a tree to to prepare information necassary for drawing the game views
 *
 *  @param root root of the tree
 */
-(NSMutableDictionary *)addGames:(Game *)root{
    
    if(!root) return nil;
    
    NSUInteger currentNodes=0;
    NSUInteger nextLevelNodes=0;
    NSUInteger currentLevel = 0;
    NSMutableArray * nodes= [NSMutableArray new];
    
    NSMutableDictionary * md = [NSMutableDictionary new];
    
    [nodes addObject:root]; //enqueue
    currentNodes++;
 
    while (nodes.count>0) {
        //dequee
        Game * g = [nodes lastObject];
        //draw game at certain level
        [self drawGame:g atLevel:currentLevel index:g.displayIndex];
        NSMutableArray * ma = [md objectForKey:@(currentLevel)];
        if(!ma){ma = [NSMutableArray new];}
        [ma addObject:g];
        [md setObject:ma forKey:@(currentLevel)];
        
        [nodes removeLastObject];
        currentNodes--;

        for(Game * g1 in [g getChildrenNodes]){
            [nodes insertObject:g1 atIndex:0];
            nextLevelNodes++;
        }
        
        if(currentNodes==0){
            
            currentNodes = nextLevelNodes;
            nextLevelNodes =0;
            currentLevel++;
        }
    }
    return md;
    
}

/**
 *  Draws game depending on level, index
 *
 *  @param level     level first element 0 is a root next elements
 *  @param index     vertical index
 *  @param gameLevel all games
 */

-(CGRect)calculateGameFrameAtLevel:(NSUInteger)level index:(NSUInteger)index{
    //decreasing maximum number of levels to start from 0 not 1
    assert(numberOfLevels >= level);
    
    NSUInteger levelToDraw = numberOfLevels - level-1;
    
    NSUInteger game_number = index;
    CGFloat game_height = MIN_GAME_HEIGHT;
    CGFloat margin = MARGIN;
    CGFloat space = MIN_GAME_SPACE;

    CGFloat gameY1= 0;
    CGFloat gameY2= 0;
    
    gameY1 = margin;
    gameY2 = margin + game_height + space;
    
    
    
    
    //it calculates size and positioning depending on the function arguments, the challenge here is that we are reversing levels. It means that if we try to calculate position of the final game, we are passing level 0 but we need to display it at max nr levels times game_width
    CGFloat oldGameHeight = MIN_GAME_HEIGHT;
    
    
    for (int i =0; i<levelToDraw; i++) {
        
    //    gameY1 =  -13.5+ margin +game_height/2.0;
    //    gameY2 =  11.5+ gameY2 +game_height/2.0;
       
            gameY1 =  margin +oldGameHeight/2.0;
            gameY2 =  gameY2 +oldGameHeight/2.0;
            
            margin = gameY1;
            
            space = space + game_height;
            oldGameHeight = game_height;
            game_height = gameY2 - gameY1;
    
    }
    if(levelToDraw == numberOfLevels-1){
       // gameY1 =  margin +oldGameHeight/2.0;
        gameY2 =  gameY2 +game_height/2.0;
        
        margin = gameY1;
        
        space = space + game_height;
        oldGameHeight = game_height;
        game_height = gameY2 - gameY1;

    }
    gameY1 = margin + game_number* game_height + game_number*space;
    //adjust game

    CGRect frame = CGRectMake(levelToDraw * GAME_WIDTH, gameY1, GAME_WIDTH, game_height);
    return frame;
}

-(void)drawGame:(Game*)game atLevel:(NSUInteger)level index:(NSUInteger)index{
    CGRect frame =[self calculateGameFrameAtLevel:level index:index];
    
    JMCGameView * gm = [[JMCGameView alloc]initWithGame:game andFrame:frame];
    [self addSubview:gm];
    
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
