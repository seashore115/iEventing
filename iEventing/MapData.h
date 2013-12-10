//
//  MapData.h
//  iEventing
//
//  Created by Apple on 13-11-14.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface MapData : NSObject{
    CLLocation *userCllocation;
    
}
@property(nonatomic,retain)CLLocation *userCllocation;
+(MapData*)getInstance;

@end
