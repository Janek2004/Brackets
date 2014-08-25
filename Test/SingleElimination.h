//
//  SingleElimination.h
//  BracketsCommandLineOS
//
//  Created by sadmin on 7/7/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TournamentProtocol.h"
@class Game;

@interface SingleElimination : NSObject <TournamentProtocol>

@property (readonly) NSUInteger numberOfTeams;
@property (readonly) NSUInteger numberOfGames;
@property (readonly) NSUInteger numberOfLevels;



@end
