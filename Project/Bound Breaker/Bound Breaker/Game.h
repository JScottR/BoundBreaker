//
//  Game.h
//  Bound Breaker
//
//  Created by Victor Manuel Palacios Rivera on 3/12/15.
//
//

#import <UIKit/UIKit.h>

bool Right;
bool Left;
bool longObstacleGenerate1;
bool longObstacleGenerate2;

int randomLongObstacle1Placement;
int randomLongObstacle2Placement;
int randomLongObstacle3Placement;
int randomLongObstacle4Placement;

int ScoreNumber;
NSInteger HighScoreNumber;

@interface Game : UIViewController
{
    IBOutlet UIImageView *Ball;
    IBOutlet UIButton *TapRight;
    IBOutlet UIButton *TapLeft;
    IBOutlet UIButton *GameOver;
    IBOutlet UIButton *EasyDifficultyButton;
    IBOutlet UIButton *MediumDifficultyButton;
    IBOutlet UIButton *HardDifficultyButton;
    
    IBOutlet UIImageView *longObstacle1;
    IBOutlet UIImageView *longObstacle2;
    IBOutlet UIImageView *longObstacle3;
    IBOutlet UIImageView *longObstacle4;
    
    IBOutlet UILabel *WelcomeLabel;
    IBOutlet UILabel *ScoreLabel;
    
    NSTimer *ObstacleMovement;
}

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
-(void)PlaceObstacles1;
-(void)PlaceObstacles2;
-(void)Score;
-(void)GameOver;

@end
