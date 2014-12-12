//
//  SFCredentialsValidator.m
//  SignInForm
//
//  Created by admin on 12/12/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "SFCredentialsValidator.h"

@implementation SFCredentialsValidator

bool arePasswordSymbolsValid, areUsernameSymbolsValid, isPasswordLengthValid, isUsernameLengthValid;

static int const MIN_USERNAME_LENGTH = 3;
static int const MIN_PASSWORD_LENGTH = 8;
static NSString * const validSymbolsRegex = @"[A-Z0-9a-z_]*";
NSCharacterSet *specialSymbols = nil;
NSCharacterSet *numbers = nil;

+(void)instantiate{
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
        arePasswordSymbolsValid = NO;
    }
    else {
        arePasswordSymbolsValid = YES;
    }
    
    if (input.length < MIN_PASSWORD_LENGTH) {
        isPasswordLengthValid = NO;
    }
    else{
    isPasswordLengthValid = YES;
    }
    
    
    return isPasswordLengthValid && arePasswordSymbolsValid;
};

-(Boolean)validateInputAsUsername:(NSString *)input {
        
    areUsernameSymbolsValid =
    [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", validSymbolsRegex] evaluateWithObject:input];
    
    if (input.length <= MIN_USERNAME_LENGTH) {
        isUsernameLengthValid = NO;
    }
    else{
    isUsernameLengthValid = YES;
    }
    
    return isUsernameLengthValid && areUsernameSymbolsValid;
};


@end
