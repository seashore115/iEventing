//
//  SignupViewController.h
//  food－square
//
//  Created by Fangzhou Sun on 10/20/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignupViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *txtUsername;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;

- (IBAction)viewTouchDown:(id)sender;

- (IBAction)btnSignup:(id)sender;
@end
