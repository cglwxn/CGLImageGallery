//
//  CustomerView.m
//  探索更流畅的tablView和collectionView互嵌套
//
//  Created by Guanglei Cheng on 2020/1/2.
//  Copyright © 2020 Guanglei Cheng. All rights reserved.
//

#import "CustomerView.h"

@implementation CustomerView

- (void)addSubview:(UIView *)view {
    if (self.subviews.count > 0) {
        [super insertSubview:view atIndex:self.subviews.count - 1];
    }else{
        [super addSubview:view];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSLog(@"function:%s-------",__func__);

}

@end
