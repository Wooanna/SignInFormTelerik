
#import "SignInViewController.h"
#import "SFCredentialsValidator.h"
#import "SFAnimations.h"

@interface SignInViewController ()<UITextFieldDelegate>

@end

@implementation SignInViewController

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

    [self AllowButtonWithButton:self.signInButton and:(self.validSignInPassword && self.validSignInUsername)];

}

- (IBAction)signInButtonClicked:(id)sender {
}
@end
