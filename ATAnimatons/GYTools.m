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


+(int)hexToint:(NSString*)str
{
    int nValude = 0;
    sscanf([[str dataUsingEncoding:NSASCIIStringEncoding] bytes],"%x",&nValude);
    return nValude;
}

+ (void)bytesplit2byte:(Byte[])src orc:(Byte[])orc begin:(NSInteger)begin count:(NSInteger)count{
    memset(orc, 0, sizeof(char)*count);
    for (NSInteger i = begin; i < begin+count; i++){
        orc[i-begin] = src[i];
    }
}


+ (void)loadFileWithpath:(NSString *)path
{
    
//    NSFileManager *fileManager = [NSFileManager defaultManager];
    
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
        memset(bytes, 0x00, Size);
        memcpy(bytes, fileData.bytes, fileData.length);
        
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
        
        int myLoc1 = 0;
        int myLoc2 = 0;
        
        for (int i = 0; i < Size - 6; i++) {
            if ((bytes[i] == 0x12) && (bytes[i + 1] == 0x34) && (bytes[i + 2] == 0x56)
                && (bytes[i + 3] == 0x65) && (bytes[i + 4] == 0x43) && (bytes[i + 5] == 0x21)) {
                if (myLoc1 == 0)
                    myLoc1 = i;
                else
                    myLoc2 = i;
            }
        }
        NSLog(@"%d---%d",myLoc1,myLoc2);
         
        if (myLoc1!=0)
        {
//            bytes[myLoc1 + 5] = (Byte) [self hexToint:[@"123" substringWithRange:NSMakeRange(0, 2)]];
//            bytes[myLoc1 + 4] = (Byte) [self hexToint:[self.mac substringWithRange:NSMakeRange(3, 2)]];
//            bytes[myLoc1 + 3] = (Byte) [self hexToint:[self.mac substringWithRange:NSMakeRange(6, 2)]];
//            bytes[myLoc1 + 2] = (Byte) [self hexToint:[self.mac substringWithRange:NSMakeRange(9, 2)]];
//            bytes[myLoc1 + 1] = (Byte) [self hexToint:[self.mac substringWithRange:NSMakeRange(12, 2)]];
//            bytes[myLoc1] = (Byte) [self hexToint:[self.mac substringWithRange:NSMakeRange(15, 2)]];
        }
        if (myLoc2 != 0) {
            bytes[myLoc2 + 5] = bytes[myLoc1];
            bytes[myLoc2 + 4] = bytes[myLoc1 + 1];
            bytes[myLoc2 + 3] = bytes[myLoc1 + 2];
            bytes[myLoc2 + 2] = bytes[myLoc1 + 3];
            bytes[myLoc2 + 1] = bytes[myLoc1 + 4];
            bytes[myLoc2] = bytes[myLoc1 + 5];
        }

        long temp = 0;
        int checkSum= 0;
        int len = Size / 4;
        for (int i = 0; i < len; i++) {
            temp += [self getBigHost:bytes index:i * 4];
        }
        long TempMask = 0x1FFFFFFFFL-0x100000000L;
        checkSum = (int) (temp & TempMask);
        NSLog(@"%d",(int)checkSum);
        NSLog(@"%d",0xc0 & 0x0ff);
        NSLog(@"%d",checkSum & 0x7fffffff);
        
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
