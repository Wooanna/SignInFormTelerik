#import <UIKit/UIKit.h>
#import "SFCustomTextField.h"
#import "SFCustomButton.h"
#import "BaseViewController.h"

@interface SignUpViewController : BaseViewController

@property (weak, nonatomic) IBOutlet SFCustomTextField *firstNameField;

@property (weak, nonatomic) IBOutlet SFCustomTextField *genderField;

@property (weak, nonatomic) IBOutlet SFCustomTextField *lastNameField;

@property (weak, nonatomic) IBOutlet SFCustomTextField *usernameField;

@property (weak, nonatomic) IBOutlet SFCustomTextField *passwordField;

@property (weak, nonatomic) IBOutlet SFCustomButton *doneButton;

- (IBAction)doneButtonClicked:(id)sender;

@end
