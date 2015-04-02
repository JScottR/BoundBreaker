//
//  Game.m
//  Bound Breaker
//
//  Created by Victor Manuel Palacios Rivera on 3/12/15.
//
//

#import "Game.h"

@interface Game ()

@end

@implementation Game

-(IBAction)StartGame:(id)sender{
    StartGame.hidden = TRUE;
    ScoreLabel.hidden = FALSE;
    TapRight.hidden = FALSE;
    TapLeft.hidden = FALSE;
    Right = FALSE;
    Left = FALSE;
    ObstacleSingle1.hidden = FALSE;
    ObstacleSingle2.hidden = FALSE;
    ObstacleSingle3.hidden = FALSE;
    WelcomeLabel.hidden = TRUE;
    ScoreNumber = 0;
    
    [self PlaceObstacles];
    ObstacleMovement = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(ObstaclesMoving) userInfo:nil repeats:TRUE];
}


// Movement response from user input (touch down, release inside, and release outside)
-(void)BallMoving{
    while(Right == TRUE){
        Ball.center = CGPointMake(Ball.center.x + 1, Ball.center.y);
    }
    while(Left == TRUE){
        Ball.center = CGPointMake(Ball.center.x - 1, Ball.center.y);
    }
}

-(IBAction)RightPress:(id)sender{
    Right = TRUE;
}
-(IBAction)RightLiftInside:(id)sender{
    Right = FALSE;
}
-(IBAction)RightLiftOutside:(id)sender{
    Right = FALSE;
}

-(IBAction)LeftPress:(id)sender{
    Left = TRUE;
}
-(IBAction)LeftLiftInside:(id)sender{
    Left = FALSE;
}
-(IBAction)LeftLiftOutside:(id)sender{
    Left = FALSE;
}


// Obstacle movement method
-(void)ObstaclesMoving{
    if(Right == TRUE){
        Ball.center = CGPointMake(Ball.center.x + 1, Ball.center.y);
    }
    if(Left == TRUE){
        Ball.center = CGPointMake(Ball.center.x - 1, Ball.center.y);
    }
    
    ObstacleSingle1.center = CGPointMake(ObstacleSingle1.center.x, ObstacleSingle1.center.y + 1);
    ObstacleSingle2.center = CGPointMake(ObstacleSingle2.center.x, ObstacleSingle2.center.y + 1);
    ObstacleSingle3.center = CGPointMake(ObstacleSingle3.center.x, ObstacleSingle3.center.y + 1);
    
    if(ObstacleSingle1.center.y > 475) {
        [self PlaceObstacles];
    }
    
    if(CGRectIntersectsRect(Ball.frame, ObstacleSingle1.frame)){
        Ball.center = CGPointMake(Ball.center.x, Ball.center.y + 1);
    }
    if(CGRectIntersectsRect(Ball.frame, ObstacleSingle2.frame)){
        Ball.center = CGPointMake(Ball.center.x, Ball.center.y + 1);
    }
    if(CGRectIntersectsRect(Ball.frame, ObstacleSingle3.frame)){
        Ball.center = CGPointMake(Ball.center.x, Ball.center.y + 1);
    }
    
    if(Ball.center.y > 475) {
        [self GameOver];
    }
}


// Method for the random placement of obstacles
-(void)PlaceObstacles{
    RandomObstacleSingle1Placement = arc4random() %135;
    RandomObstacleSingle1Placement = RandomObstacleSingle1Placement + 135;
    RandomObstacleSingle2Placement = RandomObstacleSingle1Placement - 135;
    RandomObstacleSingle3Placement = RandomObstacleSingle2Placement - 70;
    
    ObstacleSingle1.center = CGPointMake(RandomObstacleSingle1Placement, 0);
    ObstacleSingle2.center = CGPointMake(RandomObstacleSingle2Placement, 0);
    ObstacleSingle3.center = CGPointMake(RandomObstacleSingle3Placement, 0);
}


// Game Over method
-(void)GameOver{
    [ObstacleMovement invalidate];
    
    GameOver.hidden = FALSE;
    TapRight.hidden = TRUE;
    TapLeft.hidden = TRUE;
    Ball.hidden = TRUE;
    ObstacleSingle1.hidden = TRUE;
    ObstacleSingle2.hidden = TRUE;
    ObstacleSingle3.hidden = TRUE;
}


// Execute upon view load
- (void)viewDidLoad {
    GameOver.hidden = TRUE;
    StartGame.hidden = FALSE;
    ScoreLabel.hidden = TRUE;
    TapRight.hidden = TRUE;
    TapLeft.hidden = TRUE;
    Right = FALSE;
    Left = FALSE;
    ObstacleSingle1.hidden = TRUE;
    ObstacleSingle2.hidden = TRUE;
    ObstacleSingle3.hidden = TRUE;
    WelcomeLabel.hidden = FALSE;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
