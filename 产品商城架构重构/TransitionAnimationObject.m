//
//  TransitionAnimationObject.m
//  探索更流畅的tablView和collectionView互嵌套
//
//  Created by Guanglei Cheng on 2020/1/19.
//  Copyright © 2020 Guanglei Cheng. All rights reserved.
//

#import "TransitionAnimationObject.h"

@implementation TransitionAnimationObject

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = transitionContext.containerView;
    UIView *fromeView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIViewController *fromeVC = [transitionContext viewControllerForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect initFromeViewRect = [transitionContext initialFrameForViewController:fromeVC];
    
    CGRect initToViewRect = [transitionContext initialFrameForViewController:toVC];
    
    CGRect finialFromVCRect = [transitionContext finalFrameForViewController:fromeVC];
    CGRect finialToVCRect = [transitionContext finalFrameForViewController:toVC];
    
    NSLog(@"\ninitFromeViewRect:%@\ninitToViewRect:%@\nfinialFromVCRect:%@\nfinialToVCRect%@\n",NSStringFromCGRect(initFromeViewRect),NSStringFromCGRect(initToViewRect),NSStringFromCGRect(finialFromVCRect),NSStringFromCGRect(finialToVCRect));
    return 0.35;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = transitionContext.containerView;
    UIView *fromeView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIViewController *fromeVC = [transitionContext viewControllerForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect initFromeViewRect = [transitionContext initialFrameForViewController:fromeVC];
    
    CGRect initToViewRect = [transitionContext initialFrameForViewController:toVC];
    
    CGRect finialFromVCRect = [transitionContext finalFrameForViewController:fromeVC];
    CGRect finialToVCRect = [transitionContext finalFrameForViewController:toVC];
    
    
    UIView *maskView = [[UIView alloc] initWithFrame:containerView.bounds];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0;
    [containerView addSubview:maskView];
    [containerView addSubview:toView];
//    [fromeView removeFromSuperview];
    
    CGFloat width = containerView.frame.size.width;
    CGFloat height = containerView.frame.size.height;
    toView.frame = CGRectMake(width, 0, width, height);
    
    [UIView animateWithDuration:0.35 animations:^{
        toView.transform = CGAffineTransformMakeTranslation(-width, 0);
        fromeView.transform = CGAffineTransformMakeTranslation(-width/2, 0);
        maskView.alpha = 0.3;
    } completion:^(BOOL finished) {
        [maskView removeFromSuperview];
        fromeView.transform = CGAffineTransformIdentity;

        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        
        if ([transitionContext transitionWasCancelled]) {
            fromeView.hidden = NO;
        }
    }];
    NSLog(@"\ninitFromeViewRect:%@\ninitToViewRect:%@\nfinialFromVCRect:%@\nfinialToVCRect%@\n",NSStringFromCGRect(initFromeViewRect),NSStringFromCGRect(initToViewRect),NSStringFromCGRect(finialFromVCRect),NSStringFromCGRect(finialToVCRect));
    
    
}

@end
