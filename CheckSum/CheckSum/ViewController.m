//
//  ViewController.m
//  CheckSum
//
//  Created by macpro on 2017/9/12.
//  Copyright © 2017年 macpro. All rights reserved.
//

#import "ViewController.h"
#import "Helper.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"0x57449192" ofType:@"bin"];
    
    int sum = [Helper OTACheckSumWithFileStr:path];
    NSLog(@"%d",sum);
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
