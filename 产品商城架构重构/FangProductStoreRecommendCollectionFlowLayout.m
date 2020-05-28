//
//  FangProductStoreRecommendCollectionFlowLayout.m
//  SouFun
//
//  Created by Guanglei Cheng on 2019/7/29.
//  Copyright © 2019 房天下 Fang.com. All rights reserved.
//

#import "FangProductStoreRecommendCollectionFlowLayout.h"

#define ZOOM_FACTOR 0.35

@implementation FangProductStoreRecommendCollectionFlowLayout

//- (void)prepareLayout {
//    [super prepareLayout];
//    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    self.itemSize = CGSizeMake(276, 144);
//    self.sectionInset = UIEdgeInsetsMake(10, 20, 30, 20);
//}

//- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
//    return YES;
//}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
//    CGRect contentFrame;
//    contentFrame.size = self.collectionView.frame.size;
//    contentFrame.origin = proposedContentOffset;
//
//    NSArray *array = [self layoutAttributesForElementsInRect:contentFrame];
//    CGFloat minCenterX = 276/2;
//    CGFloat baseLine = proposedContentOffset.x + 158;
//    if (velocity.x > 0) {
//        //手向左滑动,内容向左滚动,collectionView向右滚动
//        for (int i = 0; i < array.count; i ++) {
//            UICollectionViewLayoutAttributes *attrs = array[i];
//            if (ABS(attrs.center.x - baseLine) < ABS(minCenterX) || ABS(velocity.x) > 0.2) {
//                minCenterX = attrs.center.x - baseLine;
//            }
//        }
//
//    }else{
//        for (NSInteger i = array.count - 1; i >= 0; i --) {
//            UICollectionViewLayoutAttributes *attrs = array[i];
//            if (ABS(attrs.center.x - baseLine) < ABS(minCenterX) || ABS(velocity.x) > 0.2) {
//                minCenterX = attrs.center.x - baseLine;
//            }
//        }
//    }
//    return CGPointMake(proposedContentOffset.x + minCenterX, proposedContentOffset.y);
    
    return CGPointMake(proposedContentOffset.x + 20, proposedContentOffset.y);

}

@end
