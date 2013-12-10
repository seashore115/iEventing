//
//  MapAnnotationViewController.h
//  iEventing
//
//  Created by Apple on 13-11-14.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TQStarRatingView.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <MessageUI/MessageUI.h>
#import <CoreLocation/CoreLocation.h>
#import "MapData.h"
@interface MapAnnotationViewController : UIViewController<UIImagePickerControllerDelegate,StarRatingViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>{
    MapData *anotherObj;
}
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UITextView *textView;
- (IBAction)viewTouchDown:(id)sender;
@property(strong,nonatomic)CLLocation *fetchLocation;

@end
