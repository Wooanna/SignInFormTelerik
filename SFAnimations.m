

#import "SFAnimations.h"

@implementation SFAnimations

+(void)slideView:(UIView*)view withOffsetY:(int) offsetY {
    
    [UIView animateWithDuration:0.3f animations:^ {
        view.frame = CGRectMake(0, offsetY, view.frame.size.width, view.frame.size.height);
      
    }];
}

@end
