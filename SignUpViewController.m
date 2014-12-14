#import "SignUpViewController.h"
#import "SFCredentialsValidator.h"
#import "SFAnimations.h"
#import "SFCoreDataManager.h"
#import "WelcomeViewController.h"

@interface SignUpViewController ()<UITextFieldDelegate>

@end

@implementation SignUpViewController{
    NSDictionary* attributesDictionary;
}

const int FIRST_NAME_TAG = 3;
const int LAST_NAME_TAG = 4;
const int GENDER_TAG = 5;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.doneButton.enabled = NO;
    self.firstNameField.delegate = self;
    self.lastNameField.delegate = self;
    self.genderField.delegate = self;
    self.usernameField.delegate = self;
    self.passwordField.delegate = self;
    
    self.firstNameField.tag = FIRST_NAME_TAG;
    self.lastNameField.tag = LAST_NAME_TAG;
    self.genderField.tag = GENDER_TAG;
    self.passwordField.tag = SIGNUP_PASSWORD_TAG;
    self.usernameField.tag = SIGNUP_USERNAME_TAG;

    [self.usernameField addTarget:self
                           action:@selector(ValidateInput:)
                 forControlEvents:UIControlEventEditingChanged];
    [self.passwordField addTarget:self
                           action:@selector(ValidateInput:)
                 forControlEvents:UIControlEventEditingChanged];
    [self.firstNameField addTarget:self
                           action:@selector(ValidateInput:)
                 forControlEvents:UIControlEventEditingChanged];
    [self.lastNameField addTarget:self
                           action:@selector(ValidateInput:)
                 forControlEvents:UIControlEventEditingChanged];
    [self.genderField addTarget:self
                           action:@selector(ValidateInput:)
                 forControlEvents:UIControlEventEditingChanged];
    
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [self.firstNameField resignFirstResponder];
    [self.lastNameField resignFirstResponder];
    [self.genderField resignFirstResponder];
    [self.passwordField resignFirstResponder];
    [self.usernameField resignFirstResponder];
    return YES;
}

-(void)ValidateInput:(UITextField *)textField{
   
    if(textField.tag == SIGNUP_PASSWORD_TAG){
        if([SFCredentialsValidator.sharedValidator validateInputAsPassword:textField.text]){
            self.validSignUpPassword = YES;
        }
        else{
            self.validSignUpPassword = NO;
        }
        
    }
    else if(textField.tag == SIGNUP_USERNAME_TAG){
        if([SFCredentialsValidator.sharedValidator validateInputAsUsername:textField.text]){
            self.validSignUpUsername = YES;
        }
        else{
            self.validSignUpUsername = NO;
        }
        
    }
    else if(textField.tag == GENDER_TAG){
        if([SFCredentialsValidator.sharedValidator validateInputAsGender:textField.text]){
            self.validGender = YES;
        }
        else{
            self.validGender = NO;
        }
        
    }
    else if(textField.tag == LAST_NAME_TAG){
        if([SFCredentialsValidator.sharedValidator validateInputAsLastName:textField.text]){
            self.validLastName = YES;
        }
        else{
            self.validLastName = NO;
        }
        
    }
    else if(textField.tag == FIRST_NAME_TAG){
        if([SFCredentialsValidator.sharedValidator validateInputAsFirstName:textField.text]){
            self.validFirstName = YES;
        }
        else{
            self.validFirstName = NO;
        }
        
    }

     self.validInput = self.validSignUpPassword && self.validSignUpUsername && self.validLastName && self.validFirstName && self.validGender;

     [self AllowButtonWithButton:self.doneButton and:self.validInput];
}


- (IBAction)doneButtonClicked:(id)sender {
    //REGISTERUSER
    [SFCoreDataManager.sharedManager setupCoreData];
    attributesDictionary = [NSDictionary dictionaryWithObjects:@[self.usernameField.text, self.passwordField.text, self.firstNameField.text, self.lastNameField.text, self.genderField.text]
                                          forKeys:@[@"username", @"password", @"firstname", @"lastname", @"gender"]];
    [SFCoreDataManager.sharedManager insertEntityWithEntityName:@"UserData" andAttributesDictionary:attributesDictionary];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"FromSignUpToWelcomeSegue"]) {
        WelcomeViewController *controller = (WelcomeViewController *)segue.destinationViewController;
        controller.userDetails = attributesDictionary;
        
    }
}
@end
