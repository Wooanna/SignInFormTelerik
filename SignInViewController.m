
#import "SignInViewController.h"
#import "SFCredentialsValidator.h"

@interface SignInViewController ()<UITextFieldDelegate>

@end

@implementation SignInViewController{
    UIImageView* backgroundImageView;
    UIVisualEffect *blurEffect;
    UIVisualEffectView *blurEffectView;
    UIVibrancyEffect *vibrancyEffect;
    NSString* passwordInput;
    NSString* usernameInput;
    BOOL validPassword;
    BOOL validUsername;
}

static int const KEYBOARD_OFFSET = 100;
const int USERNAME_TAG = 1;
const int PASSWORD_TAG = 2;


- (void)SetBackgroundImage {
    backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroundImage.jpg"]];
    backgroundImageView.frame = self.view.frame;
    backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
    backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.view addSubview:backgroundImageView];
    [self.view sendSubviewToBack:backgroundImageView];
}

- (void)ApplyBlurEffect {
    blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.frame = backgroundImageView.bounds;
    [backgroundImageView addSubview:blurEffectView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self navigationController] setNavigationBarHidden:YES];
    
     self.usernameField.delegate = self;
     self.passwordField.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    self.passwordField.tag = PASSWORD_TAG;
    self.usernameField.tag = USERNAME_TAG;
    [self.usernameField addTarget:self
                  action:@selector(ValidateInput:)
        forControlEvents:UIControlEventEditingChanged];
    [self.passwordField addTarget:self
                           action:@selector(ValidateInput:)
                 forControlEvents:UIControlEventEditingChanged];
    
    [self SetBackgroundImage];
    [self ApplyBlurEffect];
    self.signInButton.enabled = NO;
   
   }

-(void)AllowUserToSignIn:(BOOL)validCredentials{
    if(validCredentials)
    {
        self.signInButton.enabled = YES;
    }
    else
    {
        self.signInButton.enabled = NO;
    }
}

-(void)ValidateInput:(UITextField*) textField{
    if(textField.tag == PASSWORD_TAG){
        if([SFCredentialsValidator.sharedValidator validateInputAsPassword:textField.text]){
            validPassword = YES;
        }
        else{
            validPassword = NO;
        }
        
    }
    else if(textField.tag == USERNAME_TAG){
        if([SFCredentialsValidator.sharedValidator validateInputAsUsername:textField.text]){
            validUsername = YES;
        }
        else{
            validUsername = NO;
        }
    }
    [self AllowUserToSignIn:(validPassword && validUsername)];
}



-(void)keyboardWillShow {
    
    [UIView animateWithDuration:0.3f animations:^ {
        self.view.frame = CGRectMake(0, -KEYBOARD_OFFSET, self.view.frame.size.width, self.view.frame.size.height);
        backgroundImageView.frame = CGRectMake(0, KEYBOARD_OFFSET, backgroundImageView.frame.size.width, backgroundImageView.frame.size.height);
    }];
}

-(void)keyboardWillHide {
    
    [UIView animateWithDuration:0.3f animations:^ {
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        backgroundImageView.frame = CGRectMake(0, 0, backgroundImageView.frame.size.width, backgroundImageView.frame.size.height);

    }];
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

@end
