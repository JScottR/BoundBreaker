/*!
 @file Game.m
 
 @brief Method file for the Game view. Implements game and player mechanisms
 
 @author Victor Palacios
 @copyright 2015 Victor Palacios
 */

#import "Game.h"
#import <Parse/Parse.h>

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
int singleObstacleWidth = 49;
/*! Variable needed for proper obstacle placement mechanism,
 used to narrow the obstacle regeneration area to a small portion of the screen */
int obstacleGeneratorBuffer = 10;

/*! @brief Action that sets difficulty to easy */
-(IBAction)easyDifficulty:(id)sender{
    obstacleSpeed = 1;
    easyDifficultyButton.hidden = TRUE;
    mediumDifficultyButton.hidden = TRUE;
    hardDifficultyButton.hidden = TRUE;
}
/*! @brief Action that sets difficulty to medium */
-(IBAction)mediumDifficulty:(id)sender{
    obstacleSpeed = 2;
    easyDifficultyButton.hidden = TRUE;
    mediumDifficultyButton.hidden = TRUE;
    hardDifficultyButton.hidden = TRUE;
}
/*! @brief Action that sets difficulty to hard */
-(IBAction)hardDifficulty:(id)sender{
    obstacleSpeed = 3;
    easyDifficultyButton.hidden = TRUE;
    mediumDifficultyButton.hidden = TRUE;
    hardDifficultyButton.hidden = TRUE;
}

/*! @brief Action that begins the game */
-(IBAction)startGame:(id)sender{
    /*! Hide/show elements */
    tapRight.hidden = FALSE;
    tapLeft.hidden = FALSE;
    right = FALSE;
    left = FALSE;
    longObstacle1_1.hidden = FALSE;
    longObstacle1_2.hidden = FALSE;
    longObstacle2_1.hidden = TRUE;
    longObstacle2_2.hidden = TRUE;
    singleObstacle1_1.hidden = TRUE;
    singleObstacle1_2.hidden = TRUE;
    singleObstacle1_3.hidden = TRUE;
    singleObstacle2_1.hidden = TRUE;
    singleObstacle2_2.hidden = TRUE;
    singleObstacle2_3.hidden = TRUE;
    welcomeLabel.hidden = TRUE;
    /*! Deal with user information */
    scoreNumber = 0;
    PFUser *user = [PFUser currentUser];
    NSNumber *currentHighScore = user[@"highScore"];
    highScoreNumber = [currentHighScore intValue];
   
    /*! Start game by placing first obstacle */
    [self placeLongObstacles1];
    /*! Initiate timers */
    obstacleMovement = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(obstaclesMoving) userInfo:nil repeats:TRUE];
    scoreTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(score) userInfo:nil repeats:TRUE];
}

/*! @brief Method that increases score and logs it */
-(void)score{
    scoreNumber++;
    /*! scoreLabel.text = [NSString stringWithFormat:@"%i", ScoreNumber]; */
    NSLog(@"%d", scoreNumber);
}

/*! @brief Action that initializes ball right movement
 Triggered by pressing the right movement button */
-(IBAction)rightPress:(id)sender{
    right = TRUE;
}
/*! @brief Action that deactivates ball right movement
 Triggered by releasing inside of the right movement button */
-(IBAction)rightLiftInside:(id)sender{
    right = FALSE;
}
/*! @brief Action that deactivates ball right movement
 Triggered by releasing outside of the right movement button */
-(IBAction)rightLiftOutside:(id)sender{
    right = FALSE;
}

/*! @brief Action that deactivates left ball movement
 Triggered by pressing the left movement button */
-(IBAction)leftPress:(id)sender{
    left = TRUE;
}
/*! @brief Action that deactivates ball left movement
 Triggered by releasing inside of the left movement button */
-(IBAction)leftLiftInside:(id)sender{
    left = FALSE;
}
/*! @brief Action that deactivates ball left movement
 Triggered by releasing outside of the left movement button */
-(IBAction)leftLiftOutside:(id)sender{
    left = FALSE;
}


/*! @brief Method triggered by the obstacleMovement timer
 Executes methods involved with motion */
-(void)obstaclesMoving{
    /*! Move ball if movement buttons are pressed, checking that not at edge or touching obstacles
        Must be modified with each new obstacle to prevent overlap */
    if(right == TRUE){
        if((ball.center.x < screenRight)
           & !CGRectIntersectsRect(ball.frame, longObstacle1_1.frame)
           & !CGRectIntersectsRect(ball.frame, longObstacle1_2.frame)
           & !CGRectIntersectsRect(ball.frame, longObstacle2_1.frame)
           & !CGRectIntersectsRect(ball.frame, longObstacle2_2.frame)
           & !CGRectIntersectsRect(ball.frame, singleObstacle1_1.frame)
           & !CGRectIntersectsRect(ball.frame, singleObstacle1_2.frame)
           & !CGRectIntersectsRect(ball.frame, singleObstacle1_3.frame)
           & !CGRectIntersectsRect(ball.frame, singleObstacle2_1.frame)
           & !CGRectIntersectsRect(ball.frame, singleObstacle2_2.frame)
           & !CGRectIntersectsRect(ball.frame, singleObstacle2_3.frame)){
            ball.center = CGPointMake(ball.center.x + ballSpeed, ball.center.y);
        }
    }
    if(left == TRUE){
        if((ball.center.x > screenLeft)
           & !CGRectIntersectsRect(ball.frame, longObstacle1_1.frame)
           & !CGRectIntersectsRect(ball.frame, longObstacle1_2.frame)
           & !CGRectIntersectsRect(ball.frame, longObstacle2_1.frame)
           & !CGRectIntersectsRect(ball.frame, longObstacle2_2.frame)
           & !CGRectIntersectsRect(ball.frame, singleObstacle1_1.frame)
           & !CGRectIntersectsRect(ball.frame, singleObstacle1_2.frame)
           & !CGRectIntersectsRect(ball.frame, singleObstacle1_3.frame)
           & !CGRectIntersectsRect(ball.frame, singleObstacle2_1.frame)
           & !CGRectIntersectsRect(ball.frame, singleObstacle2_2.frame)
           & !CGRectIntersectsRect(ball.frame, singleObstacle2_3.frame)){
            ball.center = CGPointMake(ball.center.x - ballSpeed, ball.center.y);
        }
    }
    
    /*! Move obstacles towards bottom of screen */
    /*! Modify with each new obstacle */
    longObstacle1_1.center = CGPointMake(longObstacle1_1.center.x, longObstacle1_1.center.y + obstacleSpeed);
    longObstacle1_2.center = CGPointMake(longObstacle1_2.center.x, longObstacle1_2.center.y + obstacleSpeed);
    longObstacle2_1.center = CGPointMake(longObstacle2_1.center.x, longObstacle2_1.center.y + obstacleSpeed);
    longObstacle2_2.center = CGPointMake(longObstacle2_2.center.x, longObstacle2_2.center.y + obstacleSpeed);
    singleObstacle1_1.center = CGPointMake(singleObstacle1_1.center.x, singleObstacle1_1.center.y + obstacleSpeed);
    singleObstacle1_2.center = CGPointMake(singleObstacle1_2.center.x, singleObstacle1_2.center.y + obstacleSpeed);
    singleObstacle1_3.center = CGPointMake(singleObstacle1_3.center.x, singleObstacle1_3.center.y + obstacleSpeed);
    singleObstacle2_1.center = CGPointMake(singleObstacle2_1.center.x, singleObstacle2_1.center.y + obstacleSpeed);
    singleObstacle2_2.center = CGPointMake(singleObstacle2_2.center.x, singleObstacle2_2.center.y + obstacleSpeed);
    singleObstacle2_3.center = CGPointMake(singleObstacle2_3.center.x, singleObstacle2_3.center.y + obstacleSpeed);
    
    /*! Place obstacles based on postion of other obstacles */
    /*! Highly variable depending on number of obstacles and obtacle types */
    if(longObstacle1_1.center.y > abs(obstacleDistance-screenTop)
       & longObstacle1_1.center.y < abs(obstacleDistance-screenTop+obstacleGeneratorBuffer)){
        [self placeLongObstacles2];
    }
    if(longObstacle2_1.center.y > abs(obstacleDistance-screenTop)
       & longObstacle2_1.center.y < abs(obstacleDistance-screenTop+obstacleGeneratorBuffer)){
        [self placeLongObstacles1];
    }
    if(longObstacle1_1.center.y > abs(obstacleDistance-screenTop)/2
       & longObstacle1_1.center.y < abs(obstacleDistance-screenTop+obstacleGeneratorBuffer)/2){
        [self placeSingleObstacles1];
    }
    if(longObstacle2_1.center.y > abs(obstacleDistance-screenTop)/2
       & longObstacle2_1.center.y < abs(obstacleDistance-screenTop+obstacleGeneratorBuffer)/2){
        [self placeSingleObstacles2];
    }
    
    /*! Move ball towards bottom of screen if touching non-hidden obstacles, otherwise move ball up */
    /*! Modify with each new obstacle */
    if(((longObstacle1_1.hidden == FALSE) & CGRectIntersectsRect(ball.frame, longObstacle1_1.frame))
       | ((longObstacle1_2.hidden == FALSE) & CGRectIntersectsRect(ball.frame, longObstacle1_2.frame))
       | ((longObstacle2_1.hidden == FALSE) & CGRectIntersectsRect(ball.frame, longObstacle2_1.frame))
       | ((longObstacle2_2.hidden == FALSE) & CGRectIntersectsRect(ball.frame, longObstacle2_2.frame))
       | ((singleObstacle1_1.hidden == FALSE) & CGRectIntersectsRect(ball.frame, singleObstacle1_1.frame))
       | ((singleObstacle1_2.hidden == FALSE) & CGRectIntersectsRect(ball.frame, singleObstacle1_2.frame))
       | ((singleObstacle1_3.hidden == FALSE) & CGRectIntersectsRect(ball.frame, singleObstacle1_3.frame))
       | ((singleObstacle2_1.hidden == FALSE) & CGRectIntersectsRect(ball.frame, singleObstacle2_1.frame))
       | ((singleObstacle2_2.hidden == FALSE) & CGRectIntersectsRect(ball.frame, singleObstacle2_2.frame))
       | ((singleObstacle2_3.hidden == FALSE) & CGRectIntersectsRect(ball.frame, singleObstacle2_3.frame))){
        [self ballTouchingObstacle];
    }
    else{
        [self ballNotTouchingObstacle];
    }
    
    /*! Game over if ball touches bottom of screen */
    if(ball.center.y > screenBottom) {
        [self gameOver];
    }
}

/*! @brief Method that moves ball down if touching obstacles */
-(void)ballTouchingObstacle{
    ball.center = CGPointMake(ball.center.x, ball.center.y + obstacleSpeed);
}
/*! @brief Method that moves ball up towards default y coordinate */
-(void)ballNotTouchingObstacle{
    if(ball.center.y > defaultBallYCoord){
        ball.center = CGPointMake(ball.center.x, ball.center.y - recoverySpeed);
    }
}

/*! @brief Method that regenerates longObstacle1_1 and longObstacle1_2 at the top with random x coordinate */
-(void)placeLongObstacles1{
    randomLongObstacle1_1Placement = arc4random() %abs(screenRight-screenLeft);
    randomLongObstacle1_2Placement = randomLongObstacle1_1Placement + longObstacleWidth + obstacleGap;

    longObstacle1_1.center = CGPointMake(randomLongObstacle1_1Placement, screenTop);
    longObstacle1_2.center = CGPointMake(randomLongObstacle1_2Placement, screenTop);
        
    longObstacle1_1.hidden = FALSE;
    longObstacle1_2.hidden = FALSE;
}
/*! @brief Method that regenerates longObstacle2_1 and longObstacle2_2 at the top with random x coordinate */
-(void)placeLongObstacles2{
    randomLongObstacle2_1Placement = arc4random() %abs(screenRight-screenLeft);
    randomLongObstacle2_2Placement = randomLongObstacle2_1Placement + longObstacleWidth + obstacleGap;
    
    longObstacle2_1.center = CGPointMake(randomLongObstacle2_1Placement, screenTop);
    longObstacle2_2.center = CGPointMake(randomLongObstacle2_2Placement, screenTop);
        
    longObstacle2_1.hidden = FALSE;
    longObstacle2_2.hidden = FALSE;
}
/*! @brief Method that regenerates singleObstacle1_1, singleObstacle1_2, and singleObstacle1_3 at the top with random x coordinate */
-(void)placeSingleObstacles1{
    randomSingleObstacle1_1Placement = arc4random() %abs(screenRight-screenLeft);
    randomSingleObstacle1_2Placement = arc4random() %abs(screenRight-screenLeft);
    randomSingleObstacle1_3Placement = arc4random() %abs(screenRight-screenLeft);
    
    singleObstacle1_1.center = CGPointMake(randomSingleObstacle1_1Placement, screenTop);
    singleObstacle1_2.center = CGPointMake(randomSingleObstacle1_2Placement, screenTop);
    singleObstacle1_3.center = CGPointMake(randomSingleObstacle1_3Placement, screenTop);
    
    singleObstacle1_1.hidden = FALSE;
    singleObstacle1_2.hidden = FALSE;
    singleObstacle1_3.hidden = FALSE;
    /*! Regenerate again if obstacles overlap */
    while(CGRectIntersectsRect(singleObstacle1_1.frame, singleObstacle1_2.frame)
          | CGRectIntersectsRect(singleObstacle1_1.frame, singleObstacle1_3.frame)
          | CGRectIntersectsRect(singleObstacle1_2.frame, singleObstacle1_3.frame)){
        [self placeSingleObstacles1];
    }
}
/*! @brief Method that regenerates singleObstacle2_1, singleObstacle2_2, and singleObstacle2_3 at the top with random x coordinate */
-(void)placeSingleObstacles2{
    randomSingleObstacle2_1Placement = arc4random() %abs(screenRight-screenLeft);
    randomSingleObstacle2_2Placement = arc4random() %abs(screenRight-screenLeft);
    randomSingleObstacle2_3Placement = arc4random() %abs(screenRight-screenLeft);
    
    singleObstacle2_1.center = CGPointMake(randomSingleObstacle2_1Placement, screenTop);
    singleObstacle2_2.center = CGPointMake(randomSingleObstacle2_2Placement, screenTop);
    singleObstacle2_3.center = CGPointMake(randomSingleObstacle2_3Placement, screenTop);
    
    singleObstacle2_1.hidden = FALSE;
    singleObstacle2_2.hidden = FALSE;
    singleObstacle2_3.hidden = FALSE;
    /*! Regenerate again if obstacles overlap */
    while(CGRectIntersectsRect(singleObstacle2_1.frame, singleObstacle2_2.frame)
          | CGRectIntersectsRect(singleObstacle2_1.frame, singleObstacle2_3.frame)
          | CGRectIntersectsRect(singleObstacle2_2.frame, singleObstacle2_3.frame)){
        [self placeSingleObstacles2];
    }
}

/*! @brief Method that executes once ball touches bottom of screen */
-(void)gameOver{
    /*! Stop timers */
    [obstacleMovement invalidate];
    [scoreTimer invalidate];
    /*! Update highest score if needed */
    if(scoreNumber > highScoreNumber) {
        [[NSUserDefaults standardUserDefaults] setInteger:scoreNumber forKey:@"HighScoreSaved"];
        PFUser *user = [PFUser currentUser];
        NSNumber *newHighScore = [NSNumber numberWithInt:scoreNumber];
        user[@"highscore"] = newHighScore;
        NSLog(@"%@",newHighScore);
        [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
            if (!error) {
                NSLog(@"Updated");
            }
        }];
    }
    /*! Hide/show elements */
    gameOver.hidden = FALSE;
    tapRight.hidden = TRUE;
    tapLeft.hidden = TRUE;
    ball.hidden = TRUE;
    longObstacle1_1.hidden = TRUE;
    longObstacle1_2.hidden = TRUE;
    longObstacle2_1.hidden = TRUE;
    longObstacle2_2.hidden = TRUE;
    singleObstacle1_1.hidden = TRUE;
    singleObstacle1_2.hidden = TRUE;
    singleObstacle1_3.hidden = TRUE;
    singleObstacle2_1.hidden = TRUE;
    singleObstacle2_2.hidden = TRUE;
    singleObstacle2_3.hidden = TRUE;
}


/*! @brief Method that executes immediately upon loading */
- (void)viewDidLoad {
    /*! Hide/show elements */
    easyDifficultyButton.hidden = FALSE;
    mediumDifficultyButton.hidden = FALSE;
    hardDifficultyButton.hidden = FALSE;
    gameOver.hidden = TRUE;
    tapRight.hidden = TRUE;
    tapLeft.hidden = TRUE;
    right = FALSE;
    left = FALSE;
    longObstacle1_1.hidden = TRUE;
    longObstacle1_2.hidden = TRUE;
    longObstacle2_1.hidden = TRUE;
    longObstacle2_2.hidden = TRUE;
    singleObstacle1_1.hidden = TRUE;
    singleObstacle1_2.hidden = TRUE;
    singleObstacle1_3.hidden = TRUE;
    singleObstacle2_1.hidden = TRUE;
    singleObstacle2_2.hidden = TRUE;
    singleObstacle2_3.hidden = TRUE;
    welcomeLabel.hidden = FALSE;
    
    /*! Fetch highest score */
    highScoreNumber = [[NSUserDefaults standardUserDefaults] integerForKey:@"HighScoreSaved"];
    
    [super viewDidLoad];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
