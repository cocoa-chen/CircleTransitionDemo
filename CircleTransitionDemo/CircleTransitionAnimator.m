//
//  CircleTransitionAnimator.m
//  CircleTransitionDemo
//
//  Created by 陈爱彬 on 15/3/4.
//  Copyright (c) 2015年 陈爱彬. All rights reserved.
//

#import "CircleTransitionAnimator.h"
#import "ViewController.h"
#import "SecondViewController.h"

@interface CircleTransitionAnimator()

@property (nonatomic,weak) id<UIViewControllerContextTransitioning> transitionContext;
@end

@implementation CircleTransitionAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    self.transitionContext = transitionContext;
    
    UIView *containerView = [transitionContext containerView];
    
    if (_transitionType == TransitionTypePush) {
        //Push
        ViewController *fromVc = (ViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        SecondViewController *toVc = (SecondViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        UIButton *button = fromVc.circleButton;
        
        [containerView addSubview:toVc.view];

        UIBezierPath *fromPath = [UIBezierPath bezierPathWithOvalInRect:button.frame];
        CGPoint outterPoint = CGPointMake(CGRectGetWidth(fromVc.view.frame) - button.center.x, CGRectGetHeight(fromVc.view.frame) - button.center.y);
        CGFloat radius = sqrtf((outterPoint.x * outterPoint.x) + (outterPoint.y * outterPoint.y));
        UIBezierPath *toPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(button.frame, -radius, -radius)];
        //将最终的Path赋给maskLayer,避免动画结束之后跳回到最初状态
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.path = toPath.CGPath;
        toVc.view.layer.mask = maskLayer;
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
        animation.fromValue = (__bridge id)(fromPath.CGPath);
        animation.toValue = (__bridge id)(toPath.CGPath);
        animation.duration = [self transitionDuration:self.transitionContext];
        animation.delegate = self;
        [maskLayer addAnimation:animation forKey:@"path"];
    }else if (_transitionType == TransitionTypePop) {
        //Pop
        SecondViewController *fromVc = (SecondViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        ViewController *toVc = (ViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        UIButton *button = fromVc.popButton;
        
        [containerView insertSubview:toVc.view belowSubview:fromVc.view];
        
        UIBezierPath *toPath = [UIBezierPath bezierPathWithOvalInRect:button.frame];
        CGPoint outterPoint = CGPointMake(CGRectGetWidth(fromVc.view.frame) - button.center.x, CGRectGetHeight(fromVc.view.frame) - button.center.y);
        CGFloat radius = sqrtf((outterPoint.x * outterPoint.x) + (outterPoint.y * outterPoint.y));
        UIBezierPath *fromPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(button.frame, -radius, -radius)];
        //将最终的Path赋给maskLayer,避免动画结束之后跳回到最初状态
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.path = toPath.CGPath;
        fromVc.view.layer.mask = maskLayer;
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
        animation.fromValue = (__bridge id)(fromPath.CGPath);
        animation.toValue = (__bridge id)(toPath.CGPath);
        animation.duration = [self transitionDuration:self.transitionContext];
        animation.delegate = self;
        [maskLayer addAnimation:animation forKey:@"path"];
    }
}
#pragma mark - 动画Delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (self.transitionContext) {
        if (_transitionType == TransitionTypePush) {
            UIViewController *toVc = [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
            toVc.view.layer.mask = nil;
        }else if (_transitionType == TransitionTypePop) {
            UIViewController *fromVc = [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
            fromVc.view.layer.mask = nil;
        }
        [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    }
}
@end
