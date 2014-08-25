//
//  TournamentUtilities.m
//  BracketsCommandLineOS
//
//  Created by sadmin on 7/7/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//

#import "TournamentUtilities.h"

@implementation TournamentUtilities
-(NSArray *) sortArray:(NSMutableArray *) array andStart: (NSUInteger) start end: (NSUInteger) end{
    NSUInteger length = array.count;
    NSUInteger j = end -1;
    if(end == 0)
    {
        j=0;
    }
    for(NSUInteger i =start; i<length; i++)
    {
        if(i>=j){
            break;
        }
        id secondObject = array[i+1];
        
        //take last element
        id lastObject = array[j];
        array[j] = secondObject;
        array[i+1] = lastObject;
        
        //decrement j
        if(j>=2){
            j=j-2;
        }
        else{
            break;
        }
        i =i+1;
    }
    return array;
}


-(id)getTeamsInOrder:(id)teams{
    
    NSSortDescriptor * sort = [NSSortDescriptor sortDescriptorWithKey:@"stats" ascending:NO];
    [teams sortUsingDescriptors:@[sort]];
    
    return teams;
}



@end
