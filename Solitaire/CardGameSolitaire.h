//
//  CardGameSolitaire.h
//  HI-LO
//
//  Created by KEVIN PHILLIPS on 10/10/15.
//  Copyright © 2015 KP Phillips. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayingCardDeck.h"

@interface CardGameSolitaire : NSObject

//designated Initializer
- (instancetype)initWithDeck:(Deck *)deck;


@property (nonatomic, strong) NSMutableArray *stockPile; //of Card
@property (nonatomic, strong) NSMutableArray *wastePile; //of Card
@property (nonatomic, strong) NSMutableDictionary *theTableau; //of Card
@property (nonatomic, strong) NSMutableArray *foundationA; //of Card
@property (nonatomic, strong) NSMutableArray *foundationB; //of Card
@property (nonatomic, strong) NSMutableArray *foundationC; //of Card
@property (nonatomic, strong) NSMutableArray *foundationD; //of Card



-(PlayingCard*)drawFromStock;
-(BOOL)chooseCardAtIndex:(NSInteger)keyAndIndex;
- (PlayingCard *)cardAtIndex:(NSInteger)index;


@end
