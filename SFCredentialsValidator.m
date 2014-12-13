#import "SFCredentialsValidator.h"

@implementation SFCredentialsValidator

static int const MIN_USERNAME_LENGTH = 3;
static int const MIN_PASSWORD_LENGTH = 8;
static NSString * const validUsernameSymbolsRegex = @"[A-Z0-9a-z_]*";
static NSString * const validNameSymbolsRegex = @"[A-Za-z_]*";
static const NSArray* GENDER;
NSCharacterSet *specialSymbols = nil;
NSCharacterSet *numbers = nil;

+(void)initialize{
    if (!GENDER) {
        GENDER = [NSArray arrayWithObject:@[@"male", @"female", @"m", @"f", @"other"]];
    }
    if (!specialSymbols) {
        specialSymbols = [NSCharacterSet characterSetWithCharactersInString:@".,/\[]=-+_)(*&^%$#@!?"];
    }
    if (!numbers) {
        numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    }
}

+(id)sharedValidator{
    static SFCredentialsValidator *sharedValidator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedValidator = [[self alloc] init];
    });
    return sharedValidator;
}

-(Boolean)validateInputAsPassword:(NSString *)input {
    
    if ([input rangeOfCharacterFromSet:numbers].location == NSNotFound ||
        [input rangeOfCharacterFromSet:specialSymbols].location == NSNotFound) {
        return NO;
    }
    
    if (input.length < MIN_PASSWORD_LENGTH) {
        return NO;
    }
    
    return YES;
};

-(Boolean)validateInputAsUsername:(NSString *)input {
        
   if(![[NSPredicate predicateWithFormat:@"SELF MATCHES %@", validUsernameSymbolsRegex] evaluateWithObject:input]){
       return NO;
   }
    
    if (input.length <= MIN_USERNAME_LENGTH) {
        return NO;
    }
    
    return YES;
};

-(Boolean)validateInputAsFirstName:(NSString *)input{
    return [self validateInputAsName:input];
};

-(Boolean)validateInputAsLastName:(NSString *)input{
    return [self validateInputAsName:input];
};

-(Boolean)validateInputAsName:(NSString *)input{
    if(input.length <= MIN_USERNAME_LENGTH){
        return  NO;
    }
    if (![[NSPredicate predicateWithFormat:@"SELF MATCHES %@", validNameSymbolsRegex] evaluateWithObject:input]) {
        return NO;
    }
    return YES;
    
}

-(Boolean)validateInputAsGender:(NSString *)input{
   return [GENDER containsObject: input];
    
}


@end
