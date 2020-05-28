//
//  CGLImageGalleryVC.h
//  产品商城架构重构
//
//  Created by Guanglei Cheng on 2020/5/11.
//  Copyright © 2020 Guanglei Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGLGalleryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CGLImageGalleryVC : UIViewController

@property (nonatomic, strong) NSString *imageName;

@property (nonatomic, strong) NSArray <CGLGalleryModel *>*images;

@end

NS_ASSUME_NONNULL_END
