//
//  Tournament.h
//  BracketsCommandLineOS
//
//  Created by sadmin on 6/21/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//
@import CoreLocation;
#import <Foundation/Foundation.h>
#import "TournamentProtocol.h"

typedef enum {
    kRoundRobin,
    kSingleElimination,
    kDoubleElimination,
    kRoundRobinAndTournament
}TournamentMode;


@interface Tournament : NSObject 

@property (nonatomic,strong) NSDate * date;
@property (nonatomic,strong) NSString * name;
@property (nonatomic, strong) CLLocation * location;
@property (nonatomic, readonly) TournamentMode tournamentMode;
@property (nonatomic,strong) id<TournamentProtocol> tournament;


//initializer
-(instancetype)initWithNumberOfTeams:(int)numberofteams;

//teams
-(void)addTeam:(NSString *)team;
-(void)removeTeam:(id)team;
-(id)searchForGame:(id)game;
-(void)setScore:(id)score game:(id)game;

//Public Methods
-(NSUInteger)getTotalNumberOfTeams;
-(NSUInteger)getNumberOfGames;
-(NSString *)getTournamentId;

//-(void)updateStats;
-(id)getStatsForTeam:(id)team;
-(id)getTournamentSchedule;

//stages
-(id)getStage;
-(void)addStageWithMode:(TournamentMode)mode;
-(void)removeStage:(id) stage;

-(void)setFormat:(TournamentMode)mode;

-(id)getTournamentTree;



@end
