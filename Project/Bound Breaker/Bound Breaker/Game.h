/*!
 @file Game.h
 
 @brief This is the header file for Game.m. It contains methods and variable declarations
 
 @author Victor Palacios
 @copyright 2015 Victor Palacios
*/

#import <UIKit/UIKit.h>
/*! Variables */
bool right;
bool left;
int randomLongObstacle1Placement;
int randomLongObstacle2Placement;
int randomLongObstacle3Placement;
int randomLongObstacle4Placement;
int scoreNumber;
NSInteger highScoreNumber;

/*! User interface elements */
@interface Game : UIViewController
{
    IBOutlet UIButton *tapRight;
    IBOutlet UIButton *tapLeft;
    IBOutlet UIButton *gameOver;
    IBOutlet UIButton *easyDifficultyButton;
    IBOutlet UIButton *mediumDifficultyButton;
    IBOutlet UIButton *hardDifficultyButton;
    
    IBOutlet UIImageView *ball;
    IBOutlet UIImageView *longObstacle1_1;
    IBOutlet UIImageView *longObstacle1_2;
    IBOutlet UIImageView *longObstacle2_1;
    IBOutlet UIImageView *longObstacle2_2;
    IBOutlet UIImageView *singleObstacle1_1;
    IBOutlet UIImageView *singleObstacle1_2;
    IBOutlet UIImageView *singleObstacle1_3;
    IBOutlet UIImageView *singleObstacle2_1;
    IBOutlet UIImageView *singleObstacle2_2;
    IBOutlet UIImageView *singleObstacle2_3;
    
    IBOutlet UILabel *welcomeLabel;
    
    NSTimer *obstacleMovement;
}

/*! Actions and methods */
-(IBAction)startGame:(id)sender;
-(IBAction)easyDifficulty:(id)sender;
-(IBAction)mediumDifficulty:(id)sender;
-(IBAction)hardDifficulty:(id)sender;
-(IBAction)rightPress:(id)sender;
-(IBAction)rightLiftInside:(id)sender;
-(IBAction)rightLiftOutside:(id)sender;
-(IBAction)leftPress:(id)sender;
-(IBAction)leftLiftInside:(id)sender;
-(IBAction)leftLiftOutside:(id)sender;
-(void)obstaclesMoving;
-(void)ballTouchingObstacle;
-(void)ballNotTouchingObstacle;
-(void)placeObstacles1;
-(void)placeObstacles2;
-(void)score;
-(void)gameOver;

@end
