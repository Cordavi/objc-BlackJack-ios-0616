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
        [self processPlayerTurn];
        cardCountPlayer ++;
        [self processHouseTurn];
        cardCountHouse ++;
    }
    NSLog(@"\n%@\n", self.player.description);
    NSLog(@"\n%@\n", self.house.description);
}

- (void)dealNewRound {
    while ([self.house.cardsInHand count] < 2 && [self.player.cardsInHand count] < 2) {
        [self dealCardToPlayer];
        if (self.player.busted) {
            break;
        }
        [self dealCardToHouse];
        if (self.house.busted) {
            break;
        }
    }
    [self incrementWinsAndLossesForHouseWins:[self houseWins]];
    //NSLog(@"\n%@\n%@", self.player.description, self.house.description);
}

- (void)dealCardToPlayer {
    [self.player acceptCard:[self.deck drawNextCard]];
    
}

- (void)dealCardToHouse {
    [self.house acceptCard:[self.deck drawNextCard]];
    
}

- (void)processPlayerTurn {
    if (self.player.shouldHit && !(self.player.stayed) && !(self.player.busted)) {
        [self dealCardToPlayer];
    }
}

- (void)processHouseTurn {
    if (self.house.shouldHit && !(self.house.stayed) && !(self.house.busted)) {
        [self dealCardToHouse];
    }
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
