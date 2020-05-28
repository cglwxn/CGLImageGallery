//
//  ViewController1.m
//  探索更流畅的tablView和collectionView互嵌套
//
//  Created by Guanglei Cheng on 2020/1/2.
//  Copyright © 2020 Guanglei Cheng. All rights reserved.
//

#import "ViewController1.h"

@interface ViewController1 ()<UIGestureRecognizerDelegate>

@end

@implementation ViewController1

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    // Do any additional setup after loading the view.
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
//    [self popGesture];
    
    

//    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    UIView *nav = [[UIView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 44)];
//    nav.backgroundColor = [UIColor lightGrayColor];
//
//    UIImage *img = [UIImage imageNamed:@"BackImg"];
//    CGSize imgSize = img.size;
//    UIImageView *backImgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, CGRectGetMidY(nav.frame)-imgSize.height/2, imgSize.width, imgSize.height)];
//    [nav addSubview:backImgView];

    
     
    UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.bounds.size.height)];
    subView.backgroundColor = [UIColor magentaColor];
    [self.view addSubview:subView];
    
    NSLog(@"%s",__func__);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%s",__func__);
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%s",__func__);

//    UIEdgeInsets originEdgeInsets = UIEdgeInsetsMake(44, 0, 0, 0);
//    self.additionalSafeAreaInsets = originEdgeInsets;
    
    NSLog(@"vc1:safeAreaInsets:%@---additionalSafeAreaInsets:%@",NSStringFromUIEdgeInsets(self.view.safeAreaInsets),NSStringFromUIEdgeInsets(self.additionalSafeAreaInsets));

}
//- (void)popGesture {
//    id target = self.navigationController.interactivePopGestureRecognizer.delegate;
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(popBack:)];
//    pan.delegate = self;
//    [self.view addGestureRecognizer:pan];
//}
//
//- (void)popBack:(UIPanGestureRecognizer *)pan {
//    [self.navigationController popViewControllerAnimated:YES];
//}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return YES;
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
