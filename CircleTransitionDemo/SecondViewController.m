//
//  SecondViewController.m
//  CircleTransitionDemo
//
//  Created by 陈爱彬 on 15/3/4.
//  Copyright (c) 2015年 陈爱彬. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    [self setupPopMenuButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI视图创建
- (void)setupPopMenuButton
{
    self.popButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _popButton.frame = CGRectMake(20, 40, 50, 50);
    _popButton.backgroundColor = [UIColor blackColor];
    _popButton.layer.cornerRadius = 25;
    _popButton.layer.masksToBounds = YES;
    [_popButton addTarget:self action:@selector(onPopButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_popButton];
}
#pragma mark - 按钮响应
- (void)onPopButtonTapped
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
