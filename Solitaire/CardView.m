
//
//  CardView.m
//  HI-LO
//
//  Created by KEVIN PHILLIPS on 10/10/15.
//  Copyright © 2015 KP Phillips. All rights reserved.
//

#import "CardView.h"




@implementation CardView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    
    [[self layer] setCornerRadius:12.0f];
    [[self layer] setMasksToBounds:YES];
    
    //self.layer.masksToBounds = NO;
//    self.layer.shadowOffset = CGSizeMake(-15, 20);
//    self.layer.shadowRadius = 5;
//    self.layer.shadowOpacity = 0.5;

    return self;

}


-(BOOL)canBecomeFocused{
    
    
    
    CardView *card = self;
    if (card.backgroundColor == [UIColor blueColor]) {
        return NO;
    }else{
        return YES;

    }
    
}


-(void)didAddSubview:(UIView *)subview{
   
    

    
    
}

-(void)didUpdateFocusInContext:(UIFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator{
    
  //  NSLog(@"%@", context.previouslyFocusedView.backgroundColor);
  //  NSLog(@"%@", context.nextFocusedView.backgroundColor);

    
//    if (context.nextFocusedView == self) {
//        //handle focus appearance changes
//        context.nextFocusedView.backgroundColor = [UIColor redColor];
//        context.previouslyFocusedView.backgroundColor = [UIColor whiteColor];
//        
//    
//    }
//    else {
//        //handle unfocus appearance changes
//        //context.nextFocusedView.backgroundColor = [UIColor whiteColor];
//
//    }
    
}



- (void) moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option
{
    [UIView animateWithDuration:secs delay:0.0 options:option
                     animations:^{
                         self.frame = CGRectMake(destination.x,destination.y, self.frame.size.width, self.frame.size.height);
                     }completion:^(BOOL finished) {
                                  //Code to run once the animation is completed goes here
                              }];
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, 135, 210) cornerRadius: 12];
    [UIColor.blackColor setStroke];
    rectanglePath.lineWidth = 5;
    [rectanglePath stroke];
    //CardView *card = self;
   // self.tag
   
    
}


@end
