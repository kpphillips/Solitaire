//
//  Deck.m
//  HI-LO
//
//  Created by KEVIN PHILLIPS on 10/10/15.
//  Copyright © 2015 KP Phillips. All rights reserved.
//

#import "Deck.h"


@interface Deck ()
// Declare Private Properties here
@property (strong, nonatomic) NSMutableArray *cards;  //of Card

@end


@implementation Deck


//allocates the array in the heap
//can be sone in the getter
//lazy instantiation
- (NSMutableArray*)cards{
    if(!_cards) _cards = [[NSMutableArray alloc]init];
    return _cards;
}


-(void)addCard:(Card *)card{
    [self.cards addObject:card];
}

-(Card *)drawRandomCard{
    Card *randomCard = nil;
    
    if ([self.cards count]) {
        unsigned index = arc4random() % [self.cards count];
        randomCard = self.cards[index]; // [] same as calling = [self.cards objectAtIndex:index];
        [self.cards removeObjectAtIndex:index]; //removes card from the deck
    }
    
    return randomCard;
    
}



@end
