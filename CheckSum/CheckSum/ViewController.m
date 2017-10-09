//
//  ViewController.m
//  CheckSum
//
//  Created by macpro on 2017/9/12.
//  Copyright © 2017年 macpro. All rights reserved.
//

#import "ViewController.h"
#import "Helper.h"
#import "GYTools.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"(Ozner RO BLE)R02-Jul-21-2017-121059" ofType:@"bin"];
    
//    int sum = [Helper OTACheckSumWithFileStr:path];
    
//    NSLog(@"%d",sum);
    
    [GYTools loadFileWithpath:path];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
