


#import "SFCustomButton.h"
#import "SFCustomTextField.h"

@interface BaseViewController : UIViewController

extern int const KEYBOARD_OFFSET;
extern int const SIGNIN_PASSWORD_TAG;
extern int const SIGNIN_USERNAME_TAG;
extern int const SIGNUP_PASSWORD_TAG;
extern int const SIGNUP_USERNAME_TAG;

@property(strong, nonatomic) UIImageView* backgroundImageView;
@property(strong, nonatomic) UIVisualEffect *blurEffect;
@property(strong, nonatomic) UIVisualEffectView *blurEffectView;
@property(strong, nonatomic) UIVibrancyEffect *vibrancyEffect;
@property(strong, nonatomic) NSString* passwordInput;
@property(strong, nonatomic) NSString* usernameInput;

@property BOOL validSignInPassword;
@property BOOL validSignInUsername;
@property BOOL validSignUpPassword;
@property BOOL validSignUpUsername;

-(void)SetBackgroundImage;
-(void)ApplyBlurEffect;
-(void)AllowButtonWithButton:(SFCustomButton*) button and:(BOOL)validCredentials;

@end
