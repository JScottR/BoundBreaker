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

int ScoreNumber;

@interface Game : UIViewController
{
    IBOutlet UIImageView *Ball;
    IBOutlet UIButton *TapRight;
    IBOutlet UIButton *TapLeft;
    IBOutlet UIButton *StartGame;
    IBOutlet UIButton *GameOver;
    
    IBOutlet UIImageView *ObstacleSingle1;
    IBOutlet UIImageView *ObstacleSingle2;
    IBOutlet UIImageView *ObstacleSingle3;
    
    IBOutlet UILabel *WelcomeLabel;
    IBOutlet UILabel *ScoreLabel;
    
    NSTimer *ObstacleMovement;
}

-(IBAction)StartGame:(id)sender;
-(IBAction)RightPress:(id)sender;
-(IBAction)RightLiftInside:(id)sender;
-(IBAction)RightLiftOutside:(id)sender;
-(IBAction)LeftPress:(id)sender;
-(IBAction)LeftLiftInside:(id)sender;
-(IBAction)LeftLiftOutside:(id)sender;
-(void)ObstaclesMoving;
-(void)PlaceObstacles;
-(void)GameOver;

@end
