//
//  ViewController.m
//  SKToolsDemo
//
//  Created by Sakya on 17/6/8.
//  Copyright © 2017年 Sakya. All rights reserved.
//

#import "ViewController.h"
#import "SKKitMacro.h"
#import "SKKit.h"
#import "CALayer+SKAdd.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(20, 64, 200, 50)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    NSLog(@"%llu",dispatch_time_delay(3));
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.size = CGSizeMake(100, 1);
    layer.bottom = 3;
    [backView.layer addSublayer:layer];


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
