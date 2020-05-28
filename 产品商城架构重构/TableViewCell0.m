//
//  TableViewCell0.m
//  探索更流畅的tablView和collectionView互嵌套
//
//  Created by Guanglei Cheng on 2019/12/26.
//  Copyright © 2019 Guanglei Cheng. All rights reserved.
//

#import "TableViewCell0.h"
#import <Masonry.h>

@interface TableViewCell0 ()

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation TableViewCell0

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.imgView];
        [self makeConstraints];
    }
    return self;
}

- (void)makeConstraints {
    for (UIView *subV in self.contentView.subviews) {
        [subV setContentHuggingPriority:750 forAxis:(UILayoutConstraintAxisHorizontal)];
        [subV setContentHuggingPriority:750 forAxis:(UILayoutConstraintAxisVertical)];
        [subV setContentCompressionResistancePriority:250 forAxis:(UILayoutConstraintAxisVertical)];
        [subV setContentCompressionResistancePriority:250 forAxis:(UILayoutConstraintAxisHorizontal)];
    }
    
//    UIImage *img = [UIImage imageNamed:@"窗.jpg"];
//    CGSize imgSize = img.size;
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(100);
        make.bottom.mas_equalTo(self.contentView);
    }];
}

- (void)setImgName:(NSString *)imgName {
    _imgName = imgName;
    UIImage *img = [UIImage imageNamed:imgName];
    self.imageView.image = img;
    CGSize imgSize = img.size;
    
    [self.imgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo((imgSize.height*SCREEN_WIDTH)/imgSize.width);
    }];
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
//        _imgView.image = [UIImage imageNamed:@"窗.jpg"];
    }
    return _imgView;
}

@end
