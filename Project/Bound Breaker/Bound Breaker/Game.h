//
//  Game.h
//  Bound Breaker
//
//  Created by Victor Manuel Palacios Rivera on 3/12/15.
//
//

#import <UIKit/UIKit.h>

int RandomObstacleSingle1Placement;
int RandomObstacleSingle2Placement;
int RandomObstacleSingle3Placement;

@interface Game : UIViewController
{
    IBOutlet UIImageView *Ball;
    IBOutlet UIButton *StartGame;
    IBOutlet UIButton *GameOver;
    IBOutlet UIImageView *ObstacleLeft;
    IBOutlet UIImageView *ObstacleRight;
    IBOutlet UIImageView *ObstacleSingle1;
    IBOutlet UIImageView *ObstacleSingle2;
    IBOutlet UIImageView *ObstacleSingle3;
    
    NSTimer *ObstacleMovement;
}

-(IBAction)StartGame:(id)sender;
-(void)ObstaclesMoving;
-(void)PlaceObstacles;

@end
