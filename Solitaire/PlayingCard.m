//
//  PlayingCard.m
//  HI-LO
//
//  Created by KEVIN PHILLIPS on 10/10/15.
//  Copyright © 2015 KP Phillips. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit; //required when providing setter and getter, otherwise automatic
//getter check
-(NSString *)suit{
    return _suit ? _suit : @"?";
}
//setter
-(void)setSuit:(NSString *)suit{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (void)setRank:(NSInteger)rank{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}


//overiding,not re-declaring from superclass
-(NSString *)contents{
    //return [NSString stringWithFormat:@"%ld%@", (long)self.rank, self.suit];
    
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
    
}

//class  method for creating/utility
+ (NSArray *)rankStrings{
    //NSLog(@"🃑🃒🃓🃔🃕🃖🃗🃘🃙🃚🃛🃝🃞🃁🃂🃃🃄🃅🃆🃇🃈🃉🃊🃋🃍🃎🂱🂲🂳🂴🂵🂶🂷🂸🂹🂺🂻🂽🂾🂡🂢🂣🂤🂥🂦🂧🂨🂩🂪🂫🂭🂮");
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K",];
}

+ (NSInteger)maxRank {
    return [[self rankStrings] count] - 1 ;
}

//class method for creating/utility
+ (NSArray *)validSuits{
    return @[@"♥️",@"♦️",@"♠️",@"♣️",];
    
}

@end
