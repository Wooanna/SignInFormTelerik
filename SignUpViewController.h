#import <UIKit/UIKit.h>
#import "SFCustomTextField.h"
#import "SFCustomButton.h"

@interface SignUpViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet SFCustomTextField *firstNameField;

@property (weak, nonatomic) IBOutlet SFCustomTextField *genderField;

@property (weak, nonatomic) IBOutlet SFCustomTextField *usernameField;

@property (weak, nonatomic) IBOutlet SFCustomTextField *passwordField;

@property (weak, nonatomic) IBOutlet SFCustomTextField *lastNameField;

@end
