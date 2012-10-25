//
//  SPPiece.h
//  SimplePazzle
//
//  Created by 達郎 植田 on 12/06/27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>

@class SPTile;
@class MJGameViewController;

@interface SPPiece : UIImageView
{
    MJGameViewController*   _appDelegate;
    SPTile*                 _beforeTile;
    SPTile*                 _bellowTile;
    CGPoint                 _localPoint;
    UIImage*                _initImage;
    SystemSoundID           _correctSound;
}

@property SPTile* beforeTile;
@property MJGameViewController* appDelegate;

- (id)initWithImage:(UIImage *)image alphaImage:(UIImage*)alphaImage;
- (void)moveToTile:(SPTile*)tile;
- (void)flash;
//- (void)logPosition:(UIView*)view withString:(NSString*)string;

@end
