
#import "SignInViewController.h"

@interface SignInViewController ()
<UITextFieldDelegate>

@end

@implementation SignInViewController{
    UIImageView* backgroundImageView;
}

static int const KEYBOARD_OFFSET = 100;

- (void)viewDidLoad {
    [super viewDidLoad];
   [[self navigationController] setNavigationBarHidden:YES];
    backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroundImage.jpg"]];
    backgroundImageView.frame = self.view.frame;
    backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
  
    [self.view addSubview:backgroundImageView];
    [self.view sendSubviewToBack:backgroundImageView];
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
   }

-(void)keyboardWillShow {
    
    [UIView animateWithDuration:0.3f animations:^ {
        self.view.frame = CGRectMake(0, -100, self.view.frame.size.width, self.view.frame.size.height);
        backgroundImageView.frame = CGRectMake(0, +100, backgroundImageView.frame.size.width, backgroundImageView.frame.size.height);
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
