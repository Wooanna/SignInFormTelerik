#import "SignUpViewController.h"
#import "SFCredentialsValidator.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController{
    
    NSString* firstnameInput;
    NSString* lastnameInput;
    NSString* genderInput;
    NSString* usernameInput;
    NSString* passwordInput;
    
}

-(void)viewWillAppear:(BOOL)animated{

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.firstNameField.delegate = self;
    self.lastNameField.delegate = self;
    self.genderField.delegate = self;
    self.usernameField.delegate = self;
    self.passwordField.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

@end
