//
//  CategoryViewController.h
//  产品商城架构重构
//
//  Created by Guanglei Cheng on 2020/3/20.
//  Copyright © 2020 Guanglei Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryTableView.h"
#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CategoryViewController : UIViewController

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) CategoryTableView *tableView;
@property (nonatomic, strong) ViewController *mainVC;

@property (nonatomic, assign) CGFloat listTableViewCellOffset;
@property (nonatomic, assign) BOOL isMainTableViewCanScroll;
@property (nonatomic, assign) BOOL isListCollectionViewCanScroll;
@end

NS_ASSUME_NONNULL_END
