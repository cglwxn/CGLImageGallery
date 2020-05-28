//
//  UIViewController+AddNav.m
//  SouFuniPad
//
//  Created by 邱 育良 on 16/3/16.
//  Copyright © 2016年 www.fang.com. All rights reserved.
//

#import "UIViewController+AddNav.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "CustomerView.h"
#import "CustomNav.h"

static int customerHidden;

@implementation UIViewController (AddNav)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
//        swizzMethod(class, @selector(viewWillAppear:), @selector(fang_viewWillAppear:));
//        swizzMethod(class, @selector(viewDidAppear:), @selector(fang_viewDidAppear:));
        
//        swizzMethod(class, @selector(loadView), @selector(cus_loadView));
        
//        swizzMethod(class, @selector(viewSafeAreaInsetsDidChange), @selector(cus_viewSafeAreaInsetsDidChange));
    });
}

//- (void)initialize {
//    self.edgesForExtendedLayout = UIRectEdgeAll;
//}

static void swizzMethod(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)setCustomerNavHidden:(BOOL)customerNavHidden {
    objc_setAssociatedObject(self, &customerHidden, [NSNumber numberWithBool:customerNavHidden], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (customerNavHidden == YES) {
        UIView *nav = [self.view viewWithTag:10010];
        [nav removeFromSuperview];
    }
}

- (BOOL)customerNavHidden {
    return objc_getAssociatedObject(self, &customerHidden);
}

#pragma mark - Method Swizzling

- (void)fang_viewWillAppear:(BOOL)animated {
    [self fang_viewWillAppear:animated];
//    NSLog(@"viewWillAppear:%@", self);
}

- (void)fang_viewDidAppear:(BOOL)animated {
    [self fang_viewDidAppear:animated];
//    NSLog(@"[viewDidAppear]:%@", self);
    
    BOOL exclude = YES;
    for (NSString *classString in [self excludeArray]) {
        if ([self isKindOfClass:NSClassFromString(classString)]) {
            exclude = NO;
            break;
        }
    }
    if (exclude) {
        NSLog(@"[搜房帮]:%@", [self class]);
    }
    
    
}

- (void)cus_loadView {
    [self cus_loadView];
    self.view = [[CustomerView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view.backgroundColor = [UIColor whiteColor];

    CustomNav *nav = [[CustomNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 88)];
    nav.backgroundColor = [UIColor lightGrayColor];
    
    UIImage *img = [UIImage imageNamed:@"BackImg"];
    CGSize imgSize = img.size;
    UIImageView *backImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 22+CGRectGetMidY(nav.bounds)-imgSize.height/2, imgSize.width, imgSize.height)];
    backImgView.image = img;
    [nav addSubview:backImgView];
    nav.tag = 10010;
    [self.view addSubview:nav];
    
    self.additionalSafeAreaInsets = UIEdgeInsetsMake(44, 0, 0, 0);
}

- (void)cus_viewSafeAreaInsetsDidChange {
    [self cus_viewSafeAreaInsetsDidChange];
    for (UIView *subView in self.view.subviews) {
        if (subView != self.view.subviews.lastObject) {
            subView.frame = CGRectMake(subView.frame.origin.x, subView.frame.origin.y+self.view.safeAreaInsets.top, subView.frame.size.width, subView.frame.size.height);
        }
    }
    
    NSLog(@"function:%s-------vc:safeAreaInsets:%@---additionalSafeAreaInsets:%@---",__func__,NSStringFromUIEdgeInsets(self.view.safeAreaInsets),NSStringFromUIEdgeInsets(self.additionalSafeAreaInsets));

}

- (NSArray *)excludeArray {
    
    NSArray *array = @[@"UINavigationController",
                       @"UIAlertController",
                       @"FangPageViewController",
                       @"UIInputWindowController",
                       @"UICompatibilityInputViewController",
                       @"UIPageViewController"];
    return array;
}


@end
