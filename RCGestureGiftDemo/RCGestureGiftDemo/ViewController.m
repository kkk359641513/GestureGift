//
//  ViewController.m
//  RCGestureGiftDemo
//
//  Created by kkk on 2017/8/10.
//  Copyright © 2017年 kkk. All rights reserved.
//

#import "ViewController.h"
#import "RCGestrueGiftView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    RCGestrueGiftView *view = [[RCGestrueGiftView alloc]initWithFrame:CGRectMake(10, 10, 300, 500)];
    view.giftImgName = @"heart.jpeg";
//    view.imgSize = CGSizeMake(10, 10);
//    view.imgDistance = 10;
    [self.view addSubview:view];

      //  [self.view addSubview:[[SmoothLineView alloc] initWithFrame:self.view.bounds]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
