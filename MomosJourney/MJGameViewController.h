//
//  MJGameViewController.h
//  MomosJourney
//
//  Created by 達郎 植田 on 12/07/01.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@class SPTile;
@class SPPiece;

@interface MJGameViewController : UIViewController<UIGestureRecognizerDelegate>
{
    NSMutableArray*     _allPieces;
    NSMutableArray*     _allTiles;
    NSInteger           _nx;
    NSInteger           _ny;
    NSString*           _prefix;
    NSString*           _strNumOfTiles;
}

@property NSInteger nx;
@property NSInteger ny;
@property NSString* prefix;
@property NSString* strNumOfTiles;

- (void) prepareGame;
- (void) shufflePieces;
- (SPTile*) tileContainsPoint:(CGPoint)point;
- (void) checkAllPiecesAreCorrect;
- (void) flashAllPieces;
- (void) resetGame;
- (void) setAllPiecesAlpha;
- (void) setAllPiecesUserInteractionEnabled:(BOOL)enabled;

- (IBAction)showMenu:(id)sender;
@end
