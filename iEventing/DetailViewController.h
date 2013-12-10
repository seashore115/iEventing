//
//  DetailViewController.h
//  iEventing
//
//  Created by Apple on 13-11-14.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MapItemAnnotation.h"

@interface DetailViewController : UIViewController<MKAnnotation,CLLocationManagerDelegate,MKMapViewDelegate>{
    CLGeocoder *geocoder;
    NSArray *placemarksArray;
}

@property (strong, nonatomic) IBOutlet MKMapView *mapViewForAnnotation;
@property (strong, nonatomic) IBOutlet UITextView *textViewForAddress;
@property (strong,nonatomic)NSArray *placemarksArray;
@property(nonatomic)float longtitude;
@property(nonatomic)float latitude;
@end
