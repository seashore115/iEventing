//
//  AccountViewController.h
//  iEventing
//
//  Created by Apple on 13-11-14.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"
#import "SignupViewController.h"
@interface AccountViewController : UIViewController
- (IBAction)showMenu;
@property (strong, nonatomic) IBOutlet UITextField *textUsername;
@property (strong, nonatomic) IBOutlet UITextField *textPassword;
- (IBAction)btnLogin:(id)sender;
- (IBAction)btnSignup:(id)sender;

- (IBAction)viewTouchDown:(id)sender;
@end
