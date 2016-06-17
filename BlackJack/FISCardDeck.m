//
//  FISCardDeck.m
//  OOP-Cards-Model
//
//  Created by Michael Amundsen on 6/15/16.
//  Copyright © 2016 Al Tyus. All rights reserved.
//

#import "FISCardDeck.h"

@implementation FISCardDeck

- (instancetype)init {
    self = [super init];
    if (self) {
        _remainingCards = [@[] mutableCopy];
        _dealtCards = [@[] mutableCopy];
        [self generateCardDeck];
    }
    return self;
}

- (FISCard *)drawNextCard {
    if ([self.remainingCards count] == 0) {
        NSLog(@"The deck is empty");
        return nil;
    }
    [self.dealtCards addObject:[self.remainingCards firstObject]];
    [self.remainingCards removeObject:[self.remainingCards firstObject]];
    return [self.dealtCards lastObject];
}

- (void)resetDeck {
    [self gatherDealtCards];
    [self shuffleRemainingCards];
    
}

- (void)gatherDealtCards {
    for (FISCard *dealtCard in self.dealtCards) {
        [self.remainingCards addObject:dealtCard];
    }
    [self.dealtCards removeAllObjects];
}

- (void)shuffleRemainingCards {
    NSMutableArray *shuffledCards = [self.remainingCards mutableCopy];
    [self.remainingCards removeAllObjects];
    while ([shuffledCards count] > 0) {
        int randomIndex = arc4random_uniform((int)[shuffledCards count]);
        [self.remainingCards addObject:shuffledCards[(NSUInteger)randomIndex]];
        [shuffledCards removeObjectAtIndex:(NSUInteger)randomIndex];
    }
}

- (void)generateCardDeck {
        for (NSString *suit in [FISCard validSuits]) {
        for (NSString *rank in [FISCard validRanks]) {
            FISCard *cardToAdd = [[FISCard alloc] initWithSuit:suit rank:rank];
            [self.remainingCards addObject:cardToAdd];
        }
    }
    
}

- (NSString *)description {
    NSString *cardCount = [NSString stringWithFormat:@"%lu", [self.remainingCards count]];
    NSMutableString *cardDeckDescription = [@"" mutableCopy];
    for (FISCard *cardInDeck in self.remainingCards) {
        [cardDeckDescription appendString:[NSString stringWithFormat:@"%@ ", cardInDeck]];
    }
    return [NSString stringWithFormat:@"count: %@\ncards: %@", cardCount, cardDeckDescription];
}

@end
