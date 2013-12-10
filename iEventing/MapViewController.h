//
//  MapViewController.h
//  iEventing
//
//  Created by Apple on 13-11-14.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"
#import <MapKit/MapKit.h>
#import <AddressBookUI/AddressBookUI.h>
#import <CoreLocation/CoreLocation.h>
#import "MapData.h"
#import "MapDataClass.h"
#import <AudioToolbox/AudioToolbox.h>
@interface MapViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>{
       CLLocationManager *locationManager;
       CLLocationCoordinate2D          newLocCoordinate;
        MapData *obj;
    MapDataClass *anotherObj;
}
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)showMenu;
@property(strong,nonatomic)CLLocation *currentLocation;
@property (strong,nonatomic) NSString *mapType;

@end
