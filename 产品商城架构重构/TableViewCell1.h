//
//  TableViewCell1.h
//  探索更流畅的tablView和collectionView互嵌套
//
//  Created by Guanglei Cheng on 2019/12/26.
//  Copyright © 2019 Guanglei Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryViewController.h"

typedef void(^HandlerBlock)(UIPageViewController * _Nullable pageVC, NSInteger index,  CategoryViewController *categoryVC);

NS_ASSUME_NONNULL_BEGIN

@interface TableViewCell1 : UITableViewCell

- (void)congfigueCellWithWillBlock:(HandlerBlock)willHandlerBlock didBlock:(HandlerBlock)didHandlerBlock withVC:(UIViewController *)vc; 

@end

NS_ASSUME_NONNULL_END
