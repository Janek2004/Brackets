//
//  Game.h
//  BracketsCommandLineOS
//
//  Created by sadmin on 6/22/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Game : NSObject

@property (nonatomic,strong) id team1;
@property (nonatomic,strong) id team2;
@property (nonatomic,strong) id left;
@property (nonatomic,strong) id right;
@property (nonatomic,strong) id parent;
@property (nonatomic,strong) NSNumber * gameId;
@property (nonatomic,strong) NSNumber * number;
@property (nonatomic,strong) NSDate * date;
@property(nonatomic,assign)  NSUInteger displayIndex;
@property (nonatomic, assign) BOOL finished;// if it has score is finished if it's not it's not.
@property(nonatomic, strong)id score;

@property(nonatomic,strong)NSString * defaultTeam1Text;
@property(nonatomic,strong)NSString * defaultTeam2Text;

@property BOOL visited;

-(NSArray *)getChildrenNodes;


@end
