//
//  SFCustomTextField.m
//  SignInForm
//
//  Created by apple1 on 12/12/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "SFCustomTextField.h"
#import "SFDrawingHelper.h"
@implementation SFCustomTextField

-(id) initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
        [self setBorderStyle: UITextBorderStyleNone];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor * outerTop = [UIColor colorWithRed:1.0 green:1.0  blue:1.0 alpha:0.5];
    
    UIColor * shadowColor = [UIColor colorWithRed:1.0 green:1.0  blue:1.0 alpha:0.5];
    
    
    CGRect outerRect = CGRectIntegral(self.bounds);
    CGMutablePathRef outerPath = createRoundedRectForRect(outerRect, 2.0);
    
    if (self.state != UIControlStateHighlighted) {
        CGContextSaveGState(context);
        CGContextSetFillColorWithColor(context, outerTop.CGColor);
        CGContextSetShadowWithColor(context, CGSizeMake(0, 2), 3.0, shadowColor.CGColor);
        CGContextAddPath(context, outerPath);
        CGContextFillPath(context);
        CGContextRestoreGState(context);
    }}



@end
