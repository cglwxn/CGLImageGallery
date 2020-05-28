//
//  CategoryViewController.m
//  产品商城架构重构
//
//  Created by Guanglei Cheng on 2020/3/20.
//  Copyright © 2020 Guanglei Cheng. All rights reserved.
//

#import "CategoryViewController.h"
#import <Masonry.h>

static NSString *cellID = @"cellID";

@interface CategoryViewController ()<UITableViewDelegate,UITableViewDataSource>
@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self makeConstaints];
}

- (void)makeConstaints {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    NSString *text = [NSString stringWithFormat:@"%ld",indexPath.row];
    cell.textLabel.text = text;
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.isListCollectionViewCanScroll) {
        scrollView.contentOffset = CGPointZero;
    }
    
    if (scrollView.contentOffset.y <= 0) {
        scrollView.contentOffset = CGPointZero;
        _mainVC.isListCollectionViewCanScroll = NO;
        _mainVC.isMainTableViewCanScroll = YES;
    }
}

- (CategoryTableView *)tableView {
    if (!_tableView) {
        _tableView = [[CategoryTableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = UIColorMake(0xF5F5F5);
        _tableView.sectionHeaderHeight = CGFLOAT_MIN;
        _tableView.sectionFooterHeight = CGFLOAT_MIN;
        _tableView.estimatedRowHeight = 400;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
//        _tableView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
//        _tableView.verticalScrollIndicatorInsets = UIEdgeInsetsMake(44, 0, 0, 0);
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    }
    return _tableView;
}

@end
