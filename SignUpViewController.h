#import <UIKit/UIKit.h>
#import "SFCustomTextField.h"
#import "SFCustomButton.h"
#import "BaseViewController.h"

@interface SignUpViewController : BaseViewController

@property (weak, nonatomic) IBOutlet SFCustomTextField *firstNameField;

@property (weak, nonatomic) IBOutlet SFCustomTextField *genderField;

@property (weak, nonatomic) IBOutlet SFCustomTextField *lastNameField;
@property (weak, nonatomic) IBOutlet SFCustomButton *doneButton;
@property (weak, nonatomic) IBOutlet SFCustomTextField *usernameField;
@property (weak, nonatomic) IBOutlet SFCustomTextField *passwordField;

- (IBAction)doneButtonClicked:(id)sender;

@property BOOL validFirstName;
@property BOOL validLastName;
@property BOOL validGender;
@property BOOL validInput;

extern const int FIRST_NAME_TAG;
extern const int LAST_NAME_TAG;
extern const int GENDER_TAG;

@end
