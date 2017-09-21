//
//  HelpToos.m
//  ATAnimatons
//
//  Created by ZGY on 2017/9/21.
//  Copyright © 2017年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2017/9/21  上午9:19
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

#import "HelpToos.h"

@implementation HelpToos

+ (int) bigToHostdata:(NSData *)data
{
    NSData *intData = [data subdataWithRange:NSMakeRange(2, 4)];
    int value = CFSwapInt32BigToHost(*(int*)([intData bytes]));
    
    return value;
}

@end
