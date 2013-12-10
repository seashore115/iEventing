//
//  FeedbackViewController.h
//  iEventing
//
//  Created by Apple on 13-11-15.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "REFrostedViewController.h"
@interface FeedbackViewController : UIViewController<MFMailComposeViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UITextView *textView;
- (IBAction)viewTouchDown:(id)sender;
- (IBAction)showMenu;
@end
