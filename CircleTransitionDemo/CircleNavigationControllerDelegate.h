//
//  CircleNavigationControllerDelegate.h
//  CircleTransitionDemo
//
//  Created by 陈爱彬 on 15/3/4.
//  Copyright (c) 2015年 陈爱彬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleNavigationControllerDelegate : NSObject
<UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UINavigationController *navigationController;
@end
