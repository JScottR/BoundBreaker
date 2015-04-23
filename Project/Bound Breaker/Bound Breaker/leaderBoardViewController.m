//
//  leaderBoardViewController.m
//  Bound Breaker
//
//  Created by JScott Richards on 4/22/15.
//
//

#import "leaderBoardViewController.h"
#import <Parse/Parse.h>

@interface leaderBoardViewController ()

@end

@implementation leaderBoardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PFQuery *query = [PFUser query];
    [query selectKeys:@[@"username", @"highScore"]];
    [query orderByDescending:@"highScore"];
    query.limit = 10;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSLog(@"%@", objects);
            PFObject *user = [objects firstObject];
            PFObject *user2 = [objects objectAtIndex:1];
            PFObject *user3 = [objects objectAtIndex:2];
            PFObject *user4 = [objects objectAtIndex:3];
            PFObject *user5 = [objects objectAtIndex:4];
            PFObject *user6 = [objects objectAtIndex:5];
            PFObject *user7 = [objects objectAtIndex:6];
            PFObject *user8 = [objects objectAtIndex:7];
            PFObject *user9 = [objects objectAtIndex:8];
            PFObject *user10 = [objects objectAtIndex:9];
            NSString *username = user[@"username"];
            NSString *highScore = user[@"highScore"];
            NSString *username2 = user2[@"username"];
            NSString *highScore2 = user2[@"highScore"];
            NSString *username3 = user3[@"username"];
            NSString *highScore3 = user3[@"highScore"];
            NSString *username4 = user4[@"username"];
            NSString *highScore4 = user4[@"highScore"];
            NSString *username5 = user5[@"username"];
            NSString *highScore5 = user5[@"highScore"];
            NSString *username6 = user6[@"username"];
            NSString *highScore6 = user6[@"highScore"];
            NSString *username7 = user7[@"username"];
            NSString *highScore7 = user7[@"highScore"];
            NSString *username8 = user8[@"username"];
            NSString *highScore8 = user8[@"highScore"];
            NSString *username9 = user9[@"username"];
            NSString *highScore9 = user9[@"highScore"];
            NSString *username10 = user10[@"username"];
            NSString *highScore10 = user10[@"highScore"];
            NSLog(@"UserName: %@       Highscore: %@", username, highScore);
            NSLog(@"UserName: %@       Highscore: %@", username2, highScore2);
            NSLog(@"UserName: %@       Highscore: %@", username3, highScore3);
            NSLog(@"UserName: %@       Highscore: %@", username4, highScore4);
            NSLog(@"UserName: %@       Highscore: %@", username5, highScore5);
            NSLog(@"UserName: %@       Highscore: %@", username6, highScore6);
            NSLog(@"UserName: %@       Highscore: %@", username7, highScore7);
            NSLog(@"UserName: %@       Highscore: %@", username8, highScore8);
            NSLog(@"UserName: %@       Highscore: %@", username9, highScore9);
            _username1.text = [NSString stringWithFormat:@"1) %@", username];
            _score1.text = [NSString stringWithFormat:@"%@",highScore];
            _username2.text = [NSString stringWithFormat:@"2) %@", username2];
            _score2.text = [NSString stringWithFormat:@"%@",highScore2];
            _username3.text = [NSString stringWithFormat:@"3) %@", username3];
            _score3.text = [NSString stringWithFormat:@"%@",highScore3];
            _username4.text = [NSString stringWithFormat:@"4) %@", username4];
            _score4.text = [NSString stringWithFormat:@"%@",highScore4];
            _username5.text = [NSString stringWithFormat:@"5) %@", username5];
            _score5.text = [NSString stringWithFormat:@"%@",highScore5];
            _username6.text = [NSString stringWithFormat:@"6) %@", username6];
            _score6.text = [NSString stringWithFormat:@"%@",highScore6];
            _username7.text = [NSString stringWithFormat:@"7) %@", username7];
            _score7.text = [NSString stringWithFormat:@"%@",highScore7];
            _username8.text = [NSString stringWithFormat:@"8) %@", username8];
            _score8.text = [NSString stringWithFormat:@"%@",highScore8];
            _username9.text = [NSString stringWithFormat:@"9) %@", username9];
            _score9.text = [NSString stringWithFormat:@"%@",highScore9];
            _username10.text = [NSString stringWithFormat:@"10) %@", username10];
            _score10.text = [NSString stringWithFormat:@"%@",highScore10];
        }
        else{
            NSLog(@"Something went wrong");
        }
    }];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
