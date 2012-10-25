//
//  MJSelectViewController.h
//  MomosJourney
//
//  Created by 達郎 植田 on 12/07/01.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface MJSelectViewController : UIViewController<MFMailComposeViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)playGame:(id)sender;
- (IBAction) doSendEmail:(id) sender;

@end
