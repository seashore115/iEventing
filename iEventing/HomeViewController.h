//
//  HomeViewController.h
//  iEventing
//
//  Created by Apple on 13-11-14.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "REFrostedViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface HomeViewController : UIViewController
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)showMenu;
@end
