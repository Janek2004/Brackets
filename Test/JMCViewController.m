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


@interface JMCViewController ()

@end

@implementation JMCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  //  JMCGameView * gv = [[JMCGameView alloc]initWithFrame:CGRectMake(10, 10, 200, 120)];
  // [self.view addSubview:gv];
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
    [t addTeam:@"Ian/Patchi"];
    [t addTeam:@"Mallory/Zack"];
    //  [t addTeam:@"Ian/Patchi"];
    // [t addTeam:@"Mallory/Zack"];
    
    [t setFormat:kSingleElimination];
    
    JMCTournamentView * tv = [[JMCTournamentView alloc]initWithTournament:t.tournament];

    [self.view addSubview:tv];
    
    
    
}



@end
