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

static Byte findKey[]={0x23, 0x23, 0x24, 0x24, 0x40, 0x40, 0x2a, 0x2a, 0x54, 0x61, 0x70, 0x00};

@implementation GYTools

+ (void)bytesplit2byte:(Byte[])src orc:(Byte[])orc begin:(NSInteger)begin count:(NSInteger)count{
    memset(orc, 0, sizeof(char)*count);
    for (NSInteger i = begin; i < begin+count; i++){
        orc[i-begin] = src[i];
    }
}


+ (void)loadFileWithpath:(NSString *)path
{
    
//    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSFileManager *fm=[NSFileManager defaultManager];
    if (![fm fileExistsAtPath:path])
    {
    }
    
    NSData *fileData = [[NSData alloc] initWithContentsOfFile:path];
//    Byte *firmware = alloca(fileData.length);
//    memset(firmware, 0, fileData.length);
//    memcpy(firmware, [fileData bytes], fileData.length);
//    int Size = [self CheckFirmwareSizeWithbyte:firmware];
    
    NSInputStream *stream = [[NSInputStream alloc] initWithFileAtPath:path];

    
    //绕过第一步 验证
    int Size = (int)fileData.length;
    
    if (Size > 127 * 1024) {
        NSLog(@"文件太大");
    }
    
    if (Size %256 != 0) {
        Size = (Size / 256) * 256 + 256;
    }
    
    Byte* bytes = alloca(Size);
    
    @try {
        memset(bytes, 0xff, Size);
        memcpy(bytes, [fileData bytes], fileData.length);
        
        Boolean ver = false;
        
        for (int i = 0; i < Size - sizeof(findKey); i++) {
            ver = false;
            for (int x = 0;x < sizeof(findKey); x++) {
                
                if (findKey[x] == bytes[i + x]) {
                    ver = true;
                } else {
                    ver = false;
                    break;
                }
                
            }
            
            if (ver) {
                Byte *subBytes = alloca(8);
                
                [self bytesplit2byte:bytes orc:subBytes begin:i = 8 count:8];
                
                NSString *check = [[NSString alloc] initWithBytes:bytes length:8 encoding:NSASCIIStringEncoding];
                NSLog(@"%@",check);
                if (![@"OznerROB" isEqualToString:check]) {
                    NSLog(@"错误的文件");
                }
                break;
            }
        }
        
    } @catch (NSException *exception) {
        NSLog(@"%@",exception);
    } @finally {
//        free(bytes);
        [stream close];
    }
    
}


/**
 RO_BLE_OTA

 @param bytes bytes description
 @return return value description
 */
+ (int)CheckFirmwareSizeWithbyte:(Byte*)bytes {
    
    int size = sizeof(bytes);
    
    for (int i = size - 1; i == 1; i--) {
        if (bytes[i] != 0) {
            return i + 2;
        }
    }
    
    return size;
}

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
