//
//  GYTools.m
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

#import "GYTools.h"

@implementation GYTools

+ (int) bigToHostdata:(NSData *)data index:(int)index
{
//    NSData *intData = [data subdataWithRange:NSMakeRange(index, 4)];
//    int value = CFSwapInt32BigToHost(*(int*)([intData bytes]));

    int value = 0;
    
    for (int i = index; i <= index + 3; i++) {
        
        char *bs = (unsigned char *)[[data subdataWithRange:NSMakeRange(index, 1) ] bytes];

        value += *bs;
    }
    
    return value;
}

+ (int)getBigHost:(Byte[])byte index:(int)index {
    
    return  (((byte[index + 3] & 0xff) <<  24) | ((byte[index + 2] & 0xff) <<  16) | ((byte[index + 1] & 0xff) <<  8) | (byte[index] & 0xff));
    
}

@end
