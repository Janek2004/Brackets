//
//  JMCViewController.m
//  Test
//
//  Created by sadmin on 8/3/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//

#import "JMCViewController.h"
#import "JMCGameView.h"


@interface JMCViewController ()

@end

@implementation JMCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    JMCGameView * gv = [[JMCGameView alloc]initWithFrame:CGRectMake(10, 10, 200, 120)];
    [self.view addSubview:gv];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
