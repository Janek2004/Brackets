//
//  TournamentUtilities.h
//  BracketsCommandLineOS
//
//  Created by sadmin on 7/7/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TournamentUtilities : NSObject
-(NSArray *) sortArray:(NSMutableArray *) array andStart: (NSUInteger) start end: (NSUInteger) end;
-(id)getTeamsInOrder:(id)teams;

@end
