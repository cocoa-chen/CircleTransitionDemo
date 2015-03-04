//
//  ViewController.m
//  CircleTransitionDemo
//
//  Created by 陈爱彬 on 15/3/4.
//  Copyright (c) 2015年 陈爱彬. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor purpleColor];
    [self setupCircleMenuButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UI视图创建
- (void)setupCircleMenuButton
{
    self.circleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _circleButton.frame = CGRectMake(20, 40, 50, 50);
    _circleButton.backgroundColor = [UIColor blackColor];
    _circleButton.layer.cornerRadius = 25;
    _circleButton.layer.masksToBounds = YES;
    [_circleButton addTarget:self action:@selector(onCircleButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_circleButton];
}
#pragma mark - 按钮响应
- (void)onCircleButtonTapped
{
    SecondViewController *secondVc = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:secondVc animated:YES];
}

@end
