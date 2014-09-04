//
//  JMCScoreTableViewController.m
//  Brackets
//
//  Created by Janusz Chudzynski on 8/26/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//

#import "JMCScoreTableViewController.h"
#import "Score.h"
#import "Tournament.h"
#import "Game.h"
#import "ScoreHeaderCelllTableViewCell.h"
#import "ScoreEditTableViewCell.h"
@interface JMCScoreTableViewController ()

@end

@implementation JMCScoreTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(BOOL)canEdit{

    
    return YES;
}


-(void)testScores{
    Tournament * t = [[Tournament alloc]init];
    
    [t addTeam:@"Janek / Taylor"];
    [t addTeam:@"Keith/Megan "];
    [t addTeam:@"Charlie/Chelsea"];
    [t addTeam:@"Eric/Meghan"];
    [t addTeam:@"Jack/Michelle"];
  /*
    [t addTeam:@"Ian/Patchi"];
    [t addTeam:@"Mallory/Zack"];
    [t addTeam:@"Ian/Patchi"];
   */
    
    [t setFormat:kSingleElimination];
    
        
    Game * g1 = [Game new];
    g1.number =@1;
    
    Game * g2 = [Game new];
    g2.number =@2;
    
    Game * g3 = [Game new];
    g3.number =@3;
    
    Game * game = [t searchForGame: g1];
    
    Score * s = [Score new];
    
    [s setScore:@21 andScore:@13 betweenTeam:game.team1 andTeam2:game.team2 atSetIndex:0];
    [s setScore:@15 andScore:@21 betweenTeam:game.team1 andTeam2:game.team2 atSetIndex:1];
    s.finalScore = YES;
    
    [self setScore:s];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self testScores];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setScore:(Score *)score{
    _score = score;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    NSUInteger numberOfSets = [self.score getSetsCount];
    if(numberOfSets == 0){
        //add a new set
        [_score setScore:@0 andScore:@0 betweenTeam:self.score.team1 andTeam2:self.score.team2 atSetIndex:0];
        numberOfSets =1;
    }

    NSUInteger numberOfExtraFields = 0; //final score
    if(self.canEdit){
        numberOfExtraFields = 1;
    }
    
    NSUInteger count = 1 + numberOfSets + numberOfExtraFields;
    
    
    return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if(indexPath.row == 0){
        ScoreHeaderCelllTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"scoreHeader"];
        cell.team1Label.text = [self.score.team1 name];
        cell.team2Label.text = [self.score.team2 name];
        
        
        return cell;
    }
    else {
        if(self.canEdit){
            if(indexPath.row == [self tableView:tableView numberOfRowsInSection:indexPath.section]-1)
            {   //display final game cell
              
                
                
                return [tableView dequeueReusableCellWithIdentifier:@"finalScore"];
            }
            
            ScoreEditTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"editScore"];
            
            cell.score1TextField.text = [NSString stringWithFormat:@"%d",[self.score getPointsForSet:indexPath.row-1 andTeam:self.score.team1]];
             cell.score2TextField.text = [NSString stringWithFormat:@"%d",[self.score getPointsForSet:indexPath.row-1 andTeam:self.score.team2]];
            
            cell.setIndexLabel.text= [NSString stringWithFormat:@"%d",indexPath.row];
            
            [cell.addSetButton addTarget:self action:@selector(addSet:) forControlEvents:UIControlEventTouchUpInside];
            
            return cell;
        }
        else{
            return [tableView dequeueReusableCellWithIdentifier:@"score"];
        }
    }
    
    return nil;
}


-(NSIndexPath*)GetIndexPathFromSender:(id)sender{
    if(!sender) { return nil; }
    
    if([sender isKindOfClass:[UITableViewCell class]])
    {
        UITableViewCell *cell = sender;
        return [self.tableView indexPathForCell:cell];
    }
    
    return [self GetIndexPathFromSender:((UIView*)[sender superview])];
}



- (IBAction)addSet:(id)sender {
    NSIndexPath * indexPath = [self GetIndexPathFromSender:sender];
    //self.score

}




/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
