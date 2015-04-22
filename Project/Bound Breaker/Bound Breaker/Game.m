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
//Game settings - change to obtain correct obstacle placement, gameover mechanism, etc.
int screenTop = -30;        //less than zero to place obstacles above the actual screen top
int screenBottom = 645;
int screenRight = 346;
int screenLeft = 20;

int ballSpeed = 3;
int obstacleSpeed = 1;
int defaultBallYCoord = 525;
int recoverySpeed = 1;

int numberOfObstaclesOnScreen = 2;
int obstacleDistance = 300;
int obstacleGap = 100;
int longObstacleWidth = 290;
int obstacleGeneratorBuffer = 10;

//Difficulty based on user choice
-(IBAction)EasyDifficulty:(id)sender{
    obstacleSpeed = 1;
    EasyDifficultyButton.hidden = TRUE;
    MediumDifficultyButton.hidden = TRUE;
    HardDifficultyButton.hidden = TRUE;
}
-(IBAction)MediumDifficulty:(id)sender{
    obstacleSpeed = 2;
    EasyDifficultyButton.hidden = TRUE;
    MediumDifficultyButton.hidden = TRUE;
    HardDifficultyButton.hidden = TRUE;
}
-(IBAction)HardDifficulty:(id)sender{
    obstacleSpeed = 3;
    EasyDifficultyButton.hidden = TRUE;
    MediumDifficultyButton.hidden = TRUE;
    HardDifficultyButton.hidden = TRUE;
}

//Execute once button "Start!" is pressed
-(IBAction)StartGame:(id)sender{
    ScoreLabel.hidden = FALSE;
    TapRight.hidden = FALSE;
    TapLeft.hidden = FALSE;
    Right = FALSE;
    Left = FALSE;
    longObstacleGenerate1 = TRUE;
    longObstacleGenerate2 = FALSE;
    longObstacle1.hidden = FALSE;
    longObstacle2.hidden = FALSE;
    longObstacle3.hidden = TRUE;
    longObstacle4.hidden = TRUE;
    WelcomeLabel.hidden = TRUE;
    
    [self PlaceObstacles1];
    ObstacleMovement = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(ObstaclesMoving) userInfo:nil repeats:TRUE];
}

//Score method
-(void)Score{
    ScoreNumber++;
    //ScoreLabel.text = [NSString stringWithFormat:@"%i", ScoreNumber];
    NSLog(@"%d", ScoreNumber);
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


//Obstacle movement method - executed by 'ObstacleMovement' timer
-(void)ObstaclesMoving{
    //Move ball if movement buttons are pressed
    if(Right == TRUE){
        if(Ball.center.x < screenRight){
            Ball.center = CGPointMake(Ball.center.x + ballSpeed, Ball.center.y);
        }
    }
    if(Left == TRUE){
        if(Ball.center.x > screenLeft){
            Ball.center = CGPointMake(Ball.center.x - ballSpeed, Ball.center.y);
        }
    }
    
    //Move obstacles towards bottom of screen
    longObstacle1.center = CGPointMake(longObstacle1.center.x, longObstacle1.center.y + obstacleSpeed);
    longObstacle2.center = CGPointMake(longObstacle2.center.x, longObstacle2.center.y + obstacleSpeed);
    longObstacle3.center = CGPointMake(longObstacle3.center.x, longObstacle3.center.y + obstacleSpeed);
    longObstacle4.center = CGPointMake(longObstacle4.center.x, longObstacle4.center.y + obstacleSpeed);
    
    //Place obstacles based on postion of other obstacles
    //Highly variable depending on number of obstacles and obtacle types
    if(longObstacle1.center.y > abs(obstacleDistance-screenTop) & longObstacle1.center.y < abs(obstacleDistance-screenTop+obstacleGeneratorBuffer)){
        longObstacleGenerate2 = TRUE;
        [self PlaceObstacles2];
    }
    
    if(longObstacle3.center.y > abs(obstacleDistance-screenTop) & longObstacle3.center.y < abs(obstacleDistance-screenTop+obstacleGeneratorBuffer)){
        longObstacleGenerate1 = TRUE;
        [self PlaceObstacles1];
    }
    
    //Move ball towards bottom of screen if touching non-hidden obstacles, otherwise move ball up
    if(((longObstacle1.hidden == FALSE) & CGRectIntersectsRect(Ball.frame, longObstacle1.frame))
       | ((longObstacle2.hidden == FALSE) & CGRectIntersectsRect(Ball.frame, longObstacle2.frame))
       | ((longObstacle3.hidden == FALSE) & CGRectIntersectsRect(Ball.frame, longObstacle3.frame))
       | ((longObstacle4.hidden == FALSE) & CGRectIntersectsRect(Ball.frame, longObstacle4.frame))) {
        [self ballTouchingObstacle];
    }
    else{
        [self ballNotTouchingObstacle];
    }
    
    //Increase score when obstacles pass the ball's center
    if(longObstacle1.center.y == Ball.center.y || longObstacle3.center.y == Ball.center.y){
        [self Score];
    }
    
    //Game over if ball touches bottom of screen
    if(Ball.center.y > screenBottom) {
        [self GameOver];
    }
}

//Move ball down if touching obstacles, otherwise move up towards default
-(void)ballTouchingObstacle{
    Ball.center = CGPointMake(Ball.center.x, Ball.center.y + obstacleSpeed);
}
-(void)ballNotTouchingObstacle{
    if(Ball.center.y > defaultBallYCoord){
        Ball.center = CGPointMake(Ball.center.x, Ball.center.y - recoverySpeed);
    }
}


//Method for the random placement of obstacles
-(void)PlaceObstacles1{
    if(longObstacleGenerate1 == TRUE){
        randomLongObstacle1Placement = arc4random() %abs(screenRight-screenLeft);
        randomLongObstacle2Placement = randomLongObstacle1Placement + longObstacleWidth + obstacleGap;

        longObstacle1.center = CGPointMake(randomLongObstacle1Placement, screenTop);
        longObstacle2.center = CGPointMake(randomLongObstacle2Placement, screenTop);
        
        longObstacle1.hidden = FALSE;
        longObstacle2.hidden = FALSE;
    }
    longObstacleGenerate1 = FALSE;
}

-(void)PlaceObstacles2{
    if(longObstacleGenerate2 == TRUE){
        randomLongObstacle3Placement = arc4random() %abs(screenRight-screenLeft);
        randomLongObstacle4Placement = randomLongObstacle3Placement + longObstacleWidth + obstacleGap;
    
        longObstacle3.center = CGPointMake(randomLongObstacle3Placement, screenTop);
        longObstacle4.center = CGPointMake(randomLongObstacle4Placement, screenTop);
        
        longObstacle3.hidden = FALSE;
        longObstacle4.hidden = FALSE;
    }
    longObstacleGenerate2 = FALSE;
}


//Executed once ball touches bottom of screen
-(void)GameOver{
    [ObstacleMovement invalidate];
    
    if(ScoreNumber > HighScoreNumber) {
        [[NSUserDefaults standardUserDefaults] setInteger:ScoreNumber forKey:@"HighScoreSaved"];
    }
    
    GameOver.hidden = FALSE;
    TapRight.hidden = TRUE;
    TapLeft.hidden = TRUE;
    Ball.hidden = TRUE;
    longObstacle1.hidden = TRUE;
    longObstacle2.hidden = TRUE;
    longObstacle3.hidden = TRUE;
    longObstacle4.hidden = TRUE;
    ScoreLabel.text = [NSString stringWithFormat:@"%d", ScoreNumber];
}


//Execute upon view load
- (void)viewDidLoad {
    EasyDifficultyButton.hidden = FALSE;
    MediumDifficultyButton.hidden = FALSE;
    HardDifficultyButton.hidden = FALSE;
    GameOver.hidden = TRUE;
    ScoreLabel.hidden = TRUE;
    TapRight.hidden = TRUE;
    TapLeft.hidden = TRUE;
    Right = FALSE;
    Left = FALSE;
    longObstacleGenerate1 = FALSE;
    longObstacleGenerate2 = FALSE;
    longObstacle1.hidden = TRUE;
    longObstacle2.hidden = TRUE;
    longObstacle3.hidden = TRUE;
    longObstacle4.hidden = TRUE;
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
