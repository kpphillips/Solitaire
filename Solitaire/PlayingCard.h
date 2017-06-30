//
//  PlayingCard.h
//  HI-LO
//
//  Created by KEVIN PHILLIPS on 10/10/15.
//  Copyright © 2015 KP Phillips. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSInteger rank;

+ (NSArray *)validSuits;
+ (NSInteger)maxRank;


@end
