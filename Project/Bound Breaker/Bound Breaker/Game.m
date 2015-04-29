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
int screenright = 346;
int screenleft = 20;
/*! Variables that deal with the ball/player */
int ballSpeed = 3;
int defaultBallYCoord = 525;
int recoverySpeed = 1;
/*! Variables that deal with the obstacles */
int scoreYCoord = 500;
int obstacleSpeed = 1;
int numberOfObstaclesOnScreen = 2;
int obstacleDistance = 300;
int obstacleGap = 100;
int longObstacleWidth = 290;
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
    [self placeObstacles1];
    obstacleMovement = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(obstaclesMoving) userInfo:nil repeats:TRUE];
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
        if((ball.center.x < screenright)
           & !CGRectIntersectsRect(ball.frame, longObstacle1_1.frame)
           & !CGRectIntersectsRect(ball.frame, longObstacle1_2.frame)
           & !CGRectIntersectsRect(ball.frame, longObstacle2_1.frame)
           & !CGRectIntersectsRect(ball.frame, longObstacle2_2.frame)){
            ball.center = CGPointMake(ball.center.x + ballSpeed, ball.center.y);
        }
    }
    if(left == TRUE){
        if((ball.center.x > screenleft)
            & !CGRectIntersectsRect(ball.frame, longObstacle1_1.frame)
            & !CGRectIntersectsRect(ball.frame, longObstacle1_2.frame)
            & !CGRectIntersectsRect(ball.frame, longObstacle2_1.frame)
            & !CGRectIntersectsRect(ball.frame, longObstacle2_2.frame)){
            ball.center = CGPointMake(ball.center.x - ballSpeed, ball.center.y);
        }
    }
    
    /*! Move obstacles towards bottom of screen */
    longObstacle1_1.center = CGPointMake(longObstacle1_1.center.x, longObstacle1_1.center.y + obstacleSpeed);
    longObstacle1_2.center = CGPointMake(longObstacle1_2.center.x, longObstacle1_2.center.y + obstacleSpeed);
    longObstacle2_1.center = CGPointMake(longObstacle2_1.center.x, longObstacle2_1.center.y + obstacleSpeed);
    longObstacle2_2.center = CGPointMake(longObstacle2_2.center.x, longObstacle2_2.center.y + obstacleSpeed);
    
    /*! Place obstacles based on postion of other obstacles */
    /*! Highly variable depending on number of obstacles and obtacle types */
    if(longObstacle1_1.center.y > abs(obstacleDistance-screenTop) & longObstacle1_1.center.y < abs(obstacleDistance-screenTop+obstacleGeneratorBuffer)){
        [self placeObstacles2];
    }
    
    if(longObstacle2_1.center.y > abs(obstacleDistance-screenTop) & longObstacle2_1.center.y < abs(obstacleDistance-screenTop+obstacleGeneratorBuffer)){
        [self placeObstacles1];
    }
    
    /*! Move ball towards bottom of screen if touching non-hidden obstacles, otherwise move ball up */
    if(((longObstacle1_1.hidden == FALSE) & CGRectIntersectsRect(ball.frame, longObstacle1_1.frame))
       | ((longObstacle1_2.hidden == FALSE) & CGRectIntersectsRect(ball.frame, longObstacle1_2.frame))
       | ((longObstacle2_1.hidden == FALSE) & CGRectIntersectsRect(ball.frame, longObstacle2_1.frame))
       | ((longObstacle2_2.hidden == FALSE) & CGRectIntersectsRect(ball.frame, longObstacle2_2.frame))) {
        [self ballTouchingObstacle];
    }
    else{
        [self ballNotTouchingObstacle];
    }
    
    /*! Increase score when non-hidden obstacles pass the ball
     Must be modified with each new obstacle added */
    if((longObstacle1_1.hidden == FALSE & longObstacle1_1.center.y >= scoreYCoord & longObstacle1_1.center.y < (scoreYCoord+obstacleSpeed)) | (longObstacle2_1.hidden == FALSE & longObstacle2_1.center.y >= scoreYCoord & longObstacle2_1.center.y < (scoreYCoord+obstacleSpeed))){
        [self score];
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

/*! @brief Method that regenerates longObstacle1_1 at the top with random x coordinate */
-(void)placeObstacles1{
    randomLongObstacle1Placement = arc4random() %abs(screenright-screenleft);
    randomLongObstacle2Placement = randomLongObstacle1Placement + longObstacleWidth + obstacleGap;

    longObstacle1_1.center = CGPointMake(randomLongObstacle1Placement, screenTop);
    longObstacle1_2.center = CGPointMake(randomLongObstacle2Placement, screenTop);
        
    longObstacle1_1.hidden = FALSE;
    longObstacle1_2.hidden = FALSE;
}
/*! @brief Method that regenerates longObstacle1_2 at the top with random x coordinate */
-(void)placeObstacles2{
    randomLongObstacle3Placement = arc4random() %abs(screenright-screenleft);
    randomLongObstacle4Placement = randomLongObstacle3Placement + longObstacleWidth + obstacleGap;
    
    longObstacle2_1.center = CGPointMake(randomLongObstacle3Placement, screenTop);
    longObstacle2_2.center = CGPointMake(randomLongObstacle4Placement, screenTop);
        
    longObstacle2_1.hidden = FALSE;
    longObstacle2_2.hidden = FALSE;
}


/*! @brief Method that executes once ball touches bottom of screen */
-(void)gameOver{
    /*! Stop timers */
    [obstacleMovement invalidate];
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
