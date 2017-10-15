//
//  ViewController.m
//  SKToolsDemo
//
//  Created by Sakya on 17/6/8.
//  Copyright © 2017年 Sakya. All rights reserved.
//

#import "ViewController.h"
#import "SKKit.h"

@interface ViewController (){
        UISlider *_slider1;
    UIImageView *_fuzzyImageView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(20, 64, 200, 50)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.size = CGSizeMake(100, 1);
    layer.bottom = 3;
    [backView.layer addSublayer:layer];
    
    _fuzzyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 70, 300, 200)];
    [self.view addSubview:_fuzzyImageView];
    UIImage *image = [UIImage imageNamed:@"desktop.png"];
   UIImage *blurImage = [image sk_imageByBlurRadius:20 tintColor:[UIColor purpleColor] tintMode:0 saturation:1 maskImage:nil];
    _fuzzyImageView.image = blurImage;
    
    _slider1 = [UISlider new];
    _slider1.frame = CGRectMake(10, 400, 200, 3);
    _slider1.minimumValue = 0;
    _slider1.maximumValue = 20;
    _slider1.value = 0;
    [self.view addSubview:_slider1];
    __weak typeof(self) _self = self;
    [_slider1 sk_addBlockForControlEvents:UIControlEventValueChanged block:^(id sender) {
        [_self changed];
    }];
    NSString *password = @"123456";
    NSString *securityPwd = [password sk_aes256_encrypt:@"sk"];
    NSLog(@"%@",securityPwd);
    NSString *oldPwd = [securityPwd sk_aes256_decrypt:@"sk"];
    NSLog(@"%@",oldPwd);
    
}
- (void)changed {
    UIImage *image = [UIImage imageNamed:@"desktop.png"];
    UIImage *blurImage = [image sk_imageByBlurRadius:_slider1.value tintColor:nil tintMode:0 saturation:1 maskImage:nil];
    _fuzzyImageView.image = blurImage;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
