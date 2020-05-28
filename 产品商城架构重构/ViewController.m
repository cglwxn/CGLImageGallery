//
//  ViewController.m
//  探索更流畅的tablView和collectionView互嵌套
//
//  Created by Guanglei Cheng on 2019/12/26.
//  Copyright © 2019 Guanglei Cheng. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import <SDWebImage.h>
#import "TableViewCell0.h"
#import "TableViewCell1.h"
#import "ViewController1.h"
#import "MainTableView.h"
#import "CategoryViewController.h"
#import "CGLImageGalleryVC.h"

static NSString *cell0ID = @"cell0ID";
static NSString *cell1ID = @"cell1ID";

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) MainTableView *tableView;
@property (nonatomic, strong) UIView *tableViewHeader;
@property (nonatomic, strong) CategoryViewController *categoryVC;

@property (nonatomic, strong) NSArray *imgs;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.imgs = @[@"大桥.png",@"爱情.jpg",@"窗.jpg",@"远方.JPG",@"彩虹桥.jpg",@"黄岛海滩.png"];
    [self.view addSubview:self.contentView];
    //    [self.view addSubview:self.imageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.contentView addGestureRecognizer:tap];
    
    
    
//    [self.view addSubview:self.tableView];
//    self.isMainTableViewCanScroll = YES;
//    self.isListCollectionViewCanScroll = YES;
//    [self makeConstraints];
//    [self addObserver:self forKeyPath:@"tableView.contentOffset" options:(NSKeyValueObservingOptionNew) context:nil];
//    NSLog(@"function:%s-------vc:safeAreaInsets:%@---additionalSafeAreaInsets:%@---contentInset:%@",__func__,NSStringFromUIEdgeInsets(self.view.safeAreaInsets),NSStringFromUIEdgeInsets(self.additionalSafeAreaInsets),NSStringFromUIEdgeInsets(self.tableView.contentInset));

}

- (void)tapAction:(UITapGestureRecognizer *)tapGs {
//    UIImageView *imageView = tapGs.view;
    
    CGPoint point = [tapGs locationInView:self.contentView];
    CGLImageGalleryVC *gl = [[CGLImageGalleryVC alloc] init];
    
    BOOL hasSelectOneImg = NO;
    NSMutableArray *imageModels = [NSMutableArray array];
    for (int i = 0; i < self.imgs.count; i ++) {
        UIImageView *imgV = [self.contentView viewWithTag:2000+i];
        CGLGalleryModel *mo = [[CGLGalleryModel alloc] init];
        mo.imageView = imgV;
        if (CGRectContainsPoint(imgV.frame, point)) {
            mo.isSelected = YES;
            hasSelectOneImg = YES;
        }
        [imageModels addObject:mo];
    }
    if (hasSelectOneImg) {
        gl.images = imageModels;
        [self presentViewController:gl animated:YES completion:^{
            
        }];
    }
    
//    [self.navigationController pushViewController:gl animated:YES];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"tableView.contentOffset"]) {
//        NSLog(@"%@",NSStringFromCGPoint(self.tableView.contentOffset));
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat listTableViewCellOffset = [_tableView rectForSection:1].origin.y-88;
    if (_tableView.contentOffset.y>=listTableViewCellOffset) {
        _tableView.contentOffset = CGPointMake(0, listTableViewCellOffset);
        if (self.isMainTableViewCanScroll) {
            self.isMainTableViewCanScroll = NO;
            self.isListCollectionViewCanScroll = YES;
        }
    }else{
        if (!self.isMainTableViewCanScroll) {
            _tableView.contentOffset = CGPointMake(0, listTableViewCellOffset);
        }else{
            self.isListCollectionViewCanScroll = NO;
        }
    }
    self.categoryVC.isListCollectionViewCanScroll = self.isListCollectionViewCanScroll;
    self.categoryVC.isMainTableViewCanScroll = self.isMainTableViewCanScroll;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    NSLog(@"function:%s-------vc:safeAreaInsets:%@---additionalSafeAreaInsets:%@---contentInset:%@",__func__,NSStringFromUIEdgeInsets(self.view.safeAreaInsets),NSStringFromUIEdgeInsets(self.additionalSafeAreaInsets),NSStringFromUIEdgeInsets(self.tableView.contentInset));
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
////    NSLog(@"%s",__func__);
//    NSLog(@"function:%s-------vc:safeAreaInsets:%@---additionalSafeAreaInsets:%@---contentInset:%@",__func__,NSStringFromUIEdgeInsets(self.view.safeAreaInsets),NSStringFromUIEdgeInsets(self.additionalSafeAreaInsets),NSStringFromUIEdgeInsets(self.tableView.contentInset));

}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
//    NSLog(@"%s",__func__);
//    NSLog(@"function:%s-------vc:safeAreaInsets:%@---additionalSafeAreaInsets:%@---contentInset:%@",__func__,NSStringFromUIEdgeInsets(self.view.safeAreaInsets),NSStringFromUIEdgeInsets(self.additionalSafeAreaInsets),NSStringFromUIEdgeInsets(self.tableView.contentInset));

}

- (void)viewDidLayoutSubviews {
//    NSLog(@"function:%s-------vc:safeAreaInsets:%@---additionalSafeAreaInsets:%@---contentInset:%@",__func__,NSStringFromUIEdgeInsets(self.view.safeAreaInsets),NSStringFromUIEdgeInsets(self.additionalSafeAreaInsets),NSStringFromUIEdgeInsets(self.tableView.contentInset));

}

- (void)makeConstraints {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {    ViewController1 *vc = [[ViewController1 alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }else{
        return 60;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
        header.backgroundColor = [UIColor orangeColor];
        return header;
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return CGRectGetHeight(self.view.frame)-60-88-34;
    }else{
        return UITableViewAutomaticDimension;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        TableViewCell0 *cell = [tableView dequeueReusableCellWithIdentifier:cell0ID forIndexPath:indexPath];
        
        if (indexPath.row == 0) {
            cell.imgName = @"窗.jpg";
        }else if (indexPath.row == 1){
            cell.imgName = @"远方.JPG";
        }else {
            cell.imgName = @"IMG_0110.JPG";
        }
        return cell;
    }else{
        TableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cell1ID forIndexPath:indexPath];
        WS(ws)
           
        [cell congfigueCellWithWillBlock:^(UIPageViewController * _Nullable pageVC, NSInteger index, CategoryViewController *categoryVC) {
            
        } didBlock:^(UIPageViewController * _Nullable pageVC, NSInteger index, CategoryViewController *categoryVC) {
            __strong typeof(ws) ss = ws;
            ss.categoryVC = categoryVC;

        } withVC:self];
        return cell;
    }
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"contentOffset:%@",NSStringFromCGPoint(scrollView.contentOffset));
//}

- (MainTableView *)tableView {
    if (!_tableView) {
        _tableView = [[MainTableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = UIColorMake(0xF5F5F5);
        
        _tableView.estimatedRowHeight = 400;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[TableViewCell0 class] forCellReuseIdentifier:cell0ID];
        [_tableView registerClass:[TableViewCell1 class] forCellReuseIdentifier:cell1ID];
    }
    return _tableView;
}

- (UIView *)tableViewHeader {
    if (!_tableViewHeader) {
        UIImage *img = [UIImage imageNamed:@"窗.jpg"];
        CGSize imgSize = img.size;
        _tableViewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, imgSize.height*SCREEN_WIDTH/img.size.width)];
        _tableViewHeader.backgroundColor = [UIColor orangeColor];
        UIImageView *headerImgV = [[UIImageView alloc] initWithFrame:_tableViewHeader.bounds];
        headerImgV.image = img;
        [_tableViewHeader addSubview:headerImgV];
        
    }
    return _tableViewHeader;
}


//- (UIImageView *)imageView {
//    if (!_imageView) {
//        _imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
//        UIImage *img = [UIImage imageNamed:@"大桥.png"];
//        _imageView.frame = CGRectMake(0, 0, 200, 200);
//        _imageView.image = img;
//        _imageView.tag = 10086;
//        _imageView.center = CGPointMake(self.view.center.x, self.view.center.y-200);
//        _imageView.contentMode = UIViewContentModeScaleAspectFill;
//        _imageView.backgroundColor = [UIColor orangeColor];
//        _imageView.clipsToBounds = YES;
//    }
//    return _imageView;
//}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.center = CGPointMake(self.view.center.x, self.view.center.y);
        for (int i = 0; i < 6; i ++) {
            UIImageView *imageV = [self obtainImageView:CGRectMake(i%3*((SCREEN_WIDTH-40)/3+10)+10, i/3*((SCREEN_WIDTH-40)/3+10)+10, (SCREEN_WIDTH-40)/3, (SCREEN_WIDTH-40)/3) imgName:self.imgs[i] tag:i + 2000];
            [_contentView addSubview:imageV];
        }
        
    }
    return _contentView;
}

- (UIImageView *)obtainImageView:(CGRect)frame imgName:(NSString *)imgName tag:(NSInteger)tag {
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:frame];
    UIImage *img = [UIImage imageNamed:imgName];
    imageView.tag = tag;
//    imageView.frame = CGRectMake(0, 0, 200, 200);
    imageView.image = img;
//    imageView.tag = 10086;
//    imageView.center = CGPointMake(self.view.center.x, self.view.center.y-200);
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.backgroundColor = [UIColor orangeColor];
    imageView.clipsToBounds = YES;
    
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
//    [imageView addGestureRecognizer:tap];
//    imageView.userInteractionEnabled = YES;
    return imageView;
}

@end
