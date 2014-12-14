#import "BaseViewController.h"
#import "SFCustomButton.h"
#import "SFAnimations.h"
#import "SFCredentialsValidator.h"

@interface BaseViewController ()

@end

@implementation BaseViewController{
    
    int KEYBOARD_OFFSET;
}
int const SIGNIN_PASSWORD_TAG = 1;
int const SIGNIN_USERNAME_TAG = 2;
int const SIGNUP_PASSWORD_TAG = 6;
int const SIGNUP_USERNAME_TAG = 7;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [self SetBackgroundImage];
    [self ApplyBlurEffect];
    [[self navigationController] setNavigationBarHidden:YES];
    KEYBOARD_OFFSET = [UIScreen mainScreen].bounds.size.height > 480.0f ? 150 : 90;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)SetBackgroundImage {
    self.backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroundImage.jpg"]];
    self.backgroundImageView.frame = self.view.frame;
    self.backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.backgroundImageView];
    [self.view setBackgroundColor:[UIColor clearColor]];
    [self.view sendSubviewToBack:self.backgroundImageView];
}

- (void)ApplyBlurEffect {
    self.blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    self.blurEffectView = [[UIVisualEffectView alloc] initWithEffect:self.blurEffect];
    self.blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
    self.blurEffectView.frame =
    CGRectMake(-self.backgroundImageView.frame.size.width,
               0,
               self.backgroundImageView.frame.size.width * 2,
               self.backgroundImageView.frame.size.height * 2);
    
    [self.backgroundImageView addSubview:self.blurEffectView];
}

-(void)AllowButtonWithButton:(SFCustomButton*) button and:(BOOL)validCredentials {
    if(validCredentials)
    {
        button.enabled = YES;
    }
    else
    {
        button.enabled = NO;
    }
}

-(void)keyboardWillShow {
    [SFAnimations slideView:self.view withOffsetY: -KEYBOARD_OFFSET];
    [SFAnimations slideView:self.backgroundImageView withOffsetY:KEYBOARD_OFFSET];
}

-(void)keyboardWillHide {
    [SFAnimations slideView:self.view withOffsetY: 0];
    [SFAnimations slideView:self.backgroundImageView withOffsetY:0];
}

@end
