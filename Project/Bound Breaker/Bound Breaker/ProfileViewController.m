
/*!
 @header ProfileViewController.m
 
 @brief This is the method file for ProfileViewController.m. Implement codes for viewing account info
 
 @author JScott Richards
 @copyright 2015 JScott Richards
 */

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /*! @brief user info is stored into user using the PFUser class */
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
/*! @brief logout current user and go to login page */
- (IBAction)logoutButton:(id)sender {
    [PFUser logOut];
    [self performSegueWithIdentifier:@"logout" sender:self];
    //[self dismissViewControllerAnimated:YES completion:nil];
}
/*! @brief delete account if user quits the game */
- (IBAction)deleteButton:(id)sender {
    PFUser *user = [PFUser currentUser];
    [user deleteInBackground];
    [PFUser logOut];
    [self performSegueWithIdentifier:@"logout" sender:self];
}

/*! @brief Update User name */
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
