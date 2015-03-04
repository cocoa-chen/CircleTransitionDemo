//
//  CircleTransitionAnimator.h
//  CircleTransitionDemo
//
//  Created by 陈爱彬 on 15/3/4.
//  Copyright (c) 2015年 陈爱彬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TransitionType) {
    TransitionTypePush,
    TransitionTypePop,
};

@interface CircleTransitionAnimator : NSObject
<UIViewControllerAnimatedTransitioning>

@property (nonatomic) TransitionType transitionType;

@end
