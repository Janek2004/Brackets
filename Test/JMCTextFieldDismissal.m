//
//  JMCTextFieldDismissal.m
//  Brackets
//
//  Created by Janusz Chudzynski on 8/26/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//

#import "JMCTextFieldDismissal.h"

@interface JMCTextFieldDismissal()
{
    NSDate * lastEdit;
    NSTimer * timer;
}
@property(nonatomic,strong)UITextField * textField;

@end

@implementation JMCTextFieldDismissal

-(id)init{
    if(self=[super init]){
        lastEdit = [NSDate new];
        
    }
    return self;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //that will indicate that text field was edited
      lastEdit = [NSDate new];
    if(![timer isValid])
    {
        timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    }
    
    return YES;
}


-(void)timerTick:(NSTimer *)_timer{
    NSDate * date = [NSDate new];
    if([date timeIntervalSinceDate:lastEdit]>5){
        [_timer invalidate];
        [self.textField resignFirstResponder];
    }
}

-(void)dealloc{
    if(timer.isValid) [timer invalidate];
}


@end
