//
//  Team.h
//  BracketsCommandLineOS
//
//  Created by sadmin on 6/21/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Team : NSObject

@property (nonatomic, strong) NSString * name;
//@property (nonatomic, strong) NSString * loserteamId;
@property (nonatomic, strong) NSNumber * gameSeed;


@property (nonatomic, assign) BOOL active;
@property (nonatomic,strong, readonly)id stats;

//historic stats

//players
-(void)addPlayer:(id)player;
-(void)removePlayer:(id)player;
-(void)updateStatsWithScore:(id)score;
-(void)updateSeed:(NSNumber *)seed;


-(void)resetStats;



@end
