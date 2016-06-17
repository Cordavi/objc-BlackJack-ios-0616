//  FISAppDelegate.m

#import "FISAppDelegate.h"
#import "FISBlackjackPlayer.h"
#import "FISCardDeck.h"
#import "FISBlackjackGame.h"

@implementation FISAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //    FISBlackjackPlayer *michael = [[FISBlackjackPlayer alloc] initWithName:@"Michael"];
    //    FISCardDeck *newDeck = [[FISCardDeck alloc] init];
    //    [michael acceptCard:[newDeck drawNextCard]];
    //    [michael acceptCard:[newDeck drawNextCard]];
    //    NSLog(@"%@", michael.description);
    FISBlackjackGame *game = [[FISBlackjackGame alloc] init];
    [game playBlackjack];
    [game playBlackjack];
    [game playBlackjack];
    [game playBlackjack];
    return YES;
}

@end
