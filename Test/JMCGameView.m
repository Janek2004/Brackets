//
//  JMCGameView.m
//  Test
//
//  Created by sadmin on 8/3/14.
//  Copyright (c) 2014 Janusz Chudzynski. All rights reserved.
//

#import "JMCGameView.h"
#import "Game.h"


@interface JMCGameView()
    @property (nonatomic,strong) UIButton * team1Button;
    @property (nonatomic,strong) UIButton * team2Button;
    @property (nonatomic,strong) UIButton * gameButton;
    @property (nonatomic,strong) UIImage * teamInfoImage;
    @property (nonatomic,strong) UIImage * gameInfoImage;


@property (nonatomic,strong)  Game * game;

@end

@implementation JMCGameView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //self.backgroundColor = [UIColor clearColor];
        self.team1Button = [UIButton buttonWithType:UIButtonTypeInfoLight];
        self.team2Button = [UIButton buttonWithType:UIButtonTypeInfoLight];
        self.gameButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self.team1Button addTarget:self action:@selector(showTeamInfo:) forControlEvents:UIControlEventTouchUpInside];
        [self.team2Button addTarget:self action:@selector(showTeamInfo:) forControlEvents:UIControlEventTouchUpInside];
        [self.gameButton addTarget:self action:@selector(showGameInfo:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.team1Button];
        [self addSubview:self.team2Button];
        [self addSubview:self.gameButton];
        
        UIImage * img = [self drawCanvas4];
        
        [self.gameButton setImage:img forState:UIControlStateNormal];
        
        
    }
    return self;
}



-(void)showTeamInfo:(id)sender{
    [self.delegate showTeamInfo:sender];
}


-(void)showGameInfo:(id)sender{
   
    //get game
    [self.delegate showGameInfo:sender];
}



-(id)initWithGame:(id)game andFrame:(CGRect)frame{
    self = [self initWithFrame:frame];
    self.game = game;
    if (self) {
        
        
        // Initialization code
        
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [self drawCanvas1WithTeam1Name:[self.game.team1 name] team2Name:[self.game.team2 name] gameNumber:[NSString stringWithFormat:@"%@",self.game.number]     height:CGRectGetHeight(self.frame)-25 horizontal_topy:25 team2LabelHeight:16 team2BackgroundHeight:28 team_font_size:9 left_boundary:0];
    
    
    
  }

-(void)drawButtonsWithgameNumberExpression:(CGFloat)gameNumberExpression  bottomy:(CGFloat)team2BackgroundExpression topy:(CGFloat)team1BackgroundExpression{
    CGFloat buttonSize = 23;
    //buttons
    team2BackgroundExpression=team2BackgroundExpression + 2;
    team1BackgroundExpression=team1BackgroundExpression+2;
    gameNumberExpression=gameNumberExpression+2;
    
    self.team1Button.frame= CGRectMake(94.5,team1BackgroundExpression,buttonSize,buttonSize);
    self.team2Button.frame= CGRectMake(94.5,team2BackgroundExpression-25/2.0,buttonSize,buttonSize);
    self.gameButton.frame = CGRectMake(127.5, gameNumberExpression-25/2.0, buttonSize, buttonSize);
    
}


- (void)drawCanvas1WithTeam1Name: (NSString*)team1Name team2Name: (NSString*)team2Name gameNumber: (NSString*)gameNumber height: (CGFloat)height horizontal_topy: (CGFloat)horizontal_topy team2LabelHeight: (CGFloat)team2LabelHeight team2BackgroundHeight: (CGFloat)team2BackgroundHeight team_font_size: (CGFloat)team_font_size left_boundary: (CGFloat)left_boundary;
{
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 0.825 green: 0.922 blue: 1 alpha: 1];
    UIColor* color2 = [UIColor colorWithRed: 0.038 green: 0.286 blue: 0.357 alpha: 1];
    UIColor* forma1Color = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 1];
    
    //// Variable Declarations
    CGFloat horizontal_expression = horizontal_topy + height;
    CGFloat gameNumberExpression = horizontal_topy + height / 2.0 - 12;
    CGFloat horizontalCenterExpression = horizontal_topy + height / 2.0;
    CGFloat team1TextExpression = horizontal_topy + 1 - 20.0 / 2.0;
    CGFloat team2LabelExpression = horizontal_topy + height - team2LabelHeight / 2.0;
    CGFloat team2BackgroundExpression =-4+ horizontal_topy + height - team2BackgroundHeight / 2.0;
    CGFloat left_team_background_expression = left_boundary + 19.5;
    CGFloat left_label_expression = left_boundary + 22.5;
    CGFloat left_game_number_expression = left_boundary + 105;
    CGFloat left_vertical_line_expression = left_boundary + 133;
    
    //// vertical_center Drawing
    UIBezierPath* vertical_centerPath = [UIBezierPath bezierPathWithRect: CGRectMake(left_vertical_line_expression, (horizontalCenterExpression - 13), 30, 2)];
    [color2 setFill];
    [vertical_centerPath fill];
    
    
    //// horizontal_top Drawing
    UIBezierPath* horizontal_topPath = [UIBezierPath bezierPathWithRect: CGRectMake(left_boundary, (horizontal_topy - 12), 135, 2)];
    [color2 setFill];
    [horizontal_topPath fill];
    
    
    //// horizontal_bottom Drawing
    UIBezierPath* horizontal_bottomPath = [UIBezierPath bezierPathWithRect: CGRectMake(left_boundary, (horizontal_expression - 12), 135, 2)];
    [color2 setFill];
    [horizontal_bottomPath fill];
    
    
    //// vertical Drawing
    UIBezierPath* verticalPath = [UIBezierPath bezierPathWithRect: CGRectMake(left_vertical_line_expression, (horizontal_topy - 12), 2, height)];
    [color2 setFill];
    [verticalPath fill];
    
    
    //// team1Background Drawing
    UIBezierPath* team1BackgroundPath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(left_team_background_expression, 1, 100, 28) cornerRadius: 2];
    [color setFill];
    [team1BackgroundPath fill];
    [color2 setStroke];
    team1BackgroundPath.lineWidth = 1;
    [team1BackgroundPath stroke];
    
    
    //// team1Label Drawing
    CGRect team1LabelRect = CGRectMake(left_label_expression, (team1TextExpression - 12), 73.5, 20.5);
    NSMutableParagraphStyle* team1LabelStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
    team1LabelStyle.alignment = NSTextAlignmentLeft;
    
    NSDictionary* team1LabelFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"Helvetica" size: team_font_size], NSForegroundColorAttributeName: color2, NSParagraphStyleAttributeName: team1LabelStyle};
    
    [team1Name drawInRect: CGRectOffset(team1LabelRect, 0, (CGRectGetHeight(team1LabelRect) - [team1Name boundingRectWithSize: team1LabelRect.size options: NSStringDrawingUsesLineFragmentOrigin attributes: team1LabelFontAttributes context: nil].size.height) / 2) withAttributes: team1LabelFontAttributes];
    
    
    //// team2Background Drawing
    UIBezierPath* team2BackgroundPath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(left_team_background_expression, (team2BackgroundExpression - 11.5), 100, 28) cornerRadius: 2];
    [color setFill];
    [team2BackgroundPath fill];
    [color2 setStroke];
    team2BackgroundPath.lineWidth = 1;
    [team2BackgroundPath stroke];
    
    
    //// team2Label Drawing
    CGRect team2LabelRect = CGRectMake(left_label_expression, (team2LabelExpression - 14), 73.5, 20.5);
    NSMutableParagraphStyle* team2LabelStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
    team2LabelStyle.alignment = NSTextAlignmentLeft;
    
    NSDictionary* team2LabelFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"Helvetica" size: team_font_size], NSForegroundColorAttributeName: color2, NSParagraphStyleAttributeName: team2LabelStyle};
    
    [team2Name drawInRect: CGRectOffset(team2LabelRect, 0, (CGRectGetHeight(team2LabelRect) - [team2Name boundingRectWithSize: team2LabelRect.size options: NSStringDrawingUsesLineFragmentOrigin attributes: team2LabelFontAttributes context: nil].size.height) / 2) withAttributes: team2LabelFontAttributes];
    
    
    //// Group
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, left_game_number_expression, (gameNumberExpression - 12));
        
        
        
        //// Rectangle Drawing
        UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(1, 0, 46, 25) cornerRadius: 12.5];
        [color setFill];
        [rectanglePath fill];
        [forma1Color setStroke];
        rectanglePath.lineWidth = 1;
        [rectanglePath stroke];
        
        
        //// Rectangle 2 Drawing
        UIBezierPath* rectangle2Path = [UIBezierPath bezierPathWithRect: CGRectMake(23, 0, 1, 25)];
        [color2 setFill];
        [rectangle2Path fill];
        
        
        //// gameNumberText Drawing
        CGRect gameNumberTextRect = CGRectMake(0, 0, 24, 24);
        NSMutableParagraphStyle* gameNumberTextStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
        gameNumberTextStyle.alignment = NSTextAlignmentCenter;
        
        NSDictionary* gameNumberTextFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"Helvetica" size: 9], NSForegroundColorAttributeName: color2, NSParagraphStyleAttributeName: gameNumberTextStyle};
        
        [gameNumber drawInRect: CGRectOffset(gameNumberTextRect, 0, (CGRectGetHeight(gameNumberTextRect) - [gameNumber boundingRectWithSize: gameNumberTextRect.size options: NSStringDrawingUsesLineFragmentOrigin attributes: gameNumberTextFontAttributes context: nil].size.height) / 2) withAttributes: gameNumberTextFontAttributes];
        
        
        
        CGContextRestoreGState(context);
    }
    [self drawButtonsWithgameNumberExpression:gameNumberExpression  bottomy:team2BackgroundExpression topy:0];
}



-(UIImage *)drawCanvas4;
{

    UIGraphicsBeginImageContextWithOptions(CGSizeMake(24, 24), NO, 0.0);
//    UIGraphicsBeginImageContext(CGSizeMake(24, 24));
    //// Color Declarations
    UIColor* color2 = [UIColor colorWithRed: 0.038 green: 0.286 blue: 0.357 alpha: 1];
    
    //// team2Button Drawing
    UIBezierPath* team2ButtonPath = UIBezierPath.bezierPath;
    [team2ButtonPath moveToPoint: CGPointMake(11, 21)];
    [team2ButtonPath addCurveToPoint: CGPointMake(21, 11) controlPoint1: CGPointMake(16.52, 21) controlPoint2: CGPointMake(21, 16.52)];
    [team2ButtonPath addCurveToPoint: CGPointMake(11, 1) controlPoint1: CGPointMake(21, 5.48) controlPoint2: CGPointMake(16.52, 1)];
    [team2ButtonPath addCurveToPoint: CGPointMake(1, 11) controlPoint1: CGPointMake(5.48, 1) controlPoint2: CGPointMake(1, 5.48)];
    [team2ButtonPath addCurveToPoint: CGPointMake(11, 21) controlPoint1: CGPointMake(1, 16.52) controlPoint2: CGPointMake(5.48, 21)];
    [team2ButtonPath closePath];
    [team2ButtonPath moveToPoint: CGPointMake(7.9, 5.74)];
    [team2ButtonPath addLineToPoint: CGPointMake(8.37, 5.27)];
    [team2ButtonPath addLineToPoint: CGPointMake(14.1, 11)];
    [team2ButtonPath addLineToPoint: CGPointMake(8.37, 16.73)];
    [team2ButtonPath addLineToPoint: CGPointMake(7.9, 16.26)];
    [team2ButtonPath addLineToPoint: CGPointMake(13.16, 11)];
    [team2ButtonPath addLineToPoint: CGPointMake(7.9, 5.74)];
    [team2ButtonPath closePath];
    [color2 setFill];
    [team2ButtonPath fill];
    
    UIImage * img =  UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}






@end
