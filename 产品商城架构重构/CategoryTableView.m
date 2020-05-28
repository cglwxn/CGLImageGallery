//
//  CategoryTableView.m
//  产品商城架构重构
//
//  Created by Guanglei Cheng on 2020/3/20.
//  Copyright © 2020 Guanglei Cheng. All rights reserved.
//

#import "CategoryTableView.h"

@implementation CategoryTableView
//
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
//    return NO;
//}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    UITouch *touch = event.allTouches.allObjects.firstObject;
//    NSLog(@"%@---eventtype:%d----touchphase:%d",NSStringFromCGPoint(point),event.type,touch.phase);
//    return [super hitTest:point withEvent:event];
//}
//
//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
//    UITouch *touch = event.allTouches.allObjects.firstObject;
//    NSLog(@"%@---eventtype:%d----touchphase:%d",NSStringFromCGPoint(point),event.type,touch.phase);
//    return [super pointInside:point withEvent:event];
//}


@end
