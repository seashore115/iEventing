//
//  SettingViewController.m
//  food－square
//
//  Created by Apple on 13-9-28.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import "SettingViewController.h"


@interface SettingViewController ()

@end

@implementation SettingViewController
@synthesize switchButton;

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
    obj=[MapDataClass getInstance];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    

    
    if ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]==6) {
        if([SLComposeViewController class] != nil)
        {
            //[self setButtonStatus];
        } else {
            UIAlertView *osAlert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Your iOS version is NOT 6, can't run the demo." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [osAlert show];
            NSLog(@"Your iOS version is below iOS6");
            
            self.twitterButton.enabled = NO;
            self.twitterButton.alpha = 0.5f;
            
        }
        
    }

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    slider.value=[obj.str floatValue];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.rowArray.count;
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    return [self.rowArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
}

-(IBAction)switchAction:(id)sender{
   switchButton=(UISwitch *)sender;
    BOOL isButtonOn=[switchButton isOn];
    if (isButtonOn) {
        obj.judge=YES;
    }else{
        obj.judge=NO;
    }
}


//分享到 Twitter
- (IBAction)sendToTwitter:(id)sender {
    int currentver = [[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue];
    //ios5
    if (currentver==5 ) {
        // Set up the built-in twitter composition view controller.
        TWTweetComposeViewController *tweetViewController = [[TWTweetComposeViewController alloc] init];
        // Set the initial tweet text. See the framework for additional properties that can be set.
        [tweetViewController setInitialText:@" twitter"];
        // Create the completion handler block.
        
        
        // Present the tweet composition view controller modally.
        
        //ios6
    }else if (currentver==6) {
        //        if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
        //        {
        slComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [slComposerSheet setInitialText:@"this is Spotted Square "];
        [slComposerSheet addImage:[UIImage imageNamed:@"news.png"]];
        [slComposerSheet addURL:[NSURL URLWithString:@"http://www.twitter.com/"]];
        [self presentViewController:slComposerSheet animated:YES completion:nil];
        //        }
        
        [slComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
            NSLog(@"start completion block");
            NSString *output;
            switch (result) {
                case SLComposeViewControllerResultCancelled:
                    output = @"Action Cancelled";
                    break;
                case SLComposeViewControllerResultDone:
                    output = @"Post Successfull";
                    break;
                default:
                    break;
            }
            if (result != SLComposeViewControllerResultCancelled)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Twitter Message" message:output delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alert show];
            }
        }];
        
        
        
        
        
    }else{//ios5 以下
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://twitter.com"]];
    }
    
}



//分享到facebook
- (IBAction)sendToFacebook:(id)sender {
    if ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=6) {
        //  if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
        //{
        slComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [slComposerSheet setInitialText:@"this is Spotted Square"];
        [slComposerSheet addImage:[UIImage imageNamed:@"news.png"]];
        [slComposerSheet addURL:[NSURL URLWithString:@"http://www.facebook.com/"]];
        [self presentViewController:slComposerSheet animated:YES completion:nil];
        // }
        
        [slComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
            NSLog(@"start completion block");
            NSString *output;
            switch (result) {
                case SLComposeViewControllerResultCancelled:
                    output = @"Action Cancelled";
                    break;
                case SLComposeViewControllerResultDone:
                    output = @"Post Successfull";
                    break;
                default:
                    break;
            }
            if (result != SLComposeViewControllerResultCancelled)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Facebook Message" message:output delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alert show];
            }
        }];
        
    }else{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.facebook.com"]];
    }
}

-(IBAction)sliderChanged:(id)sender{
    slider=(UISlider *)sender;
    _progressAsInt=(int)roundf(slider.value);
    obj.str=[NSString stringWithFormat:@"%d",_progressAsInt ];

    
}

- (IBAction)showMenu
{
    [self.frostedViewController presentMenuViewController];
}


@end
