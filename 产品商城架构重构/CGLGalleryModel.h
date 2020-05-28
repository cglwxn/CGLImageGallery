//
//  CGLGalleryModel.h
//  产品商城架构重构
//
//  Created by Guanglei Cheng on 2020/5/20.
//  Copyright © 2020 Guanglei Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CGLGalleryModel : NSObject

@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSURL *imgURL;
@property (nonatomic, assign) CGRect originFrame;

@end

NS_ASSUME_NONNULL_END
