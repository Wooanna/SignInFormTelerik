#import "WelcomeViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.5]];
    
    [self styleNavBar];
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)styleNavBar {
   
    UINavigationBar *newNavBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 64.0)];
    [newNavBar setTintColor:[UIColor whiteColor]];
    UINavigationItem *newItem = [[UINavigationItem alloc] init];
    
    NSString* name = [self.userDetails objectForKey: @"lastname"];
   // NSString* gender;
   //TODO Make dictionary for GENDER
    newItem.title = [NSString stringWithFormat: @"Hello, Mrs. %@", name];
    
        [newNavBar setItems:@[newItem]];
    [self.view addSubview:newNavBar];
}

@end
