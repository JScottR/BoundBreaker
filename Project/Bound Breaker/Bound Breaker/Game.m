/*!
 @header Game.m
 
 @brief Method file for the Game view. Implements game and player mechanisms
 
 @author Victor Palacios
 @copyright 2015 Victor Palacios
 */

#import "Game.h"

@interface Game ()

@end

@implementation Game
/*! Game settings - change to obtain correct obstacle placement, gameover mechanism, etc. */
/*! Screen top declared as negative to have obstacles regenerate offscreen */
int screenTop = -30;
int screenBottom = 645;
int screenRight = 346;
int screenLeft = 20;
/*! Variables that deal with the ball/player */
int ballSpeed = 3;
int defaultBallYCoord = 525;
int recoverySpeed = 1;
/*! Variables that deal with the obstacles */
int obstacleSpeed = 1;
int numberOfObstaclesOnScreen = 2;
int obstacleDistance = 300;
int obstacleGap = 100;
int longObstacleWidth = 290;
/*! Variable needed for proper obstacle placement mechanism,
 used to narrow the obstacle regeneration area to a small portion of the screen */
int obstacleGeneratorBuffer = 10;

/*! @brief Action that sets difficulty to easy */
-(IBAction)EasyDifficulty:(id)sender{
    obstacleSpeed = 1;
    EasyDifficultyButton.hidden = TRUE;
    MediumDifficultyButton.hidden = TRUE;
    HardDifficultyButton.hidden = TRUE;
}
/*! @brief Action that sets difficulty to medium */
-(IBAction)MediumDifficulty:(id)sender{
    obstacleSpeed = 2;
    EasyDifficultyButton.hidden = TRUE;
    MediumDifficultyButton.hidden = TRUE;
    HardDifficultyButton.hidden = TRUE;
}
/*! @brief Action that sets difficulty to hard */
-(IBAction)HardDifficulty:(id)sender{
    obstacleSpeed = 3;
    EasyDifficultyButton.hidden = TRUE;
    MediumDifficultyButton.hidden = TRUE;
    HardDifficultyButton.hidden = TRUE;
}

/*! @brief Action that begins the game */
-(IBAction)StartGame:(id)sender{
    ScoreLabel.hidden = FALSE;
    TapRight.hidden = FALSE;
    TapLeft.hidden = FALSE;
    Right = FALSE;
    Left = FALSE;
    longObstacle1.hidden = FALSE;
    longObstacle2.hidden = FALSE;
    longObstacle3.hidden = TRUE;
    longObstacle4.hidden = TRUE;
    WelcomeLabel.hidden = TRUE;
    
    [self PlaceObstacles1];
    ObstacleMovement = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(ObstaclesMoving) userInfo:nil repeats:TRUE];
}

/*! @brief Method to increase the score by 1, also logs the score number */
-(void)Score{
    ScoreNumber++;
    //ScoreLabel.text = [NSString stringWithFormat:@"%i", ScoreNumber];
    NSLog(@"%d", ScoreNumber);
}

/*! @brief Action that initializes ball right movement
 Triggered by rpressing the right movement button */
-(IBAction)RightPress:(id)sender{
    Right = TRUE;
}
/*! @brief Action that deactivates ball right movement
 Triggered by releasing inside of the right movement button */
-(IBAction)RightLiftInside:(id)sender{
    Right = FALSE;
}
/*! @brief Action that deactivates ball right movement
 Triggered by releasing outside of the right movement button */
-(IBAction)RightLiftOutside:(id)sender{
    Right = FALSE;
}

/*! @brief Action that deactivates left ball movement
 Triggered by pressing the left movement button */
-(IBAction)LeftPress:(id)sender{
    Left = TRUE;
}
/*! @brief Action that deactivates ball left movement
 Triggered by releasing inside of the left movement button */
-(IBAction)LeftLiftInside:(id)sender{
    Left = FALSE;
}
/*! @brief Action that deactivates ball left movement
 Triggered by releasing outside of the left movement button */
-(IBAction)LeftLiftOutside:(id)sender{
    Left = FALSE;
}


/*! @brief Method triggered by the ObstacleMovement timer
 Executes methods involved with motion */
-(void)ObstaclesMoving{
    /*! Move ball if movement buttons are pressed */
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
    
    /*! Move obstacles towards bottom of screen */
    longObstacle1.center = CGPointMake(longObstacle1.center.x, longObstacle1.center.y + obstacleSpeed);
    longObstacle2.center = CGPointMake(longObstacle2.center.x, longObstacle2.center.y + obstacleSpeed);
    longObstacle3.center = CGPointMake(longObstacle3.center.x, longObstacle3.center.y + obstacleSpeed);
    longObstacle4.center = CGPointMake(longObstacle4.center.x, longObstacle4.center.y + obstacleSpeed);
    
    /*! Place obstacles based on postion of other obstacles */
    /*! Highly variable depending on number of obstacles and obtacle types */
    if(longObstacle1.center.y > abs(obstacleDistance-screenTop) & longObstacle1.center.y < abs(obstacleDistance-screenTop+obstacleGeneratorBuffer)){
        [self PlaceObstacles2];
    }
    
    if(longObstacle3.center.y > abs(obstacleDistance-screenTop) & longObstacle3.center.y < abs(obstacleDistance-screenTop+obstacleGeneratorBuffer)){
        [self PlaceObstacles1];
    }
    
    /*! Move ball towards bottom of screen if touching non-hidden obstacles, otherwise move ball up */
    if(((longObstacle1.hidden == FALSE) & CGRectIntersectsRect(Ball.frame, longObstacle1.frame))
       | ((longObstacle2.hidden == FALSE) & CGRectIntersectsRect(Ball.frame, longObstacle2.frame))
       | ((longObstacle3.hidden == FALSE) & CGRectIntersectsRect(Ball.frame, longObstacle3.frame))
       | ((longObstacle4.hidden == FALSE) & CGRectIntersectsRect(Ball.frame, longObstacle4.frame))) {
        [self ballTouchingObstacle];
    }
    else{
        [self ballNotTouchingObstacle];
    }
    
    /*! Increase score when obstacles pass the ball's center */
    if(longObstacle1.center.y == Ball.center.y || longObstacle3.center.y == Ball.center.y){
        [self Score];
    }
    
    /*! Game over if ball touches bottom of screen */
    if(Ball.center.y > screenBottom) {
        [self GameOver];
    }
}

/*! Move ball down if touching obstacles, otherwise move up towards default */
-(void)ballTouchingObstacle{
    Ball.center = CGPointMake(Ball.center.x, Ball.center.y + obstacleSpeed);
}
-(void)ballNotTouchingObstacle{
    if(Ball.center.y > defaultBallYCoord){
        Ball.center = CGPointMake(Ball.center.x, Ball.center.y - recoverySpeed);
    }
}


/*! Method for the random placement of obstacles */
-(void)PlaceObstacles1{
    randomLongObstacle1Placement = arc4random() %abs(screenRight-screenLeft);
    randomLongObstacle2Placement = randomLongObstacle1Placement + longObstacleWidth + obstacleGap;

    longObstacle1.center = CGPointMake(randomLongObstacle1Placement, screenTop);
    longObstacle2.center = CGPointMake(randomLongObstacle2Placement, screenTop);
        
    longObstacle1.hidden = FALSE;
    longObstacle2.hidden = FALSE;
}

-(void)PlaceObstacles2{
    randomLongObstacle3Placement = arc4random() %abs(screenRight-screenLeft);
    randomLongObstacle4Placement = randomLongObstacle3Placement + longObstacleWidth + obstacleGap;
    
    longObstacle3.center = CGPointMake(randomLongObstacle3Placement, screenTop);
    longObstacle4.center = CGPointMake(randomLongObstacle4Placement, screenTop);
        
    longObstacle3.hidden = FALSE;
    longObstacle4.hidden = FALSE;
}


/*! Executed once ball touches bottom of screen */
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


/*! Execute upon view load */
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
    longObstacle1.hidden = TRUE;
    longObstacle2.hidden = TRUE;
    longObstacle3.hidden = TRUE;
    longObstacle4.hidden = TRUE;
    WelcomeLabel.hidden = FALSE;
    
    ScoreNumber = 0;
    HighScoreNumber = [[NSUserDefaults standardUserDefaults] integerForKey:@"HighScoreSaved"];
    
    [super viewDidLoad];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
