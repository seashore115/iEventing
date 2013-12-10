//
//  MapDataClass.m
//  food－square
//
//  Created by Apple on 13-10-20.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import "MapDataClass.h"

@implementation MapDataClass
@synthesize str;
@synthesize judge;
static MapDataClass *instance=nil;
+(MapDataClass *)getInstance{
    @synchronized(self){
        if (instance==nil) {
            instance=[MapDataClass new];
        }
    }
    return instance;
}


@end
