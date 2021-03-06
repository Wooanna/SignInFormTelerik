#import "SignInViewController.h"
#import "SFCredentialsValidator.h"
#import "SFAnimations.h"
#import "SFCoreDataManager.h"
#import "WelcomeViewController.h"

@interface SignInViewController ()<UITextFieldDelegate>

@end

@implementation SignInViewController{
    BOOL registeredUser;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.passwordField.tag = SIGNIN_PASSWORD_TAG;
    self.usernameField.tag = SIGNIN_USERNAME_TAG;
    self.signInButton.enabled = NO;
    self.usernameField.delegate = self;
    self.passwordField.delegate = self;
    
    [self.usernameField addTarget:self
                           action:@selector(ValidateInput:)
                 forControlEvents:UIControlEventEditingChanged];
    [self.passwordField addTarget:self
                           action:@selector(ValidateInput:)
                 forControlEvents:UIControlEventEditingChanged];
    
    [SFCoreDataManager.sharedManager setupCoreData];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.passwordField resignFirstResponder];
    [self.usernameField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)ValidateInput:(UITextField*) textField{
    if(textField.tag == SIGNIN_PASSWORD_TAG){
        if([SFCredentialsValidator.sharedValidator validateInputAsPassword:textField.text]){
            self.validSignInPassword = YES;
        }
        else{
            self.validSignInPassword = NO;
        }
        
    }
    else if(textField.tag == SIGNIN_USERNAME_TAG){
        if([SFCredentialsValidator.sharedValidator validateInputAsUsername:textField.text]){
            self.validSignInUsername = YES;
        }
        else{
            self.validSignInUsername = NO;
        }
        
    }
    
    if(self.validSignInPassword && self.validSignInUsername){
        registeredUser =
        [SFCoreDataManager.sharedManager hasEntityWithEntityName:@"UserData" andPassword:self.passwordField.text andUsername:self.usernameField.text];
    }
    
    BOOL registeredValidCredentials = self.validSignInPassword && self.validSignInUsername && registeredUser;
    
    [self AllowButtonWithButton: self.signInButton and: registeredValidCredentials];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"FromSignInToWelcomeSegue"]) {
        WelcomeViewController *controller = (WelcomeViewController *)segue.destinationViewController;
        controller.registeredUser =
        [SFCoreDataManager.sharedManager loggedUserDataWithPassword:self.passwordField.text andUsername:self.usernameField.text];
    }
}

- (IBAction)signInButtonClicked:(id)sender {
}
@end
