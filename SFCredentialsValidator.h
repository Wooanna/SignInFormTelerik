#import <Foundation/Foundation.h>

@interface SFCredentialsValidator : NSObject

+(instancetype)sharedValidator;

-(Boolean)validateInputAsUsername: (NSString *) input;

-(Boolean)validateInputAsPassword: (NSString *) input;

-(Boolean)validateInputAsFirstName:(NSString *)input;

-(Boolean)validateInputAsLastName:(NSString *)input;

-(Boolean)validateInputAsName:(NSString *)input;

-(Boolean)validateInputAsGender:(NSString *)input;

@end
