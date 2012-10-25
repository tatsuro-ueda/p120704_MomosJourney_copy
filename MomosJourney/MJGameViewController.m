//
//  MJGameViewController.m
//  MomosJourney
//
//  Created by 達郎 植田 on 12/07/01.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MJGameViewController.h"
#import "SPTile.h"
#import "SPPiece.h"

@interface MJGameViewController ()

@end

@implementation MJGameViewController
@synthesize nx = _nx;
@synthesize ny = _ny;
@synthesize prefix = _prefix;
@synthesize strNumOfTiles = _strNumOfTiles;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];
//    self.view.backgroundColor = [UIColor blackColor];
    
    NSLog(@"_nx = %d, _ny = %d, _prefix = %@", _nx, _ny, _prefix);
    
    [self prepareGame];
    NSLog(@"prepared");
    [self shufflePieces];
    NSLog(@"shuffled");
    


//    ADBannerView *adView = [[ADBannerView alloc] initWithFrame:CGRectMake(0.0, 430.0, 320.0, 50.0)];
//    adView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
//    [self.view addSubview:adView];



}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
//}

- (void) prepareGame
{
    _allPieces = [NSMutableArray array];
    _allTiles = [NSMutableArray array];
    for (int i = 0; i < _nx; i++) {
        for (int j = 0; j < _ny; j++) {
            
            // pieceを初期化する
            NSString* filename = [NSString stringWithFormat:
                                  @"%@_x%d_y%d.png", _prefix, i, j];
            SPPiece* piece = [[SPPiece alloc] initWithImage:[UIImage imageNamed:filename] 
                                                 alphaImage:[UIImage imageNamed:@"120704-EmbossTile.png"]];
            piece.userInteractionEnabled = YES;
            piece.appDelegate = self;
            piece.multipleTouchEnabled = NO;
            
            // tileを初期化する
            SPTile* tile = [[SPTile alloc] initWithFrame:
                            CGRectMake(i * (320 / _nx), j * (480 / _ny), (320 / _nx), (480 / _ny))];
            tile.correctPiece = piece;                            
            
            // 配列に入れる
            [_allPieces addObject:piece];
            [_allTiles addObject:tile];
            
            // ビューに入れる
            [self.view addSubview:tile];
        }
        
    }
    
    // ピースはタイルのあとからビューに入れる
    for (SPPiece* p in _allPieces) {
        [self.view addSubview:p];
    }
}

- (void) shufflePieces
{
    if ([_strNumOfTiles isEqualToString:@"3x3"]) {

        // 固定ピースを配置する
        int fixArray[6] = {0, 4, 5, 9, 10, 14};

        for (int i = 0; i < (sizeof(fixArray) / sizeof(fixArray[0])); i++) 
        {
            SPPiece* p = [_allPieces objectAtIndex:fixArray[i]];
            [p moveToTile:[_allTiles objectAtIndex:fixArray[i]]];
        }

        // 残りのピースをランダムに配置する
        int shuffleArray[9] = {1, 2, 3, 6, 7, 8, 11, 12, 13};

        for (int i = 0; i < (sizeof(shuffleArray) / sizeof(shuffleArray[0])); i++) {
            int r;
            SPPiece* p = [_allPieces objectAtIndex:shuffleArray[i]];
            do {
                r = arc4random() % (sizeof(shuffleArray) / sizeof(shuffleArray[0]));
            } while ([[_allTiles objectAtIndex:shuffleArray[r]] holdingPiece] != nil);
            [p moveToTile:[_allTiles objectAtIndex:shuffleArray[r]]];
        }
    }
    else {
    
        // すべてのピースをランダムに配置する
        for (NSInteger i = 0; i < (_nx * _ny); i++) {
            int r;
            SPPiece* p = [_allPieces objectAtIndex:i];
            do {
                r = arc4random() % (_nx * _ny);
            } while ([[_allTiles objectAtIndex:r] holdingPiece] != nil);
            [p moveToTile:[_allTiles objectAtIndex:r]];
        }    
    }
}

- (SPTile*) tileContainsPoint:(CGPoint)point
{
    for (int i = 0; i < (_nx * _ny); i++) {
        SPTile* t = [_allTiles objectAtIndex:i];
        if (CGRectContainsPoint(t.frame, point)) // "*"point ???
        {
            return t;
        }
    }
    return nil;
    NSLog(@"error");
}

// 移動が終わるたびにデリゲートが正解かチェックする
- (void) checkAllPiecesAreCorrect
{
    for (SPTile* t in _allTiles) {

        // 1つでも間違っていれば、この処理は終了
        if (t.holdingPiece != t.correctPiece) {
            return;
        }
    }
    
    // 正解時の処理
    [self performSelector:@selector(flashAllPieces) withObject:nil afterDelay:2.0];
    [self performSelector:@selector(showMenu:) withObject:nil afterDelay:5.0];
}

- (void) flashAllPieces
{
    for (SPPiece* p in _allPieces) {
        [p flash];
    }
}

- (void) resetGame
{
    // 配列に入っていたピースとタイルはすべて破棄する
    [_allTiles removeAllObjects];
    [_allPieces removeAllObjects];

    [self prepareGame];
    [self shufflePieces];
    [self setAllPiecesAlpha];
}

// すべてのピースの透明度を設定する
- (void) setAllPiecesAlpha
{
    for (SPPiece* p in _allPieces) {
        p.alpha = 1.0;
    }
}

- (IBAction)showMenu:(id)sender 
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void) setAllPiecesUserInteractionEnabled:(BOOL)enabled
{
    for (SPPiece* p in _allPieces) {
        p.userInteractionEnabled = enabled;
    }
}

@end
