//
//  CGLImageGalleryVC.m
//  产品商城架构重构
//
//  Created by Guanglei Cheng on 2020/5/11.
//  Copyright © 2020 Guanglei Cheng. All rights reserved.
//

#import "CGLImageGalleryVC.h"
#import "ViewController.h"
#import "PresentationVC.h"
#import "CGLImageGalleryHorizentalScroll.h"
#import "CGLImageGalleryVeriticalScroll.h"

@interface CGLImageGalleryVC ()<UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning, UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) CGLImageGalleryHorizentalScroll *horizentalScrollView;
//@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percentDrivenInteractiveTransition;
@property (nonatomic, strong) id <UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic, assign) BOOL isTap;

@property (nonatomic, assign) CGRect originFrame;
@property (nonatomic, strong) UIView *originContentView;
@property (nonatomic, assign) BOOL allowPan;

@property (nonatomic, assign) NSInteger idx;
@property (nonatomic, strong) UIScrollView *currentScroll;

@property (nonatomic, strong) PresentationVC *presentationVC;

@end

@implementation CGLImageGalleryVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.horizentalScrollView];
//    [self.view addSubview:self.scrollView];
    self.view.backgroundColor = [UIColor clearColor];
//    self.view.alpha = 0;
    
//    //双击放大缩小
//    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
//    doubleTap.numberOfTapsRequired = 2;
//    [self.view addGestureRecognizer:doubleTap];
//
//
//    //单击dismiss
//    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
//    singleTap.numberOfTapsRequired = 1;
//    [self.view addGestureRecognizer:singleTap];
//
//    [singleTap requireGestureRecognizerToFail:doubleTap];
//
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.view addGestureRecognizer:pan];
}

- (void)singleTap:(UITapGestureRecognizer *)reco {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)doubleTap:(UITapGestureRecognizer *)reco {
    UIScrollView *scroll = (UIScrollView *)(reco.view);
    if (scroll.zoomScale > 1.0) {
        self.currentScroll.contentInset = UIEdgeInsetsMake(0, 0, 0, 0 );

        [scroll setZoomScale:1.0 animated:YES];
//        [scroll zoomToRect:newRect animated:YES];

    }else{
        CGPoint touchPoint = [reco locationInView:self.currentScroll];
        CGFloat scale = scroll.maximumZoomScale;
        CGRect originF = self.imageView.frame;

        CGRect newRect = [self getRectScroll:scroll WithScale:scale andCenter:touchPoint];
        [scroll zoomToRect:newRect animated:YES];
        UIView *contentV = [self.currentScroll viewWithTag:1999];

        if (originF.size.height < SCREEN_HEIGHT && originF.size.height >= SCREEN_HEIGHT/3) {
            self.currentScroll.contentSize = CGSizeMake(contentV.frame.size.width, contentV.frame.size.height-SCREEN_HEIGHT+originF.size.height);
            self.currentScroll.contentInset = UIEdgeInsetsMake(-contentV.frame.origin.y, 0, 0, 0);
        }else if (originF.size.height < SCREEN_HEIGHT/3) {
//            self.currentScroll.contentSize = CGSizeMake(contentV.frame.size.width, contentV.frame.size.height-SCREEN_HEIGHT+originF.size.height);
//            self.currentScroll.contentInset = UIEdgeInsetsMake(-contentV.frame.origin.y, 0, 0, 0);
            
            //contentSize的高度contentV.frame.origin.y+1中的+1是为了,防止放大后,滑动会开始缩小且dismiss.目前效果不好,暂时禁止放大后滑动dismiss
            self.currentScroll.contentSize = CGSizeMake(contentV.frame.size.width, SCREEN_HEIGHT+contentV.frame.origin.y+1);
            self.currentScroll.contentInset = UIEdgeInsetsMake(-contentV.frame.origin.y, 0, 0, 0);
        }
    }
}

/** 计算点击点所在区域frame */
- (CGRect)getRectScroll:(UIScrollView *)scroll WithScale:(CGFloat)scale andCenter:(CGPoint)center{
    //放大缩小的交互逻辑仿照微信的交互
    //1.当图片高度<scroll.height/scale的时候,高度放大到scroll.height高度.
    //2.当图片高度>scroll.height/scale的时候,分区域计算.
    CGRect scaleRect = CGRectZero;
    CGFloat scroW = scroll.bounds.size.width;
    CGFloat scroH = scroll.bounds.size.height;
    CGSize imagSize = self.imageView.image.size;
    CGFloat imgH = SCREEN_WIDTH*imagSize.height/imagSize.width;
    UIView *contentV = [self.currentScroll viewWithTag:1999];
    if (imgH >= scroH/3) {
        CGFloat topY = scroH*2/3-imgH/2;
        CGFloat bottomY = scroH/3+imgH/2;
        if (center.x <= scroW/6 &&center.y <= topY) {
            scaleRect = CGRectMake(0, 0, scroW/3, scroH/3);
        }else if (center.x>scroW/6&&center.x<scroW*5/6&&center.y<=topY){
            scaleRect = CGRectMake(scroW/3, 0, scroW/3, scroH/3);
        }else if (center.x>=5*scroW/6&&center.y<=topY){
            scaleRect = CGRectMake(scroW*2/3, 0, scroW/3, scroH/3);
        }else if(center.x<=scroW/6&&center.y>topY&&center.y<=bottomY){
            scaleRect = CGRectMake(0, center.y-scroH/6-contentV.frame.origin.y, scroW/3, scroH/3);
        }else if (center.x>scroW/6&&center.x<scroW*5/6&&center.y>topY&&center.y<=bottomY){
            scaleRect = CGRectMake(center.x-scroW/6, center.y-scroH/6-contentV.frame.origin.y, scroW/3, scroH/3);
        }else if (center.x>scroW*5/6&&center.y>topY&&center.y<=bottomY){
            scaleRect = CGRectMake(scroW*2/3, center.y-scroH/6-contentV.frame.origin.y, scroW/3, scroH/3);
        }else if (center.x<scroW/6&&center.y>bottomY){
            scaleRect = CGRectMake(0, imgH-scroH/3, scroW/3, scroH/3);
        }else if (center.x>=scroW/6&&center.x<scroW*5/6&&center.y>bottomY){
            scaleRect = CGRectMake(center.x-scroW/6, imgH-scroH/3, scroW/3, scroH/3);
        }else{
            scaleRect = CGRectMake(scroW*2/3, imgH-scroH/3, scroW/6, scroH/3);
        }
    }else if (imgH<scroH/3){
        CGFloat wid =imgH*SCREEN_WIDTH/SCREEN_HEIGHT;
        if (center.x <= wid/2) {
            scaleRect = CGRectMake(0, 0, wid, imgH);
        }else if (center.x>SCREEN_WIDTH - wid/2){
            scaleRect = CGRectMake(SCREEN_WIDTH-wid/2, 0, wid, imgH);
        }else{
            scaleRect = CGRectMake(center.x-wid/2, 0, wid, imgH);
        }
    }
    return scaleRect;
    
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    UIView *contentV = [self.currentScroll viewWithTag:1999];
    NSLog(@"contentOffset:%f contentSize%@>>>contentV%@>>imageView:%@-%@",scrollView.contentOffset.y,NSStringFromCGSize(scrollView.contentSize),NSStringFromCGRect(contentV.frame),NSStringFromCGRect(self.imageView.frame),NSStringFromCGAffineTransform(self.imageView.transform));
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
//    CGPoint originP = *targetContentOffset;
//    originP.x = originP.x + 20;
//    targetContentOffset = &originP;
//    NSLog(@"targetContentOffset--%@",NSStringFromCGPoint(*targetContentOffset));
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    UIView *contentV = [scrollView viewWithTag:1999];
    return contentV;
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    self.isTap = YES;
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)panAction:(UIPanGestureRecognizer *)pan {
    CGPoint point = [pan translationInView:self.view];
    NSLog(@"point>>(%f,%f)",point.x,point.y);
    switch (pan.state) {
        case UIGestureRecognizerStatePossible://0
            break;
        case UIGestureRecognizerStateBegan://1
        {
            self.allowPan = NO;
            CGPoint v = [pan velocityInView:self.view];
            if (v.y>0) {
                //下滑,允许继续滑动处理
                self.allowPan = YES;
                self.view.backgroundColor = [UIColor clearColor];
                for (int i = 0; i < _images.count; i ++) {
                    CGLGalleryModel *mo = _images[i];
                    UIImageView *imgV = mo.imageView;
                    if (i != self.idx) {
                        CGRect originFrame = mo.originFrame;
                        imgV.frame = originFrame;
                        [self.originContentView addSubview:imgV];
                    }
                }
            }
            self.originFrame = self.imageView.frame;
        }
            
            break;
        case UIGestureRecognizerStateChanged://2
            if (self.allowPan) {
//                NSLog(@"pan.state>>%ld>>%@",pan.state,NSStringFromCGRect(self.imageView.frame));
                if (point.y > 0 && point.y < SCREEN_HEIGHT) {
                    NSLog(@"前--imageView>>%@",NSStringFromCGRect(self.imageView.frame));
                    self.imageView.frame = CGRectMake(self.originFrame.origin.x+point.x, self.originFrame.origin.y+point.y, self.originFrame.size.width*(1-(point.y)/SCREEN_HEIGHT), self.originFrame.size.height*(1-(point.y)/SCREEN_HEIGHT));
                    self.presentationVC.dimmingView.alpha = 1-(point.y)/SCREEN_HEIGHT;
//                    self.view.alpha = 1-(point.y)/SCREEN_HEIGHT;
                    
                    NSLog(@"后--imageView>>%@",NSStringFromCGRect(self.imageView.frame));

                }else{
                    self.imageView.frame = CGRectMake(self.originFrame.origin.x+point.x, self.originFrame.origin.y+point.y, self.originFrame.size.width, self.originFrame.size.height);
//                    self.view.backgroundColor = [UIColor blackColor];
                }
            }
           break;
        case UIGestureRecognizerStateEnded://3
//            NSLog(@"pan.state>>%ld>>%@",pan.state,NSStringFromCGRect(self.imageView.frame));
        {
            if (self.allowPan) {
                if (point.y>0) {
                    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
                        
                    }];
                }else{
                    [UIView animateWithDuration:0.3 animations:^{
                        self.imageView.frame = self.originFrame;
//                        self.view.backgroundColor = [UIColor blackColor];
                    }];
                    [self addImageView];
                }
            }
        }
           break;
        case UIGestureRecognizerStateCancelled://4
        {
            [UIView animateWithDuration:0.3 animations:^{
                self.imageView.frame = self.originFrame;
//                self.view.backgroundColor = [UIColor blackColor];
            }];
            [self addImageView];
        }
           break;
        case UIGestureRecognizerStateFailed://5
        {
            [UIView animateWithDuration:0.3 animations:^{
                self.imageView.frame = self.originFrame;
//                self.view.backgroundColor = [UIColor blackColor];
            }];
            [self addImageView];
        }
           break;
            
        default:
            break;
    }
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)addImageView {
    for (int i = 0; i < _images.count; i ++) {
        if (i != self.idx) {
            UIScrollView *scroll = [self.horizentalScrollView viewWithTag:1000+i];
            CGLGalleryModel *mo = _images[i];
            UIImageView *imagV = mo.imageView;
            CGSize imagSize = imagV.image.size;
            CGFloat hei = SCREEN_WIDTH*imagSize.height/imagSize.width;

            UIView *contentV = [scroll viewWithTag:1999];
            
            if (hei>SCREEN_HEIGHT) {
                CGRect orignContentF = contentV.frame;
                orignContentF.origin.y = 0;
                orignContentF.size.height = hei;
                
                NSLog(@"hei>>%f>>frame:%@",hei,NSStringFromCGRect(orignContentF));

                contentV.frame = orignContentF;
                
                imagV.frame = CGRectMake(scroll.center.x-i*SCREEN_WIDTH-SCREEN_WIDTH/2, 0, SCREEN_WIDTH, hei);
                
            }else{
                
                CGRect orignContentF = contentV.frame;
                orignContentF.origin.y = (scroll.frame.size.height-hei)/2;
                orignContentF.size.height = SCREEN_HEIGHT -(scroll.center.y-hei/2);
                
                NSLog(@"hei>>%f>>frame:%@",hei,NSStringFromCGRect(orignContentF));

                contentV.frame = orignContentF;
                
                imagV.frame = CGRectMake(scroll.center.x-i*SCREEN_WIDTH-SCREEN_WIDTH/2, 0, SCREEN_WIDTH, hei);

                
            }
            scroll.contentSize = CGSizeMake(SCREEN_WIDTH, hei);
            [contentV addSubview:imagV];
        }
    }
}

#pragma mark - UIViewControllerTransitioningDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
    return nil;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    return nil;
}

- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source API_AVAILABLE(ios(8.0)) {
    self.presentationVC = [[PresentationVC alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    return self.presentationVC;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    self.transitionContext = transitionContext;
    return 0.2;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    if ([toVC isKindOfClass:[self class]]) {
        //present
        UIView *containerView = [transitionContext containerView];
        UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        UINavigationController *nav = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        ViewController *fromVC = (ViewController *)(nav.topViewController);
        UIImageView *imageView = nil;
        [containerView addSubview:toView];
        
//        [toView addSubview:self.imageView];
        for (int i = 0; i < _images.count; i ++) {
            CGLGalleryModel *mo = _images[i];
            UIImageView *imgV = mo.imageView;
            if (mo.isSelected == YES) {
                imageView = imgV;
                [imageView.superview insertSubview:imageView atIndex:_images.count-1];
                self.originContentView = imageView.superview;
                [self.horizentalScrollView setContentOffset:CGPointMake(i*SCREEN_WIDTH, 0)];
                break;
                
            }
        }
        
        //将imageView添加到新currentScroll上
        //构建imageView的初始frame
        UIView *contentV = [self.currentScroll viewWithTag:1999];
        
        

//        [self.currentScroll addSubview:self.imageView];
        
        //构建imageView的最终frame
        CGSize imagSize = imageView.image.size;
        CGFloat hei = 0;
        hei = SCREEN_WIDTH*imagSize.height/imagSize.width;
        
        if (hei < SCREEN_HEIGHT) {
            CGRect orignContentF = contentV.frame;
            orignContentF.origin.y = self.currentScroll.center.y-hei/2;
            orignContentF.size.height = SCREEN_HEIGHT -(self.currentScroll.center.y-hei/2);
            contentV.frame = orignContentF;
        }else{
            CGRect orignContentF = contentV.frame;
            orignContentF.origin.y = 0;
            orignContentF.size.height = hei;
            contentV.frame = orignContentF;
        }
        
        
        CGRect of = [contentV convertRect:self.imageView.frame fromView:self.originContentView];
        self.imageView.frame = of;
        [contentV addSubview:self.imageView];
//        self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, hei);
        [UIView animateWithDuration:0.3 animations:^{
            CGRect resultFrame = CGRectZero;
            if (hei>SCREEN_HEIGHT) {
                resultFrame = CGRectMake(self.currentScroll.center.x-self.idx*SCREEN_WIDTH-SCREEN_WIDTH/2, 0, SCREEN_WIDTH, hei);
            }else{
//                resultFrame = CGRectMake(self.currentScroll.center.x-self.idx*SCREEN_WIDTH-SCREEN_WIDTH/2, self.currentScroll.center.y-hei/2, SCREEN_WIDTH, hei);
                
                resultFrame = CGRectMake(self.currentScroll.center.x-self.idx*SCREEN_WIDTH-SCREEN_WIDTH/2, 0, SCREEN_WIDTH, hei);

            }
//            CGRect resultF = [window convertRect:resultFrame toView:self.originContentView];
            imageView.frame = resultFrame;
//            toView.alpha = 1;
        } completion:^(BOOL finished) {
//            self.view.alpha = 1;
//            NSLog(@"present完成....");

            for (int i = 0; i < _images.count; i ++) {
                UIScrollView *scroll = [self.horizentalScrollView viewWithTag:1000+i];
                CGLGalleryModel *mo = _images[i];
                UIImageView *imagV = mo.imageView;
                CGSize imagSize = imagV.image.size;
                CGFloat hei = SCREEN_WIDTH*imagSize.height/imagSize.width;

                UIView *contentV = [scroll viewWithTag:1999];
                
                if (hei>SCREEN_HEIGHT) {
                    CGRect orignContentF = contentV.frame;
                    orignContentF.origin.y = 0;
                    orignContentF.size.height = hei;
                    
//                    NSLog(@"hei>>%f>>frame:%@",hei,NSStringFromCGRect(orignContentF));

                    contentV.frame = orignContentF;
                    
                    imagV.frame = CGRectMake(scroll.center.x-i*SCREEN_WIDTH-SCREEN_WIDTH/2, 0, SCREEN_WIDTH, hei);
                    
                }else{
                    
                    CGRect orignContentF = contentV.frame;
                    orignContentF.origin.y = (scroll.frame.size.height-hei)/2;
                    orignContentF.size.height = SCREEN_HEIGHT -(scroll.center.y-hei/2);
                    
//                    NSLog(@"hei>>%f>>frame:%@",hei,NSStringFromCGRect(orignContentF));

                    contentV.frame = orignContentF;
                    
                    imagV.frame = CGRectMake(scroll.center.x-i*SCREEN_WIDTH-SCREEN_WIDTH/2, 0, SCREEN_WIDTH, hei);

                    
                }
                scroll.contentSize = CGSizeMake(SCREEN_WIDTH, hei);
                
                

                
                [contentV addSubview:imagV];

//                [scroll addSubview:imagV];
            }
            
            [transitionContext completeTransition:YES];
        }];
    }else{
        //dismiss
//        NSLog(@">>>>>>>dismiss>>>>>>>>>>");
        //获取当前idx
        CGFloat idx = self.horizentalScrollView.contentOffset.x/SCREEN_WIDTH;
        UIView *containerView = [transitionContext containerView];
        UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        UINavigationController *nav = (UINavigationController *)toVC;
        ViewController *origVC = (ViewController *)(nav.topViewController);
        
        UIImageView *imageView = nil;
        CGRect originF = CGRectZero;
        UIView *contentV = [self.currentScroll viewWithTag:1999];

//        self.view.backgroundColor = [UIColor clearColor];
        
        for (int i = 0; i < _images.count; i ++) {
            CGLGalleryModel *mo = _images[i];
            UIImageView *imgV = mo.imageView;
            if (i == idx) {
                imageView = imgV;
                originF = mo.originFrame;
            }else{
                if (![imgV isDescendantOfView:self.originContentView]) {
                    CGRect originFrame = mo.originFrame;
                    imgV.frame = originFrame;
                    [self.originContentView addSubview:imgV];
                }
            }
        }
//        UIWindow *window = [UIApplication sharedApplication].delegate.window;
//        CGRect resultF = [window convertRect:self.imageView.frame toView:self.originContentView];
//        imageView.frame = resultF;
//        [self.originContentView addSubview:imageView];
        
        [UIView animateWithDuration:0.3 animations:^{
//            NSLog(@">>>>>>>animation>>>>>>>>>>");
            CGRect of = [contentV convertRect:originF fromView:self.originContentView];
            imageView.frame = of;
        } completion:^(BOOL finished) {
//            NSLog(@">>>>>>>animation  completion>>>>>>>>>>");
            [fromView removeFromSuperview];
            
            CGRect resultF = [contentV convertRect:self.imageView.frame toView:self.originContentView];
            imageView.frame = resultF;
            [self.originContentView addSubview:imageView];
            
//            NSLog(@"dismiss完成....");
            [transitionContext completeTransition:YES];
        }];
    }
}

//- (UIScrollView *)scrollView {
//    if (!_scrollView) {
//        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
//        _scrollView.maximumZoomScale = 3.0;
//        _scrollView.minimumZoomScale = 1.0;
//        _scrollView.delegate = self;
//        _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    }
//    return _scrollView;
//}

- (CGLImageGalleryHorizentalScroll *)horizentalScrollView {
    if (!_horizentalScrollView) {
        _horizentalScrollView = [[CGLImageGalleryHorizentalScroll alloc] initWithFrame:self.view.bounds];
        _horizentalScrollView.pagingEnabled = YES;
        _horizentalScrollView.delegate = self;
        for (int i = 0; i < _images.count; i ++) {
            CGLImageGalleryVeriticalScroll *scroll = [[CGLImageGalleryVeriticalScroll alloc] initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            scroll.tag = 1000+i;
            
            UIView *contentV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            contentV.tag = 1999;
            [scroll addSubview:contentV];
            
            CGLGalleryModel *mo = _images[i];
            UIImageView *imgV = mo.imageView;
            CGSize imagSize = imgV.image.size;
            CGFloat hei = 0;
            hei = SCREEN_WIDTH*imagSize.height/imagSize.width;
            CGFloat maxScale = 0;
            if (hei<=SCREEN_HEIGHT/3) {
                maxScale = SCREEN_HEIGHT/hei;
            }else{
                maxScale = 3;
            }
            scroll.maximumZoomScale = maxScale;
            scroll.minimumZoomScale = 1.0;
            scroll.delegate = self;
            scroll.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            //双击放大缩小
            UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
            doubleTap.numberOfTapsRequired = 2;
            [scroll addGestureRecognizer:doubleTap];
            
            
            //单击dismiss
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
            singleTap.numberOfTapsRequired = 1;
            [scroll addGestureRecognizer:singleTap];
            
            [singleTap requireGestureRecognizerToFail:doubleTap];
            
            [_horizentalScrollView addSubview:scroll];
        }
        
        _horizentalScrollView.contentSize = CGSizeMake(_images.count*SCREEN_WIDTH, SCREEN_HEIGHT);
    }
    return _horizentalScrollView;
}

- (void)setImages:(NSArray<CGLGalleryModel *> *)images {
    _images = images;
    
}

- (UIImageView *)imageView {
    CGLGalleryModel *mo = self.images[self.idx];
    UIImageView *imageV = mo.imageView;
    return imageV;
}

- (NSInteger)idx {
    CGFloat idx = self.horizentalScrollView.contentOffset.x/SCREEN_WIDTH;
    return idx;
}

- (UIScrollView *)currentScroll {
    UIScrollView *scroll = [self.horizentalScrollView viewWithTag:1000+self.idx];
    return scroll;
}

- (PresentationVC *)presentationVC {
    if (!_presentationVC) {
        
    }
    return _presentationVC;
}

- (UIPercentDrivenInteractiveTransition *)percentDrivenInteractiveTransition {
    if (!_percentDrivenInteractiveTransition) {
        _percentDrivenInteractiveTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
    }
    return _percentDrivenInteractiveTransition;
}

@end
