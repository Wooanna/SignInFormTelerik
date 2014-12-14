#import "WelcomeViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self styleNavBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)styleNavBar {
    
    UINavigationBar *newNavBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 64.0)];
    [newNavBar setTintColor:[UIColor whiteColor]];
    UINavigationItem *newItem = [[UINavigationItem alloc] init];
    
    NSString* name = [_registeredUser valueForKey:@"lastname"];
    NSString* gender = [_registeredUser valueForKey:@"gender"];
    
    NSDictionary* genderDictionary = [NSDictionary dictionaryWithObjects:@[@"Mr.", @"Mr.", @"Mrs.", @"Mrs", @""] forKeys: @[@"male", @"m", @"female", @"f", @"other"]];
    
    newItem.title = [NSString stringWithFormat: @"Hello, %@ %@", [genderDictionary valueForKey:gender], name];
    
    [newNavBar setItems:@[newItem]];
    [self.view addSubview:newNavBar];
}

@end
