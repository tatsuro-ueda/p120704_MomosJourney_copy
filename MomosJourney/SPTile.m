//
//  SPTile.m
//  SimplePazzle
//
//  Created by 達郎 植田 on 12/06/27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SPTile.h"

@implementation SPTile
@synthesize correctPiece;
@synthesize holdingPiece;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

//- (void)drawRect:(CGRect)rect
//{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextFillEllipseInRect(context, 
//                               CGRectMake(self.layer.position.x, self.layer.position.y, 10, 10));
//}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"tile touched");
}

@end
