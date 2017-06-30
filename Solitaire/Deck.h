//
//  Deck.h
//  HI-LO
//
//  Created by KEVIN PHILLIPS on 10/10/15.
//  Copyright © 2015 KP Phillips. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

-(void)addCard:(Card *)card;
-(Card *)drawRandomCard;



@end
