//
//  JMCViewController.m
//  Test
//
//  Created by sadmin on 8/3/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//

#import "JMCViewController.h"
#import "JMCGameView.h"
#import "Tournament.h"
#import "JMCTournamentView.h"
#import "Game.h"

@interface JMCViewController ()
@property(nonatomic,strong) UIScrollView * scrollView;
@end

@implementation JMCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  //  JMCGameView * gv = [[JMCGameView alloc]initWithFrame:CGRectMake(10, 10, 200, 120)];
  // [self.view addSubview:gv];
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    [self.view addSubview:_scrollView];

    self.view.layer.borderWidth =1;
    
    
    [self addTournament];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)addTournament{
    Tournament * t = [[Tournament alloc]init];
    [t addTeam:@"Janek / Taylor"];
    [t addTeam:@"Keith/Megan "];
    [t addTeam:@"Charlie/Chelsea"];
    [t addTeam:@"Eric/Meghan"];
    [t addTeam:@"Jack/Michelle"];

// [t addTeam:@"Carmen/Michelle"];
/*
    [t addTeam:@"Eric/Meghan"];
 
   
    [t addTeam:@"Ian/Patchi"];
    [t addTeam:@"Mallory/Zack"];
    [t addTeam:@"Ian/Patchi"];
*/
    
    // [t addTeam:@"Mallory/Zack"];
    
    [t setFormat:kSingleElimination];
    
    JMCTournamentView * tv = [[JMCTournamentView alloc]initWithTournament:t.tournament];
    
    [_scrollView addSubview:tv];
    [_scrollView setContentSize:CGSizeMake(1000, 1000)];
    
    
    displayBracket([[t tournament]getTournamentRoot]);
    
    
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
