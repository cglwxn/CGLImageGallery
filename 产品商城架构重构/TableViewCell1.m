//
//  TableViewCell1.m
//  探索更流畅的tablView和collectionView互嵌套
//
//  Created by Guanglei Cheng on 2019/12/26.
//  Copyright © 2019 Guanglei Cheng. All rights reserved.
//

#import "TableViewCell1.h"
#import "UIViewController+AddNav.h"

@interface TableViewCell1 ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>

@property (nonatomic, strong) NSArray *viewControllsers;
@property (nonatomic, strong) HandlerBlock willHandlerBlock;
@property (nonatomic, strong) HandlerBlock didHandlerBlock;

@property (nonatomic, strong) UIPageViewController *pageVC;
@property (nonatomic, weak) UIViewController *vc;

@end

@implementation TableViewCell1

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CategoryViewController *vc0 = [[CategoryViewController alloc] init];
        vc0.dataSource = @[@"",@"",@"",@"",@"",];
        vc0.view.backgroundColor = [UIColor redColor];
        vc0.customerNavHidden = YES;
        
        CategoryViewController *vc1 = [[CategoryViewController alloc] init];
        vc1.dataSource = @[@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""];
        vc1.view.backgroundColor = [UIColor brownColor];
        vc1.customerNavHidden = YES;
        
        CategoryViewController *vc2 = [[CategoryViewController alloc] init];
        vc2.dataSource = @[@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""];

        vc2.view.backgroundColor = [UIColor greenColor];
        vc2.customerNavHidden = YES;
        
        _viewControllsers = @[vc0,vc1,vc2];
        
        _pageVC = [[UIPageViewController alloc] initWithTransitionStyle:(UIPageViewControllerTransitionStyleScroll) navigationOrientation:(UIPageViewControllerNavigationOrientationHorizontal) options:nil];
        _pageVC.delegate = self;
        _pageVC.dataSource = self;
        [_pageVC setViewControllers:@[vc0] direction:(UIPageViewControllerNavigationDirectionForward) animated:YES completion:^(BOOL finished) {
            
        }];
        [self.contentView addSubview:_pageVC.view];
    }
    return self;
}

- (void)congfigueCellWithWillBlock:(HandlerBlock)willHandlerBlock didBlock:(HandlerBlock)didHandlerBlock withVC:(UIViewController *)vc {
    self.vc = vc;
    for (CategoryViewController *categoryVC in self.viewControllsers) {
        categoryVC.mainVC = vc;
    }
    self.pageVC.view.frame = self.bounds;
    [self.vc addChildViewController:self.pageVC];
    [self.pageVC.view didMoveToSuperview];
    self.willHandlerBlock = willHandlerBlock;
    self.didHandlerBlock = didHandlerBlock;

}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers API_AVAILABLE(ios(6.0)) {
    CategoryViewController *vc = (CategoryViewController *)(pendingViewControllers.firstObject);
    NSInteger idx = [self.viewControllsers indexOfObject:vc];
    self.willHandlerBlock(self.pageVC, idx, vc);
    NSLog(@"%s---%d",__func__,idx);
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    UIViewController *vc = previousViewControllers.firstObject;
    NSInteger idx = ([self.viewControllsers indexOfObject:vc] + 1)%_viewControllsers.count;
    
    CategoryViewController *currVc = (CategoryViewController *)(_viewControllsers[idx]);
    self.didHandlerBlock(self.pageVC, idx, currVc);
    NSLog(@"%s---%d",__func__,idx);
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    if ([self.viewControllsers containsObject:viewController]) {
        NSInteger index = [self.viewControllsers indexOfObject:viewController];
        NSInteger newIndex = (index+1)%_viewControllsers.count;
        UIViewController *newVC = self.viewControllsers[newIndex];
        return newVC;
    }else{
        return nil;
    }
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    if ([self.viewControllsers containsObject:viewController]) {
        NSInteger index = [self.viewControllsers indexOfObject:viewController];
        NSInteger newIndex = (index+1)%_viewControllsers.count;
        UIViewController *newVC = self.viewControllsers[newIndex];
        return newVC;
    }else{
        return nil;
    }
}

@end
