//
//  Game.m
//  BracketsCommandLineOS
//
//  Created by sadmin on 6/22/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//

#import "Game.h"

@implementation Game

-(void)setTeam1:(id)team1{
    self.defaultTeam1Text = nil;
    _team1 = team1;
}

-(void)setTeam2:(id)team2{
    self.defaultTeam2Text = nil;
    _team2 = team2;
}


-(NSArray *)getChildrenNodes;{
    NSMutableArray * array = [NSMutableArray new];
    if(self.right){
        [array addObject:self.right];
    }

    if(self.left){
        [array addObject:self.left];
    }
    
    return array;
}

-(NSString *)description{
    id l= [self.left number];
    id r=   [self.right number];
    
    return [NSString stringWithFormat:@" \n Game Id %@ \n Number: %@ \n Children:%@ %@ \n Team 1 %@ Team 2 %@",self.gameId, self.number, l, r,self.team1, self.team2];
}

@end
