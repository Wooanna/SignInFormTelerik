#import "SignUpViewController.h"
#import "SFCredentialsValidator.h"
#import "SFAnimations.h"
#import "SFCoreDataManager.h"
#import "WelcomeViewController.h"

@interface SignUpViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstNameFieldTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lastnamefieldTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *genderFieldTopAlignment;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *usernameFieldTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *passwordFieldTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *doneButtonTopConstraint;

@end

@implementation SignUpViewController{
    
    NSDictionary* attributesDictionary;
    BOOL registeredUser;
    BOOL validFirstName;
    BOOL validLastName;
    BOOL validGender;
    BOOL validInput;
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
            validGender = YES;
        }
        else{
            validGender = NO;
        }
        
    }
    else if(textField.tag == LAST_NAME_TAG){
        if([SFCredentialsValidator.sharedValidator validateInputAsLastName:textField.text]){
            validLastName = YES;
        }
        else{
            validLastName = NO;
        }
        
    }
    else if(textField.tag == FIRST_NAME_TAG){
        if([SFCredentialsValidator.sharedValidator validateInputAsFirstName:textField.text]){
            validFirstName = YES;
        }
        else{
            validFirstName = NO;
        }
        
    }
    
    validInput = self.validSignUpPassword && self.validSignUpUsername && validLastName && validFirstName && validGender;
    if(validInput)
    {
        registeredUser =
        [SFCoreDataManager.sharedManager hasEntityWithEntityName:@"UserData" andPassword:self.passwordField.text andUsername:self.usernameField.text];
    }
    
    [self AllowButtonWithButton:self.doneButton and:(validInput && !registeredUser)];
}


- (IBAction)doneButtonClicked:(id)sender {
    //REGISTERUSER
    
    attributesDictionary = [NSDictionary dictionaryWithObjects:@[self.usernameField.text, self.passwordField.text, self.firstNameField.text, self.lastNameField.text, self.genderField.text]
                                                       forKeys:@[@"username", @"password", @"firstname", @"lastname", @"gender"]];
    [SFCoreDataManager.sharedManager insertEntityWithEntityName:@"UserData" andAttributesDictionary:attributesDictionary];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"FromSignUpToWelcomeSegue"]) {
        WelcomeViewController *controller = (WelcomeViewController *)segue.destinationViewController;
        controller.registeredUser = attributesDictionary;
        
    }
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    self.firstNameFieldTopConstraint.constant =
    [UIScreen mainScreen].bounds.size.height > 480.0f ? 180 : 110;
    self.lastnamefieldTopConstraint.constant =
    [UIScreen mainScreen].bounds.size.height > 480.0f ? 230 : 140;
    self.genderFieldTopAlignment.constant =
    [UIScreen mainScreen].bounds.size.height > 480.0f ? 280 : 170;
    self.usernameFieldTopConstraint.constant =
    [UIScreen mainScreen].bounds.size.height > 480.0f ? 330 : 200;
    self.passwordFieldTopConstraint.constant =
    [UIScreen mainScreen].bounds.size.height > 480.0f ? 380 : 230;
    self.doneButtonTopConstraint.constant =
    [UIScreen mainScreen].bounds.size.height > 480.0f ? 430 : 260;
    
    
}


@end
