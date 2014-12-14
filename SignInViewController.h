
#import <UIKit/UIKit.h>
#import "SFCustomButton.h"
#import "SFCustomTextField.h"
#import "BaseViewController.h"

@interface SignInViewController : BaseViewController

@property (weak, nonatomic) IBOutlet SFCustomButton *signUpButton;
@property (weak, nonatomic) IBOutlet SFCustomButton *signInButton;
@property (weak, nonatomic) IBOutlet SFCustomTextField *usernameField;
@property (weak, nonatomic) IBOutlet SFCustomTextField *passwordField;

- (IBAction)signInButtonClicked:(id)sender;

@end
