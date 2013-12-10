//
//  MapViewController.m
//  iEventing
//
//  Created by Apple on 13-11-14.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import "MapViewController.h"
#import "MapItemAnnotation.h"
#import <AddressBookUI/AddressBookUI.h>
#import "SBJson.h"
#import <CoreLocation/CoreLocation.h>
#import "MapAnnotationViewController.h"

@interface NSURLRequest (DummyInterface)
+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString*)host;
+ (void)setAllowsAnyHTTPSCertificate:(BOOL)allow forHost:(NSString*)host;
@end

@interface MapViewController ()<MKMapViewDelegate>
@property (strong, nonatomic) CLGeocoder *geocoger;

@end

@implementation MapViewController
@synthesize mapView;
@synthesize currentLocation;
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
    NSLog(@"111111");
    obj=[MapData getInstance];
    anotherObj=[MapDataClass getInstance];
	// Do any additional setup after loading the view.
    [self.view addSubview:mapView];
    [mapView setShowsUserLocation:YES];
    self.mapView.delegate=self;
    locationManager=[[CLLocationManager alloc]init];
    locationManager.delegate=self;
    if(CLLocationManager.locationServicesEnabled) {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;//设定为最佳精度
        locationManager.distanceFilter = 100.0f;//响应位置变化的最小距离(m)
        [locationManager startUpdatingLocation];
    }
    [locationManager startUpdatingLocation];
    self.geocoger=[[CLGeocoder alloc]init];
    self.navigationItem.rightBarButtonItem=[[MKUserTrackingBarButtonItem alloc]initWithMapView:self.mapView];
    self.mapView.userTrackingMode=MKUserTrackingModeFollow;
    
    

}

-(void)viewDidAppear:(BOOL)animated {
    _mapType=anotherObj.str;
    if ([_mapType isEqualToString:@"1"]) {
        self.mapView.mapType=MKMapTypeSatellite;
    }
    if (anotherObj.judge) {
        AudioServicesPlaySystemSound(0x450);
    }
    NSString *post =[[NSString alloc] initWithFormat:@"getallevents"];
    NSLog(@"PostData: %@",post);
    
    NSURL *url=[NSURL URLWithString:@"http://fangzhou.net63.net/viewevent.php"];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *response = nil;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSLog(@"Response code: %d", [response statusCode]);
    if ([response statusCode] >=200 && [response statusCode] <300)
    {
        NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
        
        NSRange range=[responseData rangeOfString:@"%%%"];
        if(range.location<9999)
            responseData=[responseData substringToIndex:range.location];
        
        NSLog(@"Response ==> %@", responseData);
        NSMutableArray *newAnnotations = [NSMutableArray array];
     while ([responseData rangeOfString:@"&&&"].location!=NSNotFound) {
            NSRange rangett=[responseData rangeOfString:@"&&&"];
            NSString *str1 = [responseData substringToIndex:rangett.location];
        NSLog(@"111 %@",str1);
        
            SBJsonParser *jsonParser = [SBJsonParser new];
            NSDictionary *jsonData = (NSDictionary *) [jsonParser objectWithString:str1 error:nil];
            NSLog(@"%@",jsonData);
            NSString *content1 =  [jsonData objectForKey:@"context"];
            NSString *latitude1 =  [jsonData objectForKey:@"latitude"];
            NSString *longtitude1 =  [jsonData objectForKey:@"longtitude"];
            NSString *score=[jsonData objectForKey:@"score"];
            CLLocationCoordinate2D location;
            location.latitude = [latitude1 doubleValue];
            location.longitude = [longtitude1 doubleValue];
            MKPointAnnotation *newAnnotation;
            newAnnotation = [[MKPointAnnotation alloc] init];
            newAnnotation.title = content1;
            newAnnotation.subtitle=score;
            newAnnotation.coordinate = location;
         
            NSLog(@"%@",content1);
           [newAnnotations addObject:newAnnotation];
            responseData=[responseData substringFromIndex:(rangett.location+3)];
          NSLog(@"----------%@",responseData);
        }
        [self.mapView addAnnotations:newAnnotations];
        
    }
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"didFailwithError: %@",error);
//    UIAlertView *errorAlert = [[UIAlertView alloc]
//                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [errorAlert show];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    currentLocation=newLocation;
}

-(IBAction)addAnnotation:(id)sender{
    MapItemAnnotation *annotation=[[MapItemAnnotation alloc]init];
    annotation.coordinate=currentLocation.coordinate;
    annotation.title=@"Event";
    [self.mapView addAnnotation:annotation];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:currentLocation.coordinate.latitude longitude:currentLocation.coordinate.longitude];
    [self.geocoger reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if ((placemarks) && (!error))
        {
            CLPlacemark *placemark = [placemarks lastObject];
            annotation.subtitle = ABCreateStringWithAddressDictionary(placemark.addressDictionary, NO);
        }
    }];
    
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if ([annotation isKindOfClass:[MapItemAnnotation class]]) {
        static NSString *annotationIdentifier=@"newAnnotation";
        MKPinAnnotationView *annotationView=(MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
        if (!annotationView) {
            annotationView=[[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:annotationIdentifier];
            annotationView.canShowCallout=YES;
            annotationView.enabled=YES;
        }else{
            annotationView.annotation=annotation;
        }
        MapItemAnnotation *mapAnnotation=(MapItemAnnotation *)annotation;
        annotationView.pinColor=mapAnnotation.isFetched?MKPinAnnotationColorGreen:MKPinAnnotationColorRed;
        annotationView.rightCalloutAccessoryView=mapAnnotation.isFetched?[UIButton buttonWithType:UIButtonTypeDetailDisclosure]:[UIButton buttonWithType:UIButtonTypeContactAdd];
        annotationView.centerOffset=CGPointMake(annotationView.centerOffset.x+annotationView.image.size.width/2, annotationView.centerOffset.y- annotationView.image.size.height/2);
        annotationView.animatesDrop = !mapAnnotation.isFetched;
        
        return  annotationView;
        
    }
    else if([annotation isKindOfClass:[MKPointAnnotation class]]){
        static NSString *annotationIdentifier=@"oldAnnotation";
        MKPinAnnotationView *annotationView=(MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
        if (!annotationView) {
            annotationView=[[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:annotationIdentifier];
            annotationView.canShowCallout=YES;
            annotationView.enabled=YES;
        }else{
            annotationView.annotation=annotation;
            NSLog(@"2222");
        }
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"flag50_50.png"]];
        annotationView.calloutOffset = CGPointMake(-7, 7);
        annotationView.pinColor=MKPinAnnotationColorGreen;
        [annotationView addSubview:imageView];
        NSLog(@"11111");
        return annotationView;
    }else{
        return nil;
    }
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    if ([view.annotation isKindOfClass:[MapItemAnnotation class]]) {
        MapItemAnnotation *annotation=(MapItemAnnotation *)view.annotation;
        if (annotation.isFetched) {
            ;
        }else{
            obj.userCllocation=currentLocation;
            NSLog(@"%f",currentLocation.coordinate.longitude);
            [self showFormSheet:self];
        }
    }else{
        
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showMenu
{
    [self.frostedViewController presentMenuViewController];
}

- (IBAction)showFormSheet:(id)sender
{
    [self performSegueWithIdentifier:@"11" sender:self];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"11"]) {
        MapAnnotationViewController *eventViewController;
        eventViewController=segue.destinationViewController;
    }
    
}


- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}


@end
