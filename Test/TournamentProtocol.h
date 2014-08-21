//
//  TournamentProtocol.h
//  BracketsCommandLineOS

#import <Foundation/Foundation.h>

@protocol TournamentProtocol <NSObject>
@property (readonly) NSUInteger numberOfTeams;
@property (readonly) NSUInteger numberOfGames;
@property (readonly) NSUInteger numberOfLevels;

-(id)getTeamsInOrder;
-(id)getTournamentSchedule;
-(void)buildBracketWithTeams:(NSArray *)teams;
-(void)setScore:(id)score game:(id)game;
-(void)setTournamentTeams:(id)teams;
-(id)searchForGame:(id)game;

@optional
/**
 *  Checks how many games are happenning on given level
 *
 *  @param level number of level
 *
 *  @return number of games in given level
 */
-(NSUInteger)getNumberOfGamesForLevel:(NSUInteger )level;

/**
 *  Calculate maximum number of games in first level. It's used to calculate size of the tournamanent view
 *
 *  @param numberOfTeams number of teams
 *
 *  @return number of games
 */
-(NSUInteger)maxNumberOfVerticalGames;


/**
 *  Returns first element of the tournament tree
 *
 *  @return root of the tree
 */
-(id)getTournamentRoot;




@end
