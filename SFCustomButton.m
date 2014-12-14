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
    
    UIColor* buttonColor;
    UIColor * shadowColor;
    
    CGRect outerRect = CGRectIntegral(self.bounds);
    CGMutablePathRef buttonPath = createRoundedRectForRect(outerRect, 2.0);
    
    if (self.state == UIControlStateDisabled) {
        
        buttonColor =[UIColor colorWithRed:0.6 green:0.0  blue:0.0 alpha:0.3];
        shadowColor = [UIColor colorWithRed:1.0 green:0.0  blue:0.0 alpha:0.8];
        
    }
    else if(self.state == UIControlStateHighlighted) {
        
        buttonColor =[UIColor colorWithRed:0.2 green:0.9  blue:0.9 alpha:0.7];
        shadowColor = [UIColor colorWithRed:1.0 green:0.1  blue:0.1 alpha:0.8];
        
    }
    
    else{
        
        buttonColor = [UIColor colorWithRed:0.1 green:0.6  blue:0.1 alpha:0.3];
        shadowColor = [UIColor colorWithRed:0.1 green:0.9  blue:0.5 alpha:0.8];
        
    }
    
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, buttonColor.CGColor);
    CGContextSetShadowWithColor(context, CGSizeMake(0, 0), 10.0, shadowColor.CGColor);
    
    CGContextAddPath(context, buttonPath);
    CGContextFillPath(context);
    CGContextRestoreGState(context);
    
}

- (void)setHighlighted:(BOOL)highlighted
{
    [self setNeedsDisplay];
    [super setHighlighted:highlighted];
}


@end
