//
//  LoginViewController.m
//  Bound Breaker
//
//  Created by JScott Richards on 4/1/15.
//
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
-(void)viewDidAppear:(BOOL)animated{
    PFUser *user = [PFUser currentUser];
    if (user.username != nil) {
        [self performSegueWithIdentifier:@"login" sender:self];
    }
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

- (IBAction)registerAction:(id)sender {
    [_userNameField resignFirstResponder];
    [_emailField resignFirstResponder];
    [_passwordField resignFirstResponder];
    [_reEnterPasswordField resignFirstResponder];
    [self checkFieldsComplete];
    
}



-(void) checkFieldsComplete {
    if ([_emailField.text isEqualToString:@""] || [_userNameField.text isEqualToString:@""] || [_passwordField.text isEqualToString:@""] || [_reEnterPasswordField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ooopss!" message:@"You need to complate all fields" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    else {
        [self checkPasswordsMatch];
    }
}
-(void) checkPasswordsMatch {
    if (![_passwordField.text isEqualToString:_reEnterPasswordField.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ooopss!" message:@"Passwords don't match" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    else {
        [self registerNewUser];
    }
}
-(void) registerNewUser {
    PFUser *newUser = [PFUser user];
    newUser.username = _userNameField.text;
    newUser.email = _emailField.text;
    newUser.password = _passwordField.text;
    newUser[@"highScore"] = @0;
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            NSLog(@"Registration Complete");
            [self performSegueWithIdentifier:@"login" sender:self];
        }
        else {
            NSLog(@"Something went wrong in registration");
        }
    }];
}

- (IBAction)loginButton:(id)sender {
    [PFUser logInWithUsernameInBackground:_loginUsernameField.text password:_loginPasswordField.text block:^(PFUser *user, NSError *error) {
        if (!error) {
            NSLog(@"Login Sucessful");
            [self performSegueWithIdentifier:@"login" sender:self];
        }
    }];
}
@end
