//
//  JMCTournamentView.h
//  Test
//
//  Created by sadmin on 8/6/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TournamentProtocol.h"

@interface JMCTournamentView : UIView
-(id)initWithTournament:(id<TournamentProtocol>) tournament;

@end
