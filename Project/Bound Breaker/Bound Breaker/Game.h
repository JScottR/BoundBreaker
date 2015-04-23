/*!
 @file Game.h
 
 @brief This is the header file for Game.m. It contains methods and variable declarations
 
 @author Victor Palacios
 @copyright 2015 Victor Palacios
*/

#import <UIKit/UIKit.h>
/*! Variables */
bool Right;
bool Left;
int randomLongObstacle1Placement;
int randomLongObstacle2Placement;
int randomLongObstacle3Placement;
int randomLongObstacle4Placement;
int ScoreNumber;
NSInteger HighScoreNumber;

/*! User interface elements */
@interface Game : UIViewController
{
    IBOutlet UIButton *TapRight;
    IBOutlet UIButton *TapLeft;
    IBOutlet UIButton *GameOver;
    IBOutlet UIButton *EasyDifficultyButton;
    IBOutlet UIButton *MediumDifficultyButton;
    IBOutlet UIButton *HardDifficultyButton;
    
    IBOutlet UIImageView *Ball;
    IBOutlet UIImageView *longObstacle1;
    IBOutlet UIImageView *longObstacle2;
    IBOutlet UIImageView *longObstacle3;
    IBOutlet UIImageView *longObstacle4;
    
    IBOutlet UILabel *WelcomeLabel;
    IBOutlet UILabel *ScoreLabel;
    
    NSTimer *ObstacleMovement;
}

/*! Actions and methods */
-(IBAction)StartGame:(id)sender;
-(IBAction)EasyDifficulty:(id)sender;
-(IBAction)MediumDifficulty:(id)sender;
-(IBAction)HardDifficulty:(id)sender;
-(IBAction)RightPress:(id)sender;
-(IBAction)RightLiftInside:(id)sender;
-(IBAction)RightLiftOutside:(id)sender;
-(IBAction)LeftPress:(id)sender;
-(IBAction)LeftLiftInside:(id)sender;
-(IBAction)LeftLiftOutside:(id)sender;
-(void)ObstaclesMoving;
-(void)ballTouchingObstacle;
-(void)ballNotTouchingObstacle;
-(void)PlaceObstacles1;
-(void)PlaceObstacles2;
-(void)Score;
-(void)GameOver;

@end
