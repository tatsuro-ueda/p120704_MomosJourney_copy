//
//  MJSelectViewController.m
//  MomosJourney
//
//  Created by 達郎 植田 on 12/07/01.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MJSelectViewController.h"
#import "MJGameViewController.h"

@interface MJSelectViewController ()

@end

@implementation MJSelectViewController
@synthesize scrollView;

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
    
    // スクロールビューの高さをのばす
    scrollView.contentSize = CGSizeMake(320, 1900);
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)playGame:(id)sender {
    
    // performSegueのコードはこれだけ
    // prepareSegueで分岐させる
    [self performSegueWithIdentifier:@"beginGame" sender:sender];
}

// 遷移先のGameViewの設定をする
- (void)setGameViewController:(MJGameViewController *)controller 
                           nx:(NSInteger)nx 
                           ny:(NSInteger)ny 
                strNumOfFiles:(NSString *)strNumOfFiles 
                       prefix:(NSString *)prefix
{
    controller.nx = nx;
    controller.ny = ny;
    controller.strNumOfTiles = strNumOfFiles;
    controller.prefix = prefix;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UIButton*)button
{
    MJGameViewController* c = segue.destinationViewController;
    
    if (button.tag == 1) {
        [self setGameViewController:c nx:2 ny:3 strNumOfFiles:nil 
                             prefix:@"120704-Taishakuten2x3"];
    } 
    else if (button.tag == 2) {
        [self setGameViewController:c nx:3 ny:5 strNumOfFiles:@"3x3" 
                             prefix:@"120704-Taishakuten3x5"];
    }
    else if (button.tag == 3) {
        [self setGameViewController:c nx:3 ny:5 strNumOfFiles:nil 
                             prefix:@"120704-Taishakuten3x5"];
    }
    else if (button.tag == 11) {
        [self setGameViewController:c nx:2 ny:3 strNumOfFiles:nil
                             prefix:@"120703-Kokyo2x3"];
    } 
    else if (button.tag == 12) {
        [self setGameViewController:c nx:3 ny:5 strNumOfFiles:@"3x3"
                             prefix:@"120703-Kokyo3x5"];
    }
    else if (button.tag == 13) {
        [self setGameViewController:c nx:3 ny:5 strNumOfFiles:nil
                             prefix:@"120703-Kokyo3x5"];
    }
    else if (button.tag == 21) {
        [self setGameViewController:c nx:2 ny:3 strNumOfFiles:nil
                             prefix:@"120704-GoBusters2x3"];
    } 
    else if (button.tag == 22) {
        [self setGameViewController:c nx:3 ny:5 strNumOfFiles:@"3x3"
                             prefix:@"120704-GoBusters3x5"];
    }
    else if (button.tag == 31) {
        [self setGameViewController:c nx:2 ny:3 strNumOfFiles:nil
                             prefix:@"120704-CureHappy2x3"];
    } 
    else if (button.tag == 32) {
        [self setGameViewController:c nx:3 ny:5 strNumOfFiles:@"3x3" 
                             prefix:@"120704-CureHappy3x5"];
    }
    else if (button.tag == 41) {
        [self setGameViewController:c nx:2 ny:3 strNumOfFiles:nil
                             prefix:@"120707-CureSunny2x3"];
    } 
    else if (button.tag == 42) {
        [self setGameViewController:c nx:3 ny:5 strNumOfFiles:@"3x3"
                             prefix:@"120707-CureSunny3x5"];
    }
    else if (button.tag == 43) {
        [self setGameViewController:c nx:3 ny:5 strNumOfFiles:nil
                             prefix:@"120707-CureSunny3x5"];
    }
    else if (button.tag == 44) {
        [self setGameViewController:c nx:4 ny:6 strNumOfFiles:nil 
                             prefix:@"120707-CureSunny4x6"];
    }
    else if (button.tag == 51) {
        [self setGameViewController:c nx:2 ny:3 strNumOfFiles:nil
                             prefix:@"120707-CurePeace2x3"];
    } 
    else if (button.tag == 52) {
        [self setGameViewController:c nx:3 ny:5 strNumOfFiles:@"3x3"
                             prefix:@"120707-CurePeace3x5"];
    }
    else if (button.tag == 53) {
        [self setGameViewController:c nx:3 ny:5 strNumOfFiles:nil
                             prefix:@"120707-CurePeace3x5"];
    }
    else if (button.tag == 54) {
        [self setGameViewController:c nx:4 ny:6 strNumOfFiles:nil
                             prefix:@"120707-CurePeace4x6"];
    }
    else if (button.tag == 61) {
        [self setGameViewController:c nx:2 ny:3 strNumOfFiles:nil
                             prefix:@"120707-Ohori2x3"];
    } 
    else if (button.tag == 62) {
        [self setGameViewController:c nx:3 ny:5 strNumOfFiles:@"3x3" 
                             prefix:@"120707-Ohori3x5"];
    }
    else if (button.tag == 63) {
        [self setGameViewController:c nx:3 ny:5 strNumOfFiles:nil
                             prefix:@"120707-Ohori3x5"];
    }
    else if (button.tag == 71) {
        [self setGameViewController:c nx:2 ny:3 strNumOfFiles:nil
                             prefix:@"atago1_2x3"];
    } 
    else if (button.tag == 72) {
        [self setGameViewController:c nx:3 ny:5 strNumOfFiles:@"3x3" 
                             prefix:@"atago1_3x5"];
    }
    else if (button.tag == 73) {
        [self setGameViewController:c nx:3 ny:5 strNumOfFiles:nil
                             prefix:@"atago1_3x5"];
    }
    else if (button.tag == 81) {
        [self setGameViewController:c nx:2 ny:3 strNumOfFiles:nil
                             prefix:@"atago2_2x3"];
    } 
    else if (button.tag == 82) {
        [self setGameViewController:c nx:3 ny:5 strNumOfFiles:@"3x3" 
                             prefix:@"atago2_3x5"];
    }
    else if (button.tag == 83) {
        [self setGameViewController:c nx:3 ny:5 strNumOfFiles:nil
                             prefix:@"atago2_3x5"];
    }
    else if (button.tag == 91) {
        [self setGameViewController:c nx:2 ny:3 strNumOfFiles:nil
                             prefix:@"atago3_2x3"];
    } 
    else if (button.tag == 92) {
        [self setGameViewController:c nx:3 ny:5 strNumOfFiles:@"3x3" 
                             prefix:@"atago3_3x5"];
    }
    else if (button.tag == 93) {
        [self setGameViewController:c nx:3 ny:5 strNumOfFiles:nil
                             prefix:@"atago3_3x5"];
    }
}

-(IBAction) doSendEmail:(id) sender {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailViewController = 
            [[MFMailComposeViewController alloc] init];
        mailViewController.mailComposeDelegate = self;
        [mailViewController setSubject:@"メッセージ"];
        [mailViewController setToRecipients:
            [NSArray arrayWithObject:@"ueda_tatsuro@yahoo.co.jp"]];
        [mailViewController setMessageBody:@"以下にメッセージをお願いします" isHTML:NO];        
        [self presentModalViewController:mailViewController animated:YES];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissModalViewControllerAnimated:YES];
}

@end