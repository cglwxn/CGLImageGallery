//
//  CustomNavigationController.m
//  探索更流畅的tablView和collectionView互嵌套
//
//  Created by Guanglei Cheng on 2020/1/3.
//  Copyright © 2020 Guanglei Cheng. All rights reserved.
//

#import "CustomNavigationController.h"
#import "TransitionAnimationObject.h"
#import "InteractiveTransitioningObject.h"

@interface CustomNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) TransitionAnimationObject *transitionAnimationObject;
@property (nonatomic, strong) InteractiveTransitioningObject *interactiveTransitioningObject;


@end

@implementation CustomNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarHidden:NO];
//    [self.navigationBar setTranslucent:NO];
    [self setupEdgeGesture];
    self.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

//- (UIEdgeInsets)additionalSafeAreaInsets {
//    return UIEdgeInsetsMake(44, 0, 0, 0);
//}

- (void)setupEdgeGesture {
    WS(ws)
    self.delegate = ws;
    
    id target = self.interactivePopGestureRecognizer.delegate;
    self.interactivePopGestureRecognizer.enabled = NO;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    id transitioningNumber = [self valueForKey:@"_isTransitioning"];
    BOOL transitioning = [transitioningNumber boolValue];
    if (transitioning == YES) {
        return NO;
    }
    return self.viewControllers.count > 1;
}

//交互式动画
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
//    return self.interactiveTransitioningObject;
    return nil;
}

//定时动画管理器
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
//    return self.transitionAnimationObject;
    return nil;
}

- (TransitionAnimationObject *)transitionAnimationObject {
    if (!_transitionAnimationObject) {
        _transitionAnimationObject = [[TransitionAnimationObject alloc] init];
    }
    return _transitionAnimationObject;
}

- (InteractiveTransitioningObject *)interactiveTransitioningObject {
    if (!_transitionAnimationObject) {
        _transitionAnimationObject = [[InteractiveTransitioningObject alloc] init];
    }
    return _transitionAnimationObject;
}

@end
