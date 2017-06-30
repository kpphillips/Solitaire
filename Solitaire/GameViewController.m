
//
//  GameViewController.m
//  HI-LO
//
//  Created by KEVIN PHILLIPS on 10/10/15.
//  Copyright © 2015 KP Phillips. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

//@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *cardCollection;
//@property (weak, nonatomic) IBOutlet UILabel *cardDrawnLabel;
@property (strong, nonatomic) Deck *deck;
@property (nonatomic, strong) CardGameSolitaire *game;
@property (nonatomic, strong) UIFocusGuide *focusGuide;
@property (nonatomic, strong) CardView *stockView;
@property (nonatomic, strong) CardView *wasteView;
@property (nonatomic, strong) UILabel *wasteViewLabel;

@property (nonatomic, strong) CardView *foundationAView;
@property (nonatomic, strong) UILabel *foundationALabel;
@property (nonatomic, strong) CardView *foundationBView;
@property (nonatomic, strong) UILabel *foundationBLabel;
@property (nonatomic, strong) CardView *foundationCView;
@property (nonatomic, strong) UILabel *foundationCLabel;
@property (nonatomic, strong) CardView *foundationDView;
@property (nonatomic, strong) UILabel *foundationDLabel;

@property (nonatomic, strong) CardView *selectedView;

@property (nonatomic, strong) UITapGestureRecognizer *tableauGestureRecognizer;



@end

static BOOL gameStarted = NO;

static  CGSize cardSize = {135,210};
static  CGPoint stockOrigin = {1689,72};

static CGPoint column1Origin = {407,72};

static CGPoint foundationAOrigin = {96,72};
static CGPoint foundationBOrigin = {96,314};
static CGPoint foundationCOrigin = {96,556};
static CGPoint foundationDOrigin = {96,798};

static CGPoint wasteOrigin = {1689,314};



@implementation GameViewController

- (Deck *)deck{
    if (!_deck) {
        _deck = [[PlayingCardDeck alloc]init];
    }
    return _deck;
}

-(CardGameSolitaire *)game{
    if (!_game) _game = [[CardGameSolitaire alloc]initWithDeck:self.deck];
    //gameStarted = YES;
    return _game;
}


-(UIFocusGuide*)focusGuide{
    if (!_focusGuide) _focusGuide = [[UIFocusGuide alloc]init];
    return _focusGuide;
}


-(void)viewDidLayoutSubviews{
    
    
}

-(void)viewDidDisappear:(BOOL)animated{
    
    gameStarted = NO;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //add deck
    CGRect stockViewSize = CGRectMake(stockOrigin.x, stockOrigin.y, cardSize.width, cardSize.height);
    self.stockView = [[CardView alloc]initWithFrame:stockViewSize];
    self.stockView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.stockView];
    UITapGestureRecognizer *stockTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(stockSingleTapGesture:)];
    [self.stockView addGestureRecognizer:stockTapGestureRecognizer];
    
    
    CGRect labelFrame = CGRectMake(8, 8, cardSize.width - 16, 36);

    //add dealed cards
    CGRect wasteViewSize = CGRectMake(wasteOrigin.x, wasteOrigin.y, cardSize.width, cardSize.height);
    self.wasteView = [[CardView alloc]initWithFrame:wasteViewSize];
    self.wasteView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.wasteView];
    //place a label and get teh text for it
    self.wasteViewLabel = [[UILabel alloc]initWithFrame:labelFrame];
    [self.wasteViewLabel setFont:[UIFont systemFontOfSize:36]];
    [self.wasteView addSubview:self.wasteViewLabel];
    self.wasteView.tag = 100;
    UITapGestureRecognizer *wasteTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wasteSingleTapGesture:)];
    [self.wasteView addGestureRecognizer:wasteTapGestureRecognizer];
    
    //Ace decks

    CGRect foundationAViewSize = CGRectMake(foundationAOrigin.x, foundationAOrigin.y, cardSize.width, cardSize.height);
    self.foundationAView = [[CardView alloc]initWithFrame:foundationAViewSize];
    self.foundationAView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.foundationAView];
    self.foundationAView.tag = 5000;
    UITapGestureRecognizer *foundationATapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(foundationSingleTapGesture:)];
    [self.foundationAView addGestureRecognizer:foundationATapGestureRecognizer];

    
    CGRect foundationBViewSize = CGRectMake(foundationBOrigin.x, foundationBOrigin.y, cardSize.width, cardSize.height);
    self.foundationBView = [[CardView alloc]initWithFrame:foundationBViewSize];
    self.foundationBView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.foundationBView];
    self.foundationBView.tag = 6000;
    UITapGestureRecognizer *foundationBTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(foundationSingleTapGesture:)];
    [self.foundationBView addGestureRecognizer:foundationBTapGestureRecognizer];
    
    CGRect foundationCViewSize = CGRectMake(foundationCOrigin.x, foundationCOrigin.y, cardSize.width, cardSize.height);
    self.foundationCView = [[CardView alloc]initWithFrame:foundationCViewSize];
    self.foundationCView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.foundationCView];
    self.foundationCView.tag = 7000;
    UITapGestureRecognizer *foundationCTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(foundationSingleTapGesture:)];
    [self.foundationCView addGestureRecognizer:foundationCTapGestureRecognizer];


    CGRect foundationDViewSize = CGRectMake(foundationDOrigin.x, foundationDOrigin.y, cardSize.width, cardSize.height);
    self.foundationDView = [[CardView alloc]initWithFrame:foundationDViewSize];
    self.foundationDView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.foundationDView];
    self.foundationDView.tag = 8000;
    UITapGestureRecognizer *foundationDTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(foundationSingleTapGesture:)];
    [self.foundationDView addGestureRecognizer:foundationDTapGestureRecognizer];

    /*
     Create a focus guide to fill the gap below card Deck  and to the right
     of column 7.
     */
        //UIFocusGuide *focusGuide = [[UIFocusGuide alloc]init];
    [self.view addLayoutGuide:self.focusGuide];
    
    // Anchor the top left of the focus guide.
//    [self.focusGuide.leftAnchor constraintEqualToAnchor:stockView.leftAnchor].active = YES;
//    [self.focusGuide.topAnchor constraintEqualToAnchor:wasteView.topAnchor].active = YES;
//
//    
//    // Anchor the width and height of the focus guide.
//    [self.focusGuide.widthAnchor constraintEqualToAnchor:stockView.widthAnchor].active = YES;
//    [self.focusGuide.heightAnchor constraintEqualToAnchor:stockView.heightAnchor].active = YES;
    
}


-(void)dealCards{
    
    CGRect stockViewSize = CGRectMake(stockOrigin.x, stockOrigin.y, cardSize.width, cardSize.height);
    CGFloat duration = 0.5;
    CGRect labelFrame = CGRectMake(8, 8, cardSize.width - 16, 36);
    
    //deals cards one column at a time in the 7 columns
    for (NSNumber *key in self.game.theTableau) {
        NSArray *columnArray = [self.game.theTableau objectForKey:key];
        CGFloat xLocation = (column1Origin.x + ([key floatValue] * 150)-125);
        CGFloat yLocation = column1Origin.y;
        NSInteger foundationViewTag = [key integerValue] * 10;
        
        //grab each card for each column
        for (PlayingCard *card in columnArray) {
            //add to screen
            CGRect rect = CGRectMake(xLocation, yLocation, cardSize.width, cardSize.height);
            CardView *cardView = [[CardView alloc]initWithFrame:stockViewSize];
            cardView.backgroundColor = [UIColor blueColor];
            [self.view addSubview:cardView];
            //show the front of the card
            if (card == [columnArray lastObject]) {
                cardView.backgroundColor = [UIColor whiteColor];
                //place a label and get teh text for it
                UILabel *label = [[UILabel alloc]initWithFrame:labelFrame];
                [label setFont:[UIFont systemFontOfSize:36]];
                [cardView addSubview:label];
                label.text = card.contents;
                
                UITapGestureRecognizer *tableauGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableauTapGesture:)];
                [cardView addGestureRecognizer:tableauGestureRecognizer];
                
            }
            
            //animate the deal
            [cardView moveTo:rect.origin duration:duration option:UIViewAnimationOptionCurveEaseIn]; //animate card in place
            yLocation += 50; //distance for each card row
            //tag the cards
            cardView.tag = foundationViewTag; //tag the view for reference later
            foundationViewTag ++; //increment for the array #
            
        }
        
    }
    
    gameStarted = YES;
    
}

#pragma mark - UIGestures


-(void)stockSingleTapGesture:(UITapGestureRecognizer *)tapGestureRecognizer{
    NSLog(@"stockTapGesture");
    NSLog(@"View Tag: %ld", tapGestureRecognizer.view.tag);

    //set card title
    //Card *card = [self.deck drawRandomCard];
    if (!gameStarted) {
        //self.game = [[CardGameSolitaire alloc]initWithDeck:self.deck];
        [self dealCards];
    }else{
    
        PlayingCard *card = [self.game drawFromStock];
        if (card) {
            self.wasteViewLabel.text = card.contents;
            self.wasteView.backgroundColor = [UIColor whiteColor];
        }else{
            self.wasteViewLabel.text = card.contents;
            self.wasteView.backgroundColor = [UIColor clearColor];

        }
        
    }
    
}


-(void)tableauTapGesture:(UITapGestureRecognizer *)tapGestureRecognizer{
    NSLog(@"tableau Gesture");
    NSLog(@"View Tag: %ld", tapGestureRecognizer.view.tag);
    
    BOOL cardmatched = [self.game chooseCardAtIndex:tapGestureRecognizer.view.tag];
    //update UI after match
    if (!self.selectedView) {
        //get view with a specific tag
        if ([self.game cardAtIndex:tapGestureRecognizer.view.tag]) {
            self.selectedView = (CardView *)[self.view viewWithTag:tapGestureRecognizer.view.tag];
            tapGestureRecognizer.view.backgroundColor = [UIColor greenColor]; //show selected
        }
        
    }else if (self.selectedView && cardmatched){
        //if moving from waste to tableau
        if (self.selectedView.tag == 100) {
            
            [self updateWaste:tapGestureRecognizer];
        //if moving from tableau to tableau
        }else{
            
            //TODO: Create a method for this
            CardView *cardUnder = (CardView *)[self.view viewWithTag:self.selectedView.tag - 1];
            cardUnder.backgroundColor = [UIColor whiteColor];
            //create uiview if column is empty
            if (!cardUnder) {
                NSLog(@"Empty Column");
                CardView *card = [[CardView alloc]initWithFrame:self.selectedView.frame];
                card.backgroundColor = [UIColor clearColor];
                card.tag = self.selectedView.tag;
                [self.view addSubview:card];
                UITapGestureRecognizer *tableau2GestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableauTapGesture:)];
                [card addGestureRecognizer:tableau2GestureRecognizer];
            }else{
            //place a label and get teh text for it
            CGRect labelFrame = CGRectMake(8, 8, cardSize.width - 16, 36);
            UILabel *label = [[UILabel alloc]initWithFrame:labelFrame];
            [label setFont:[UIFont systemFontOfSize:36]];
            [cardUnder addSubview:label];
            label.text = [self.game cardAtIndex:self.selectedView.tag - 1].contents;
            
            }

            UITapGestureRecognizer *tableauGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableauTapGesture:)];
            [cardUnder addGestureRecognizer:tableauGestureRecognizer];
            
            
            NSInteger tag = tapGestureRecognizer.view.tag + 1;
            CGRect rect = tapGestureRecognizer.view.frame;
            //TODO: check if moving a king and remove clearview and move selected
    
            //If moving a King (13) to an empty column
            BOOL hasLabel = NO;
            for (id view in tapGestureRecognizer.view.subviews) {
                if ([view isKindOfClass:[UILabel class]]) {
                    hasLabel = YES;
                }
            }
            
            if (!hasLabel) {
                tag = tapGestureRecognizer.view.tag;
                //remove taged card
                rect.origin.y = rect.origin.y - 50;
                [tapGestureRecognizer.view removeFromSuperview];
            }
            
            for (NSInteger i = self.selectedView.tag; i < 100; i++) {
                CardView *cardToMove = (CardView *)[self.view viewWithTag:i];
                if (cardToMove) {
                    rect.origin.y = rect.origin.y + 50;
                    cardToMove.tag = tag; //adding a count to new column
                    cardToMove.layer.zPosition = (tag % 10);
                    [cardToMove moveTo:rect.origin duration:0.5 option:UIViewAnimationOptionCurveEaseIn]; //animate card in place
                    cardToMove.backgroundColor = [UIColor whiteColor];
                    tag ++;
                }else{
                    i = 100;
                }
                
            }
            
            
            self.selectedView = nil;
            [self.view setNeedsDisplay];

        }
        
        
    }else if (!cardmatched){
        //tapGestureRecognizer.view.backgroundColor = [UIColor whiteColor];
        self.selectedView.backgroundColor = [UIColor whiteColor];
        self.selectedView = nil;
        
    }
    
}



-(void)wasteSingleTapGesture:(UITapGestureRecognizer *)tapGestureRecognizer{
    NSLog(@"Waste Gesture");
    NSLog(@"View Tag: %ld", tapGestureRecognizer.view.tag);

    if ([self.game.wastePile count]) {
        BOOL cardmatched = [self.game chooseCardAtIndex:tapGestureRecognizer.view.tag]; //dont need really
        if (!self.selectedView && !cardmatched) {
            //get view with a specific tag
            self.selectedView = (CardView *)[self.view viewWithTag:tapGestureRecognizer.view.tag];
            tapGestureRecognizer.view.backgroundColor = [UIColor greenColor]; //show selected
            
        }
        
    }
}



-(void)foundationSingleTapGesture:(UITapGestureRecognizer *)tapGestureRecognizer{
    NSLog(@"Foundation Gesture");
    NSLog(@"View Tag: %ld", tapGestureRecognizer.view.tag);

    if (self.selectedView) {
        BOOL cardmatched = [self.game chooseCardAtIndex:tapGestureRecognizer.view.tag];
        //update the UI
        if (cardmatched) {
            //if moving from waste to foundation
            if (self.selectedView.tag == 100) {
                [self updateWaste:tapGestureRecognizer];
                //if moving from tableau to foundation
            }else{
                
                //TODO: Create a method for this
                CardView *cardUnder = (CardView *)[self.view viewWithTag:self.selectedView.tag - 1];
                cardUnder.backgroundColor = [UIColor whiteColor];
                //handle create uiview if column is empty
                if (!cardUnder) {
                    NSLog(@"Empty Column");

                    
                    CardView *card = [[CardView alloc]initWithFrame:self.selectedView.frame];
                    card.backgroundColor = [UIColor clearColor];
                    card.tag = self.selectedView.tag;
                    [self.view addSubview:card];
                    UITapGestureRecognizer *tableau2GestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableauTapGesture:)];
                    [card addGestureRecognizer:tableau2GestureRecognizer];
                }else{
                //place a label and get teh text for it
                CGRect labelFrame = CGRectMake(8, 8, cardSize.width - 16, 36);
                UILabel *label = [[UILabel alloc]initWithFrame:labelFrame];
                [label setFont:[UIFont systemFontOfSize:36]];
                [cardUnder addSubview:label];
                label.text = [self.game cardAtIndex:self.selectedView.tag - 1].contents;
                }
                
                UITapGestureRecognizer *tableauGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableauTapGesture:)];
                [cardUnder addGestureRecognizer:tableauGestureRecognizer];
                
                //handle the selected card to be moved to the foundation
                CGRect rect = tapGestureRecognizer.view.frame;
                rect.origin.y = rect.origin.y;
                self.selectedView.tag = tapGestureRecognizer.view.tag + 1;
                self.selectedView.layer.zPosition = self.selectedView.tag + 1;
                [self.selectedView moveTo:rect.origin duration:0.5 option:UIViewAnimationOptionCurveEaseIn]; //animate card in place
                self.selectedView.backgroundColor = [UIColor whiteColor];
                [self.selectedView removeGestureRecognizer:tapGestureRecognizer];
                
                UITapGestureRecognizer *foundationATapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(foundationSingleTapGesture:)];
                [self.selectedView addGestureRecognizer:foundationATapGestureRecognizer];
                
                //[self.selectedView preferredFocusedView]; //set the top view as focusable
                [self.selectedView preferredFocusEnvironments];

                [self.view bringSubviewToFront:self.selectedView];
                
                self.selectedView = nil;
                [self.view setNeedsDisplay];
            }
            
        }
    
    }
    
}

#pragma mark - UI Updates

-(void)updateWaste:(UIGestureRecognizer*)tapGestureRecognizer{
    //***Waste Stack
    //create a new card view for stack
    CGRect origin = CGRectMake(self.selectedView.frame.origin.x, self.selectedView.frame.origin.y, cardSize.width, cardSize.height);
    CardView *cardView = [[CardView alloc]initWithFrame:origin];
    cardView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:cardView];
    //place a label and get teh text for it
    CGRect labelFrame = CGRectMake(8, 8, cardSize.width - 16, 36);
    UILabel *label = [[UILabel alloc]initWithFrame:labelFrame];
    [label setFont:[UIFont systemFontOfSize:36]];
    [cardView addSubview:label];
    label.text = [self.game cardAtIndex:tapGestureRecognizer.view.tag + 1].contents;
    
    CGRect rect = tapGestureRecognizer.view.frame;
    rect.origin.y = rect.origin.y + 50;
    //if a foundation stack
    if (tapGestureRecognizer.view.tag >= 5000) {
        rect.origin.y = rect.origin.y - 50;
    }
    
    cardView.layer.zPosition = (tapGestureRecognizer.view.tag % 10) + 1;
    cardView.tag = tapGestureRecognizer.view.tag + 1;
    
    //if the matched card has does not have a label, modify selecte movement
    //mocing a King i nthis case
    BOOL hasLabel = NO;
    for (id view in tapGestureRecognizer.view.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            hasLabel = YES;
        }
    }
    
    if (!hasLabel && tapGestureRecognizer.view.tag <=  100) {
        cardView.tag = tapGestureRecognizer.view.tag;
        rect.origin.y = rect.origin.y - 50;
        label.text = [self.game cardAtIndex:tapGestureRecognizer.view.tag].contents;
        //remove taged card
        [tapGestureRecognizer.view removeFromSuperview];
    }

    [cardView moveTo:rect.origin duration:0.5 option:UIViewAnimationOptionCurveEaseIn]; //animate card in place
    [cardView removeGestureRecognizer:tapGestureRecognizer];
    
    //handle gesture if moving to tableau or foundation
    if (tapGestureRecognizer.view.tag >= 5000) {
        UITapGestureRecognizer *foundationATapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(foundationSingleTapGesture:)];
        [cardView addGestureRecognizer:foundationATapGestureRecognizer];
        
    }else{
        UITapGestureRecognizer *tableauGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableauTapGesture:)];
        [cardView addGestureRecognizer:tableauGestureRecognizer];
    }
    
    //[cardView preferredFocusedView];  //set the top view as focusable
    [cardView preferredFocusEnvironments];
    [self.view bringSubviewToFront:cardView];

    self.selectedView = nil;
    [self updateWasteUI];

}

-(void)updateWasteUI{
    //update waste view pile
    //add dealed cards
    if (![self.game.wastePile count]) {
        self.wasteView.backgroundColor = [UIColor clearColor];
    }else{
        self.wasteView.backgroundColor = [UIColor whiteColor];
    }
    self.wasteView.tag = 100;
    PlayingCard *card = [self.game.wastePile lastObject];
    self.wasteViewLabel.text = card.contents;
    
}


#pragma mark - Focus


-(void)didUpdateFocusInContext:(UIFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator{
    
    [super didUpdateFocusInContext:context withAnimationCoordinator:coordinator];
    
    
    if (context.nextFocusedView) {
        //handle focus appearance changes
        context.nextFocusedView.backgroundColor = [UIColor redColor];
        //context.previouslyFocusedView.backgroundColor = [UIColor whiteColor];
        
        
        if (context.previouslyFocusedView.backgroundColor == [UIColor greenColor]) {
            context.previouslyFocusedView.backgroundColor = [UIColor greenColor];
        }else{
            context.previouslyFocusedView.backgroundColor = [UIColor whiteColor];
        }
        
        if ((context.previouslyFocusedView == self.wasteView) & ![self.game.wastePile count]) {
            context.previouslyFocusedView.backgroundColor = [UIColor clearColor];
            
        }
        if ((context.previouslyFocusedView == self.foundationAView) & ![self.game.foundationA count]) {
            context.previouslyFocusedView.backgroundColor = [UIColor clearColor];
            
        }
        if ((context.previouslyFocusedView == self.foundationBView) & ![self.game.foundationB count]) {
            context.previouslyFocusedView.backgroundColor = [UIColor clearColor];
            
        }
        if ((context.previouslyFocusedView == self.foundationCView) & ![self.game.foundationC count]) {
            context.previouslyFocusedView.backgroundColor = [UIColor clearColor];
            
        }
        if ((context.previouslyFocusedView == self.foundationDView) & ![self.game.foundationD count]) {
            context.previouslyFocusedView.backgroundColor = [UIColor clearColor];
            
        }
        if ((context.previouslyFocusedView == self.selectedView)) {
            context.previouslyFocusedView.backgroundColor = [UIColor greenColor];
            
        }
        if (![context.previouslyFocusedView.subviews count]) {
            context.previouslyFocusedView.backgroundColor = [UIColor clearColor];
            
        }
        if ((context.previouslyFocusedView == self.stockView)) {
            context.previouslyFocusedView.backgroundColor = [UIColor greenColor];
            
        }
        
        
    }
    else {
        //handle unfocus appearance changes
        //context.nextFocusedView.backgroundColor = [UIColor whiteColor];
        
    }
    
}

#pragma mark - Memory


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
