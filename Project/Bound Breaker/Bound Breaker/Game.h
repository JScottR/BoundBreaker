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

int RandomObstacleSingle1Placement;
int RandomObstacleSingle2Placement;
int RandomObstacleSingle3Placement;
int RandomObstacleSingle4Placement;

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
    
    IBOutlet UIImageView *ObstacleSingle1;
    IBOutlet UIImageView *ObstacleSingle2;
    IBOutlet UIImageView *ObstacleSingle3;
    IBOutlet UIImageView *ObstacleSingle4;
    
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
-(void)PlaceObstacles;
-(void)Score;
-(void)GameOver;

@end
