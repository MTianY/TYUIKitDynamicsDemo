//
//  TYPushViewController.m
//  TYUIKitDynamicsDemo
//
//  Created by 马天野 on 2017/6/14.
//  Copyright © 2017年 MTY. All rights reserved.
//

#import "TYPushViewController.h"

@interface TYPushViewController ()

@property (nonatomic, strong) UIDynamicAnimator *dynamicAnimator;
@property (nonatomic, strong) UICollisionBehavior *collisionBehavior;
@property (nonatomic, strong) UIPushBehavior *pushBehavior;
@property (nonatomic, strong) UIImageView *imageView_first;

@end

@implementation TYPushViewController

#pragma mark - lazy load

- (UIDynamicAnimator *)dynamicAnimator {
    if (nil == _dynamicAnimator) {
        _dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    }
    return _dynamicAnimator;
}

- (UICollisionBehavior *)collisionBehavior {
    if (nil == _collisionBehavior) {
        _collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.imageView_first]];
        _collisionBehavior.collisionMode = UICollisionBehaviorModeBoundaries;
        _collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    }
    return _collisionBehavior;
}

- (UIPushBehavior *)pushBehavior {
    if (nil == _pushBehavior) {
        _pushBehavior = [[UIPushBehavior alloc] initWithItems:@[self.imageView_first] mode:UIPushBehaviorModeInstantaneous];
        _pushBehavior.angle = 0.0;
        _pushBehavior.magnitude = 0.0;
    }
    return _pushBehavior;
}

- (UIImageView *)imageView_first {
    if (nil == _imageView_first) {
        _imageView_first = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lufei"]];
        _imageView_first.frame = CGRectMake(100, 400, 100, 100);
    }
    return _imageView_first;
}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0];
    [self.view addSubview:self.imageView_first];
    [self addTapGes];
    [self.dynamicAnimator addBehavior:self.collisionBehavior];
    [self.dynamicAnimator addBehavior:self.pushBehavior];
}

// 新建平移手势
- (void)addTapGes {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMethod:)];
    [self.view addGestureRecognizer:tap];
}

- (void)tapMethod:(UITapGestureRecognizer *)tap {
    CGPoint locationPoint = [tap locationInView:self.view];
    // 参考点
    CGPoint oriPoint = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    // 勾股定理求出距离
    CGFloat distance = sqrt(powf(locationPoint.x - oriPoint.x, 2.0) + powf(locationPoint.y - oriPoint.y, 2.0));
    // 根据参考点求出角度.从而确定推力的方向
    CGFloat angle = atan2(locationPoint.y - oriPoint.y, locationPoint.x - oriPoint.x);
    distance = MIN(distance, 100.0);
    [self.pushBehavior setMagnitude:distance / 100.0];
    [self.pushBehavior setAngle:angle];
    [self.pushBehavior setActive:YES];
}

/** 函数解析
 * double pow(double x, double y）;       计算以x为底数的y次幂
 * float powf(float x, float y);          功能与pow一致，只是输入与输出皆为浮点数
 * double sqrt (double);                  开平方
 * double atan2 (double, double);         反正切(整圆值), 结果介于[-PI, PI]
 */

@end
