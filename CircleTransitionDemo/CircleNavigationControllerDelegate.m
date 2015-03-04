//
//  CircleNavigationControllerDelegate.m
//  CircleTransitionDemo
//
//  Created by 陈爱彬 on 15/3/4.
//  Copyright (c) 2015年 陈爱彬. All rights reserved.
//

#import "CircleNavigationControllerDelegate.h"
#import "CircleTransitionAnimator.h"

@interface CircleNavigationControllerDelegate()
{
    CircleTransitionAnimator *_animator;
    UIPanGestureRecognizer *_panGesture;
}
@property (nonatomic,strong) UIPercentDrivenInteractiveTransition *interactiveTransition;

@end

@implementation CircleNavigationControllerDelegate

- (void)awakeFromNib
{
    [super awakeFromNib];
    //设置手势
    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panned:)];
    [self.navigationController.view addGestureRecognizer:_panGesture];
}
#pragma mark - 手势
- (void)panned:(UIPanGestureRecognizer *)gesture
{
//    if (!self.navigationController || self.navigationController.viewControllers.count <= 1) {
//        return;
//    }
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.interactiveTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
            if (self.navigationController && self.navigationController.viewControllers.count > 1) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGPoint translation = [gesture translationInView:self.navigationController.view];
            CGFloat progress = translation.x / CGRectGetWidth(self.navigationController.view.bounds);
            [self.interactiveTransition updateInteractiveTransition:progress];
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            if ([gesture velocityInView:self.navigationController.view].x > 0) {
                [self.interactiveTransition finishInteractiveTransition];
            }else{
                [self.interactiveTransition cancelInteractiveTransition];
            }
            self.interactiveTransition = nil;
        }
            break;
        default:
        {
            [self.interactiveTransition cancelInteractiveTransition];
            self.interactiveTransition = nil;
        }
            break;
    }
}

#pragma mark - UINavigationControllerDelegate
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (!_animator) {
        _animator = [[CircleTransitionAnimator alloc] init];
    }
    switch (operation) {
        case UINavigationControllerOperationPush:
            _animator.transitionType = TransitionTypePush;
            return _animator;
            break;
        case UINavigationControllerOperationPop:
            _animator.transitionType = TransitionTypePop;
            return _animator;
            break;
        default:
            return nil;
            break;
    }
}
- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    return self.interactiveTransition;
}
@end
