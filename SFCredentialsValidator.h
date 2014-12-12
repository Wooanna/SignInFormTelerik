//
//  SFCredentialsValidator.h
//  SignInForm
//
//  Created by admin on 12/12/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFCredentialsValidator : NSObject

+(instancetype)sharedValidator;

-(Boolean)validateInputAsUsername: (NSString *) input;

-(Boolean)validateInputAsPassword: (NSString *) input;

@end
