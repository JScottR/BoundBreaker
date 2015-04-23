//
//  GameOver.h
//  Bound Breaker
//
//  Created by Victor Manuel Palacios Rivera on 4/23/15.
//
//

#import <UIKit/UIKit.h>

extern int ScoreNumber;
extern NSInteger HighScoreNumber;


@interface GameOver : UIViewController
{
    IBOutlet UILabel *scoreLabel;
    IBOutlet UILabel *highscoreLabel;
}
- (void)viewDidLoad;

@end
