//
//  SPPiece.m
//  SimplePazzle
//
//  Created by 達郎 植田 on 12/06/27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SPPiece.h"
#import "SPTile.h"
#import "MJGameViewController.h"

@implementation SPPiece
@synthesize beforeTile = _beforeTile;
@synthesize appDelegate= _appDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithImage:(UIImage *)image alphaImage:(UIImage*)alphaImage
{
    self = [super init];
    if (self) {
        // Initialization code
        UIGraphicsBeginImageContext(image.size);  
        CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
        [image drawInRect:rect];  
        [alphaImage drawInRect:rect blendMode:kCGBlendModeNormal alpha:1.0];  
        UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();  
        UIGraphicsEndImageContext();  
        self.image = resultingImage;
        
        // あとで元に戻すため、インスタンス変数に格納
        _initImage = image;
        
        // 音声ファイルのパスからNSURLオブジェクトを作成する
        NSURL *urlCorrect = [NSURL fileURLWithPath:
                       [[NSBundle mainBundle] pathForResource:@"a2-042_shine_04_2" ofType:@"wav"]];
        
        // サウンドIDを取得する
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)urlCorrect, &_correctSound);
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

- (void)moveToTile:(SPTile*)tile
{
    // アニメーション開始。制御をプレイヤーから外す。
    [_appDelegate setAllPiecesUserInteractionEnabled:NO];
    if (tile.correctPiece == self) {
        
        // 正しい位置に入れたピースはあとで光る

        // アニメーション
        CGPoint fromPt = self.layer.position;
        CGPoint toPt = tile.layer.position;
        CABasicAnimation* anime = [CABasicAnimation animationWithKeyPath:@"position"];
        anime.delegate = self;
        anime.removedOnCompletion = NO;
        anime.duration = 0.5;
        anime.fromValue = [NSValue valueWithCGPoint:fromPt];
        anime.toValue = [NSValue valueWithCGPoint:toPt];
        CAMediaTimingFunction* tf = [CAMediaTimingFunction
                                     functionWithName:kCAMediaTimingFunctionEaseOut];
        anime.timingFunction = tf;
        [self.layer addAnimation:anime forKey:@"animetePosition"];
        // アニメーションここまで
        
        [self performSelector:@selector(playCorrectSound) withObject:nil afterDelay:0.41];
        
    } else {
        
        // 正しくない場合は光らない
        // アニメーション
        CGPoint fromPt = self.layer.position;
        CGPoint toPt = tile.layer.position;
        CABasicAnimation* anime = [CABasicAnimation animationWithKeyPath:@"position"];
        anime.delegate = self;
        anime.removedOnCompletion = NO;
        anime.duration = 0.5;
        anime.fromValue = [NSValue valueWithCGPoint:fromPt];
        anime.toValue = [NSValue valueWithCGPoint:toPt];
        CAMediaTimingFunction* tf = [CAMediaTimingFunction
                                     functionWithName:kCAMediaTimingFunctionEaseOut];
        anime.timingFunction = tf;
        [self.layer addAnimation:anime forKey:@"animetePositionFinal"];
        // アニメーションここまで
        
        //[self performSelector:@selector(playIncorrectSound) withObject:nil afterDelay:0.5];
    }
    self.frame = tile.frame;
    tile.holdingPiece = self;
    
//    if (tile.correctPiece == self) {
//        NSLog(@"Correct");
//        [self flash];
//    }

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 正解ピースは動かせない
    UITouch* touch = [touches anyObject];
    CGPoint point = [touch locationInView:nil];
    _localPoint = [touch locationInView:self];
    _beforeTile = [_appDelegate tileContainsPoint: point];
    if (self == _beforeTile.correctPiece) {
        [self moveToTile:_beforeTile];
        return;
    }
    
    // アニメーション
    CGPoint fromPt = self.layer.position;
    CGPoint toPt = CGPointMake(
                               point.x - ((_localPoint.x - (self.frame.size.width  / 2)) / 2),
                               point.y - _localPoint.y + (self.frame.size.height / 2)
                               );
    CABasicAnimation* anime = [CABasicAnimation animationWithKeyPath:@"position"];
    anime.duration = 0.2;
    anime.fromValue = [NSValue valueWithCGPoint:fromPt];
    anime.toValue = [NSValue valueWithCGPoint:toPt];
    CAMediaTimingFunction* tf = [CAMediaTimingFunction
                                 functionWithName:kCAMediaTimingFunctionEaseOut];
    anime.timingFunction = tf;
    [self.layer addAnimation:anime forKey:@"animetePosition"];
    // アニメーションここまで
    
    self.frame =  CGRectMake(point.x - ((_localPoint.x + (self.frame.size.width  / 2)) / 2), 
                             (point.y - _localPoint.y),
                             self.frame.size.width, 
                             self.frame.size.height);
    [self.superview bringSubviewToFront:self];
    
    // タッチされたピースは非透明になる
//    self.alpha = 1.0;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    CGPoint point = [touch locationInView:nil];
    _bellowTile = [_appDelegate tileContainsPoint:point];
    if (self == _beforeTile.correctPiece) {
        return;
    }
    
    self.frame =  CGRectMake(point.x - ((_localPoint.x + (self.frame.size.width  / 2)) / 2), 
//                             point.y - ((_localPoint.y + (self.frame.size.height / 2)) / 2),
                             (point.y - _localPoint.y),
                            self.frame.size.width, 
                            self.frame.size.height);

    // すべてのピースを非透明にしてから処理を実行する
    [_appDelegate setAllPiecesAlpha];
    
    // ピース移動中(タッチムーブ)、下のピースは半透明になる。
    if (_bellowTile.holdingPiece == _bellowTile.correctPiece || _bellowTile == _beforeTile) 
    {
        // 例外：下のピースが正解、または移動中のピースが移動元のタイルにいる
    }
    else {
        _bellowTile.holdingPiece.alpha = 0.5;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchEndedOrCanceled:touches];
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchEndedOrCanceled:touches];    
}

- (void) touchEndedOrCanceled:(NSSet *)touches
{
    UITouch* touch = [touches anyObject];
    CGPoint point = [touch locationInView:nil];
    _bellowTile = [_appDelegate tileContainsPoint:point];

    // 正解セルを動かすことはできない
    if (self == _beforeTile.correctPiece) {
        
        // 微動だにしない
        return;
    }
    
    // ピースが自分のタイルから動いていない場合
    if (_bellowTile.holdingPiece == self)
    {
        // タッチされている自分を下のタイルに落とす
        [self moveToTile:_bellowTile];
    }
    // ピースがすでに正解したタイルにいる場合
    else if (_bellowTile.correctPiece == _bellowTile.holdingPiece) 
    {
        // タッチされている自分を移動元のタイルに落とす
        [self moveToTile:_beforeTile];
    }
    // 通常の移動
    else {
        // タッチ下のタイルを動かす準備をする
        // 半透明になっているので非透明に戻す
        // 表示の前後関係は前から２番目
        SPPiece* bellowPiece = _bellowTile.holdingPiece;
        bellowPiece.alpha = 1.0;
        [self.superview bringSubviewToFront:bellowPiece];

        // タッチされている自分を下のタイルに落とす
        // 表示の前後関係は最前列
        [self moveToTile:_bellowTile];
        [self.superview bringSubviewToFront:self];

        // タッチ下のタイルを動かす
        [bellowPiece performSelector:@selector(moveToTile:) withObject:_beforeTile afterDelay:0.2];

        // すべて正解かチェックする
        [_appDelegate performSelector:@selector(checkAllPiecesAreCorrect) withObject:nil afterDelay:0.25];        
    }
}

- (void)flash
{
    // アニメーション
    CABasicAnimation* animeFlash = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animeFlash.duration = 0.7;
    animeFlash.fromValue = [NSNumber numberWithFloat:0.0];
    animeFlash.toValue = [NSNumber numberWithFloat:1.0];
//    CAMediaTimingFunction* tf = [CAMediaTimingFunction
//                                 functionWithName:kCAMediaTimingFunctionEaseOut];
//    animeFlash.timingFunction = tf;
    [self.layer addAnimation:animeFlash forKey:@"animetePosition"];
    // アニメーションここまで
    
    // 正解はエンボス効果を除去する
    self.image = _initImage;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (anim != [self.layer animationForKey:@"animetePositionFinal"]) {
        [self flash];
    }
    
    // アニメーション終了。制御をプレイヤーに戻す。
    [_appDelegate setAllPiecesUserInteractionEnabled:YES];
}

- (void)playCorrectSound
{
    //音声ファイルの再生をおこなう
    AudioServicesPlaySystemSound(_correctSound);
}

// デバッグ用コード
//- (void)logPosition:(UIView*)view withString:(NSString*)string
//{
//    // Debug code
//    CGPoint point = view.layer.position;
//    string = [NSString stringWithFormat:
//              @"%@_x: %f, %@_y: %f", string, point.x, string, point.y];
//    NSLog(string);
//}

@end
