//
//  MapDataClass.h
//  food－square
//
//  Created by Apple on 13-10-20.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MapDataClass : NSObject{
    NSString *str;
    BOOL *judge;
}
@property(nonatomic,retain)NSString *str;
@property(nonatomic)BOOL *judge;
+(MapDataClass*)getInstance;
@end
