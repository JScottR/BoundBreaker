//
//  GameOver.m
//  Bound Breaker
//
//  Created by Victor Manuel Palacios Rivera on 4/23/15.
//
//

#import "GameOver.h"

@implementation GameOver

/*! @brief Method that executes immediately upon loading */
- (void)viewDidLoad {
    scoreLabel.text = [NSString stringWithFormat:@"%i", scoreNumber];
    highScoreLabel.text = [NSString stringWithFormat:@"%li", (long)highScoreNumber];
}

@end