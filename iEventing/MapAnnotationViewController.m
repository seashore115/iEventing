//
//  MapAnnotationViewController.m
//  iEventing
//
//  Created by Apple on 13-11-14.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import "MapAnnotationViewController.h"
#import "SBJson.h"

@interface NSURLRequest (DummyInterface)
+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString*)host;
+ (void)setAllowsAnyHTTPSCertificate:(BOOL)allow forHost:(NSString*)host;
@end

@interface MapAnnotationViewController ()

@end

@implementation MapAnnotationViewController
@synthesize textView;
@synthesize fetchLocation;


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
    anotherObj=[MapData getInstance];
	// Do any additional setup after loading the view.
    TQStarRatingView *starRatingView = [[TQStarRatingView alloc] initWithFrame:CGRectMake(37, 330, 250, 50) numberOfStar:5];
    starRatingView.delegate = self;
    [self.view addSubview:starRatingView];
    fetchLocation=anotherObj.userCllocation;
    NSLog(@"%f",fetchLocation.coordinate.longitude);
}

-(void)starRatingView:(TQStarRatingView *)view score:(float)score
{
   
    self.scoreLabel.text = [NSString stringWithFormat:@"%0.2f",score * 10 ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)viewTouchDown:(id)sender {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    
}



-(IBAction)save:(id)sender{
    if ([[textView text]isEqualToString:@""]||[[self.scoreLabel text]isEqualToString:@""]) {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Warnning" message:@"Please fill in all contents" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alertView show];
    }else{
        NSString *post =[[NSString alloc] initWithFormat:@"context=%@&score=%@&longtitude=%f&latitude=%f",textView.text,self.scoreLabel.text,fetchLocation.coordinate.longitude,fetchLocation.coordinate.latitude];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://fangzhou.net63.net/addevent.php"];
        
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
            NSLog(@"%@",responseData);
            NSRange range=[responseData rangeOfString:@"%%%"];
            if(range.location<9999)
                responseData=[responseData substringToIndex:range.location];
            
            NSLog(@"Response ==> %@", responseData);
            
            SBJsonParser *jsonParser = [SBJsonParser new];
            NSDictionary *jsonData = (NSDictionary *) [jsonParser objectWithString:responseData error:nil];
            NSLog(@"%@",jsonData);
            NSInteger success = [(NSNumber *) [jsonData objectForKey:@"success"] integerValue];
            NSLog(@"%d",success);
            if(success == 1)
            {
                NSLog(@"SUCCESS");
                
            } else {
                
                NSString *error_msg = (NSString *) [jsonData objectForKey:@"error_message"];
                NSLog(@"method is invalid!%@",error_msg);
            }
            
        } else {
            if (error) NSLog(@"Error: %@", error);
            
        }

        
    }
    
}


@end
