//
//  CGLGalleryModel.m
//  产品商城架构重构
//
//  Created by Guanglei Cheng on 2020/5/20.
//  Copyright © 2020 Guanglei Cheng. All rights reserved.
//

#import "CGLGalleryModel.h"

@interface CGLGalleryModel ()

@end

@implementation CGLGalleryModel

- (void)setImageView:(UIImageView *)imageView {
    _imageView = imageView;
    self.originFrame = imageView.frame;
}

@end
