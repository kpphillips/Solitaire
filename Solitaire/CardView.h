//
//  CardView.h
//  HI-LO
//
//  Created by KEVIN PHILLIPS on 10/10/15.
//  Copyright © 2015 KP Phillips. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardGameSolitaire.h"


@interface CardView : UIView

- (instancetype)initWithFrame:(CGRect)frame;
- (void) moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option;


@end
