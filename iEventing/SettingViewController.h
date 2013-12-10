//
//  SettingViewController.h
//  food－square
//
//  Created by Apple on 13-9-28.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"
#import <Accounts/Accounts.h>
#import <Twitter/Twitter.h>
#import<Social/Social.h>
#import "MapDataClass.h"


@interface SettingViewController : UITableViewController
<UIPickerViewDataSource,UIPickerViewDelegate>{
    MapDataClass *obj;
    SLComposeViewController *slComposerSheet;
    UISlider *slider;
}
@property (strong, nonatomic) IBOutlet UISwitch *switchButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong, nonatomic) NSArray *rowArray;
-(IBAction)sendToFacebook :(id)sender;
-(IBAction)sendToTwitter :(id)sender;
- (IBAction)showMenu;
-(IBAction)switchAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *facebookBuutton;
@property (strong, nonatomic) IBOutlet UIButton *twitterButton;
@property(nonatomic)int progressAsInt;


@end
