//
//  PlayingCardDeck.m
//  HI-LO
//
//  Created by KEVIN PHILLIPS on 10/10/15.
//  Copyright © 2015 KP Phillips. All rights reserved.
//

#import "PlayingCardDeck.h"

@implementation PlayingCardDeck


-(instancetype)init{
    
    self = [super init];
    if (self) {
        for (NSString *suit in [PlayingCard validSuits]) {
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
                PlayingCard *card = [[PlayingCard alloc]init];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card];
            }
        }
        
    }
    return self;
}



@end
