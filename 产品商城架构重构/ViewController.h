//
//  ViewController.h
//  探索更流畅的tablView和collectionView互嵌套
//
//  Created by Guanglei Cheng on 2019/12/26.
//  Copyright © 2019 Guanglei Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (nonatomic, assign) CGFloat listTableViewCellOffset;
@property (nonatomic, assign) BOOL isMainTableViewCanScroll;
@property (nonatomic, assign) BOOL isListCollectionViewCanScroll;

//@property (nonatomic, readonly) UIImageView *imageView;
@property (nonatomic, strong) UIView *contentView;



@end

