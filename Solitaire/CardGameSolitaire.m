
//
//  CardGameSolitaire.m
//  HI-LO
//
//  Created by KEVIN PHILLIPS on 10/10/15.
//  Copyright © 2015 KP Phillips. All rights reserved.
//

#import "CardGameSolitaire.h"

@interface CardGameSolitaire()

@property (nonatomic, strong) PlayingCard *selectedCard;
@property (nonatomic, strong) PlayingCard *matchedCard;


@end

NSInteger selectedCardColumn;
NSInteger selectedRow;

BOOL updateWaste = NO;

@implementation CardGameSolitaire



- (NSMutableArray*)stockPile{
    if(!_stockPile) _stockPile = [[NSMutableArray alloc]init];
    return _stockPile;
}

-(NSMutableArray*)wastePile{
    if(!_wastePile)_wastePile = [[NSMutableArray alloc]init];
    return _wastePile;
}

- (NSMutableDictionary*)theTableau{
    if(!_theTableau) _theTableau = [[NSMutableDictionary alloc]init];
    return _theTableau;
}

- (NSMutableArray*)foundationA{
    if(!_foundationA) _foundationA = [[NSMutableArray alloc]init];
    return _foundationA;
}

- (NSMutableArray*)foundationB{
    if(!_foundationB) _foundationB = [[NSMutableArray alloc]init];
    return _foundationB;
}

- (NSMutableArray*)foundationC{
    if(!_foundationC) _foundationC = [[NSMutableArray alloc]init];
    return _foundationC;
}

- (NSMutableArray*)foundationD{
    if(!_foundationD) _foundationD = [[NSMutableArray alloc]init];
    return _foundationD;
}


- (instancetype)initWithDeck:(Deck *)deck{
    self = [super init];
    if (self) {
        
        //build columns of cards
        for (int i = 7; (i != 0); i--) {
            NSMutableArray *array = [[NSMutableArray alloc]init];
            for (int j = 0; j < i; j++) {
                Card *card = [deck drawRandomCard];
                if (card) {
                    [array addObject:card];
                }else {
                    self = nil;
                    break;
                }
            }
            
            [self.theTableau setObject:array forKey:[NSNumber numberWithInt:i]];
        }
        
        while (deck) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.stockPile addObject:card];
            }else {
                //self = nil;
                break;
            }
        }
        
    }
    return self;
    
}

//draw and refresh the stock
-(PlayingCard*)drawFromStock{
    PlayingCard *card = [self.stockPile lastObject];
    if (card) {
        [self.stockPile removeLastObject];
        [self.wastePile addObject:card];

    }else{
        //update the stockpile
        self.stockPile = self.wastePile;
        self.stockPile = [[[self.stockPile reverseObjectEnumerator] allObjects] mutableCopy];
        self.wastePile = nil;
    }
    
    return card;
}


//check if selected cards match and updates the model arrays
- (BOOL)chooseCardAtIndex:(NSInteger)keyAndIndex{
    BOOL cardMatched = NO;
    //check in tableau for matching
    if (!self.selectedCard) {
        if (keyAndIndex == 100) {
            self.selectedCard = [self.wastePile lastObject];
            updateWaste = YES;
        }else{
            selectedRow = keyAndIndex % 10; //is 3
            selectedCardColumn = (keyAndIndex - selectedRow)/10; //is 53-3=50 /10 =5
            NSMutableArray *selectedCards = [self.theTableau objectForKey:[NSNumber numberWithInteger:selectedCardColumn]];
            if ([selectedCards count]) {
                self.selectedCard = [selectedCards objectAtIndex:selectedRow];
            }
        }
    }else{
        //get a reference to the PlayingCard as selected to
        NSInteger row = keyAndIndex % 10; //is 3
        NSInteger column= (keyAndIndex - row)/10; //is 53-3=50 /10 =5
        NSMutableArray *matchedCards = [self.theTableau objectForKey:[NSNumber numberWithInteger:column]];
        //used if moving card to foundation
        if ([self canBeMovedToFoundation:column]) {
            //remove selected card from column
            //update waist option
            //update model
            if (updateWaste) {  //for waste
                [self.wastePile removeLastObject];
                updateWaste = NO;
            }else{
            NSMutableArray *selectedCards = [self.theTableau objectForKey:[NSNumber numberWithInteger:selectedCardColumn]];
            [selectedCards removeLastObject];
            [self.theTableau setObject:selectedCards forKey:[NSNumber numberWithInteger:selectedCardColumn]];
            }
            cardMatched = YES;
        }else{
            if (![matchedCards count] && self.selectedCard.rank == 13) {
                cardMatched = YES;
            }else{
                self.matchedCard = [matchedCards objectAtIndex:row];
                cardMatched = [self checkIfCardMatches];
            }
            NSMutableArray *rangeOfCards = [[NSMutableArray alloc]init];
            if (cardMatched) {
                //update model
                if (updateWaste) {  //for waste
                    [self.wastePile removeLastObject];
                    updateWaste = NO;
                }else{ //for column
                    //removed selected card from column
                    NSMutableArray *selectedCards = [self.theTableau objectForKey:[NSNumber numberWithInteger:selectedCardColumn]];

                    if ([selectedCards lastObject] == self.selectedCard) {
                        //remove last object
                        NSLog(@"LAST OBJECT");
                        [selectedCards removeLastObject];
                        
                    }else{
                        //moving multiple cards in a tableau column
                        NSRange range;
                        range.location = selectedRow;
                        range.length = [selectedCards count]-selectedRow;
                        [rangeOfCards addObjectsFromArray:[selectedCards subarrayWithRange:range]];
                        [selectedCards removeObjectsInRange:range];
                        NSLog(@"RANGE of OBJECTS");

                    }
                    [self.theTableau setObject:selectedCards forKey:[NSNumber numberWithInteger:selectedCardColumn]];
                }
                
                //add selected card to matched column
                if ([rangeOfCards count]) {
                    [matchedCards addObjectsFromArray:rangeOfCards];
                }else{
                [matchedCards addObject:self.selectedCard];
                }
                [self.theTableau setObject:matchedCards forKey:[NSNumber numberWithInteger:column]];
                // [self updateGameModel];
                
            }
            
        }
        self.selectedCard = nil;
        self.matchedCard = nil;
        
    }
    
    return cardMatched;
}


- (PlayingCard *)cardAtIndex:(NSInteger)index{
    PlayingCard *card = [[PlayingCard alloc]init];
    if (index == 100) {
        card = [self.wastePile lastObject];
    }
    NSInteger row = index % 10; //is 3
    NSInteger column= (index - row)/10; //is 53-3=50 /10 =5
    if (index < 100){
        NSMutableArray *cards = [self.theTableau objectForKey:[NSNumber numberWithInteger:column]];
        if ([cards count] > row) { //
            card = [cards objectAtIndex:row];
        }else{
            card = nil;
        }
    }else if(column >= 500 && column < 600){
        card = [self.foundationA lastObject];
    }else if(column >= 600 && column < 700){
        card = [self.foundationB lastObject];
    }else if(column >= 700 && column < 800){
        card = [self.foundationC lastObject];
    }else if(column >= 800 && column < 900){
        card = [self.foundationD lastObject];
    }
        return card;
}

-(BOOL)checkIfCardMatches{
    BOOL cardMatched = NO;
    if (self.selectedCard.rank + 1 == self.matchedCard.rank) {
        if (([self.selectedCard.suit isEqualToString:@"♥️"] || [self.selectedCard.suit isEqualToString:@"♦️"])
            && ([self.matchedCard.suit isEqualToString:@"♠️" ] || [self.matchedCard.suit isEqualToString:@"♣️"])) {
            NSLog(@"matched");
            cardMatched = YES;
            
        }
        if (([self.selectedCard.suit isEqualToString:@"♠️"] || [self.selectedCard.suit isEqualToString:@"♣️"])
            && ([self.matchedCard.suit isEqualToString:@"♥️" ] || [self.matchedCard.suit isEqualToString:@"♦️"])) {
            NSLog(@"matched");
            cardMatched = YES;

        }

    }
    return cardMatched;
}

-(BOOL)canBeMovedToFoundation:(NSInteger)index{
    BOOL cardMatched = NO;
    if (index >= 500 && index < 600) {
        NSLog(@"A");
        if (![self.foundationA count] && self.selectedCard.rank == 1){
            [self.foundationA addObject:self.selectedCard];
            //remove selected card from tableau
            cardMatched = YES;
        }else if ([self.foundationA lastObject]){
            PlayingCard *card = [self.foundationA lastObject];
            if (card.suit == self.selectedCard.suit && card.rank + 1 == self.selectedCard.rank) {
                [self.foundationA addObject:self.selectedCard];
                cardMatched = YES;
            }
        }
    }
    if (index == 600 && index < 700) {
        NSLog(@"B");
        if (![self.foundationB count] && self.selectedCard.rank == 1){
            [self.foundationB addObject:self.selectedCard];
            //remove selected card from tableau
            
            cardMatched = YES;
        }else if ([self.foundationB lastObject]){
            PlayingCard *card = [self.foundationB lastObject];
            if (card.suit == self.selectedCard.suit && card.rank + 1 == self.selectedCard.rank) {
                [self.foundationB addObject:self.selectedCard];
                cardMatched = YES;
            }
        }
    }
    if (index == 700 && index < 800) {
        NSLog(@"C");
        if (![self.foundationC count] && self.selectedCard.rank == 1){
            [self.foundationC addObject:self.selectedCard];
            //remove selected card from tableau
            
            cardMatched = YES;
        }else if ([self.foundationC lastObject]){
            PlayingCard *card = [self.foundationC lastObject];
            if (card.suit == self.selectedCard.suit && card.rank + 1 == self.selectedCard.rank) {
                [self.foundationC addObject:self.selectedCard];
                cardMatched = YES;
            }
        }
        
    }
    if (index == 800 && index < 900) {
        NSLog(@"D");
        if (![self.foundationD count] && self.selectedCard.rank == 1){
            [self.foundationD addObject:self.selectedCard];
            //remove selected card from tableau
            
            cardMatched = YES;
        }else if ([self.foundationD lastObject]){
            PlayingCard *card = [self.foundationD lastObject];
            if (card.suit == self.selectedCard.suit && card.rank + 1 == self.selectedCard.rank) {
                [self.foundationD addObject:self.selectedCard];
                cardMatched = YES;
            }
        }
    }
    return cardMatched;
}









@end
