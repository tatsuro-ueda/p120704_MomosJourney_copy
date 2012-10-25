//
//  SPTile.h
//  SimplePazzle
//
//  Created by 達郎 植田 on 12/06/27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <QuartzCore/QuartzCore.h>

@class SPPiece;

@interface SPTile : UIView

@property SPPiece* holdingPiece;
@property SPPiece* correctPiece;

@end
