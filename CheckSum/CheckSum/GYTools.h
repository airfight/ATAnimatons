//
//  GYTools.h
//  ATAnimatons
//
//  Created by ZGY on 2017/9/21.
//  Copyright © 2017年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/9/21  上午9:22
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

#import <Foundation/Foundation.h>

@interface GYTools : NSObject
+ (int) bigToHostdata:(NSData *)data index:(int)index;

+ (int)getBigHost:(Byte[])byte index:(int)index;

+ (int)CheckFirmwareSizeWithbyte:(Byte*)bytes;

+ (void)loadFileWithpath:(NSString *)path;
@end
