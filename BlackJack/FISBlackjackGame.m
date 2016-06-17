//
//  FISBlackjackGame.m
//  BlackJack
//
//  Created by Michael Amundsen on 6/16/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

#import "FISBlackjackGame.h"

@implementation FISBlackjackGame

- (instancetype)init {
    self = [super init];
    if (self) {
        _deck = [[FISCardDeck alloc] init];
        _house = [[FISBlackjackPlayer alloc] initWithName:@"House"];
        _player = [[FISBlackjackPlayer alloc] initWithName:@"Player"];
    }
    return self;
}

- (void)playBlackjack {
    [self.deck resetDeck];
    [self.player resetForNewGame];
    [self.house resetForNewGame];
    [self dealNewRound];
    NSUInteger cardCountPlayer = [self.player.cardsInHand count];
    NSUInteger cardCountHouse = [self.player.cardsInHand count];
    
    while (cardCountPlayer < 5 && cardCountHouse < 5) {
        if (self.player.busted || self.house.busted) {
            break;
        }
        [self processTurn:self.player];
        cardCountPlayer ++;
        [self processTurn:self.house];
        cardCountHouse ++;
    }
    NSLog(@"\n%@\n", self.player.description);
    NSLog(@"\n%@\n", self.house.description);
}

- (void)dealNewRound {
    while ([self.house.cardsInHand count] < 2 && [self.player.cardsInHand count] < 2) {
        [self dealCard:self.player];
        if (self.player.busted) {
            break;
        }
        [self dealCard:self.player];
        if (self.house.busted) {
            break;
        }
    }
    [self incrementWinsAndLossesForHouseWins:[self houseWins]];
    //NSLog(@"\n%@\n%@", self.player.description, self.house.description);
}

- (void)dealCard:(FISBlackjackPlayer *)player {
    [player acceptCard:[self.deck drawNextCard]];
    //NSLog(@"Hello! It's me!");
}

- (void)processTurn:(FISBlackjackPlayer *)player {
    if (player.shouldHit && !(player.stayed) && !(player.busted)) {
        [self dealCard:player];
    }
    //NSLog(@"Hello! It's me!");
}

- (BOOL)houseWins {
    if (self.player.blackjack && self.house.blackjack) {
        return NO;
    } else if (!(self.player.busted) && self.house.busted) {
        return NO;
    }  else if (self.player.handscore > self.house.handscore) {
        return NO;
    } else if (self.player.busted) {
        return YES;
    } else if (self.house.handscore >= self.player.handscore) {
        return YES;
    }
    return NO;
}

- (void)incrementWinsAndLossesForHouseWins:(BOOL)houseWins {
    if (houseWins) {
        self.house.wins ++;
        self.player.losses ++;
        //NSLog(@"%@", self.house.description);
    } else {
        self.player.wins ++;
        self.house.losses ++;
        //NSLog(@"%@", self.player.description);
    }
}

@end
