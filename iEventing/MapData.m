//
//  MapData.m
//  iEventing
//
//  Created by Apple on 13-11-14.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import "MapData.h"

@implementation MapData
@synthesize userCllocation;
static MapData *instance=nil;
+(MapData *)getInstance{
    @synchronized(self){
        if (instance==nil) {
            instance=[MapData new];
        }
    }
    return instance;
}
@end
