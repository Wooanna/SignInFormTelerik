
#import <UIKit/UIKit.h>
#import "SFCustomButton.h"
#import "SFCustomTextField.h"

@interface SignInViewController : UIViewController
@property (weak, nonatomic) IBOutlet SFCustomButton *signUpButton;
@property (weak, nonatomic) IBOutlet SFCustomButton *signInButton;
@property (weak, nonatomic) IBOutlet SFCustomTextField *usernameField;
@property (weak, nonatomic) IBOutlet SFCustomTextField *passwordField;

@end
