/*!
 @file ProfileViewController.h
 */

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ProfileViewController : UIViewController 
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *highScoreLabel;
- (IBAction)logoutButton:(id)sender;
- (IBAction)deleteButton:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *userNameField;
- (IBAction)saveChanges:(id)sender;


@end
