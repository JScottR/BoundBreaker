//
//  GameOver.h
//  Bound Breaker
//
//  Created by Victor Manuel Palacios Rivera on 4/23/15.
//
//

#import <UIKit/UIKit.h>

extern int scoreNumber;
extern NSInteger highScoreNumber;


@interface GameOver : UIViewController
{
    IBOutlet UILabel *scoreLabel;
    IBOutlet UILabel *highScoreLabel;
}
- (void)viewDidLoad;

@end
