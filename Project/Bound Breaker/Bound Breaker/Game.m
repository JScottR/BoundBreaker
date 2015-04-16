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
//Game settings
int screenTop = 0;
int screenBottom = 617;
int screenRight = 325;
int screenLeft = 0;

int obstacleSpeed = 1;
int singleObstacleWidth = 50;
int singleObstacleGap = 120;

//Difficulty based on user choice
-(IBAction)EasyDifficulty:(id)sender{
    
}
-(IBAction)MediumDifficulty:(id)sender{
    
}
-(IBAction)HardDifficulty:(id)sender{
    
}

//Execute once button "Start!" is pressed
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
    ObstacleSingle4.hidden = FALSE;
    WelcomeLabel.hidden = TRUE;
    
    [self PlaceObstacles];
    ObstacleMovement = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(ObstaclesMoving) userInfo:nil repeats:TRUE];
}

//Score method
-(void)Score{
    ScoreNumber = ScoreNumber + 1;
    //ScoreLabel.text = [NSString stringWithFormat:@"%i", ScoreNumber];
}

//Movement button action
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
        if(Ball.center.x < screenRight){
            Ball.center = CGPointMake(Ball.center.x + 1, Ball.center.y);
        }
    }
    if(Left == TRUE){
        if(Ball.center.x > screenLeft){
            Ball.center = CGPointMake(Ball.center.x - 1, Ball.center.y);
        }
    }
    
    ObstacleSingle1.center = CGPointMake(ObstacleSingle1.center.x, ObstacleSingle1.center.y + obstacleSpeed);
    ObstacleSingle2.center = CGPointMake(ObstacleSingle2.center.x, ObstacleSingle2.center.y + obstacleSpeed);
    ObstacleSingle3.center = CGPointMake(ObstacleSingle3.center.x, ObstacleSingle3.center.y + obstacleSpeed);
    ObstacleSingle4.center = CGPointMake(ObstacleSingle4.center.x, ObstacleSingle4.center.y + obstacleSpeed);
    
    if(ObstacleSingle1.center.y > screenBottom) {
        [self PlaceObstacles];
    }
    
    if(CGRectIntersectsRect(Ball.frame, ObstacleSingle1.frame)){
        Ball.center = CGPointMake(Ball.center.x, Ball.center.y + obstacleSpeed);
    }
    if(CGRectIntersectsRect(Ball.frame, ObstacleSingle2.frame)){
        Ball.center = CGPointMake(Ball.center.x, Ball.center.y + obstacleSpeed);
    }
    if(CGRectIntersectsRect(Ball.frame, ObstacleSingle3.frame)){
        Ball.center = CGPointMake(Ball.center.x, Ball.center.y + obstacleSpeed);
    }
    if(CGRectIntersectsRect(Ball.frame, ObstacleSingle4.frame)){
        Ball.center = CGPointMake(Ball.center.x, Ball.center.y + obstacleSpeed);
    }
    
    if(ObstacleSingle1.center.y == Ball.center.y){
        [self Score];
    }
    
    if(Ball.center.y > screenBottom) {
        [self GameOver];
    }
}


// Method for the random placement of obstacles
-(void)PlaceObstacles{
    RandomObstacleSingle1Placement = arc4random() %(screenRight/2);
    RandomObstacleSingle2Placement = RandomObstacleSingle1Placement + singleObstacleWidth;
    RandomObstacleSingle3Placement = RandomObstacleSingle2Placement + singleObstacleGap;
    RandomObstacleSingle4Placement = RandomObstacleSingle3Placement + singleObstacleWidth;
    
    ObstacleSingle1.center = CGPointMake(RandomObstacleSingle1Placement, screenTop);
    ObstacleSingle2.center = CGPointMake(RandomObstacleSingle2Placement, screenTop);
    ObstacleSingle3.center = CGPointMake(RandomObstacleSingle3Placement, screenTop);
    ObstacleSingle4.center = CGPointMake(RandomObstacleSingle4Placement, screenTop);
}


// Game Over method
-(void)GameOver{
    [ObstacleMovement invalidate];
    
    if(ScoreNumber > HighScoreNumber) {
        [[NSUserDefaults standardUserDefaults] setInteger:ScoreNumber forKey:@"HighScoreSaved"];
    }
    
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
    ObstacleSingle4.hidden = TRUE;
    WelcomeLabel.hidden = FALSE;
    
    ScoreNumber = 0;
    HighScoreNumber = [[NSUserDefaults standardUserDefaults] integerForKey:@"HighScoreSaved"];
    
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
