//
//  ProfileViewController.m
//  Bound Breaker
//
//  Created by JScott Richards on 4/1/15.
//
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PFUser *user = [PFUser currentUser];
    NSString *userName = user.username;
    NSString *email = user.email;
    int highScore = [user[@"highScore"] intValue];
    _highScoreLabel.text = [NSString stringWithFormat:@"%i", highScore];
    _userNameLabel.text = [NSString stringWithFormat:@"%@", userName];
    _emailLabel.text = [NSString stringWithFormat:@"%@", email];
    _userNameField.text = [NSString stringWithFormat:@"%@", userName];
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

- (IBAction)logoutButton:(id)sender {
    [PFUser logOut];
    [self performSegueWithIdentifier:@"logout" sender:self];
    //[self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)deleteButton:(id)sender {
    PFUser *user = [PFUser currentUser];
    [user deleteInBackground];
    [PFUser logOut];
    [self performSegueWithIdentifier:@"logout" sender:self];
}


- (IBAction)saveChanges:(id)sender {
    PFUser *user = [PFUser currentUser];
    user.username = _userNameField.text;
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        if (!error) {
            NSLog(@"Updated");
        }
    }];
    
}
@end
