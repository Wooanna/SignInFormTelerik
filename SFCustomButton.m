
#import "SFCustomButton.h"
#import "SFDrawingHelper.h"
#import <CoreGraphics/CoreGraphics.h>

@implementation SFCustomButton

-(id) initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor * enabledButtonColor = [UIColor colorWithRed:0.1 green:0.6  blue:0.1 alpha:0.4];
    UIColor * disabledButtonColor = [UIColor colorWithRed:0.6 green:0.0  blue:0.1 alpha:0.4];

    UIColor * shadowColor = [UIColor colorWithRed:1.0 green:1.0  blue:1.0 alpha:0.4];
    
    
    CGRect outerRect = CGRectIntegral(self.bounds);
    CGMutablePathRef buttonPath = createRoundedRectForRect(outerRect, 2.0);
   
    if (self.state == UIControlStateDisabled) {
        CGContextSaveGState(context);
        CGContextSetFillColorWithColor(context, disabledButtonColor.CGColor);
        CGContextSetShadowWithColor(context, CGSizeMake(0, 2), 3.0, shadowColor.CGColor);
        CGContextAddPath(context, buttonPath);
        CGContextFillPath(context);
        CGContextRestoreGState(context);
    }
    else{
        CGContextSaveGState(context);
        CGContextSetFillColorWithColor(context, enabledButtonColor.CGColor);
        CGContextSetShadowWithColor(context, CGSizeMake(0, 2), 3.0, shadowColor.CGColor);
        CGContextAddPath(context, buttonPath);
        CGContextFillPath(context);
        CGContextRestoreGState(context);
    }
}



@end
