//
//  TYPropertyViewController.m
//  TYUIKitDynamicsDemo
//
//  Created by 马天野 on 2017/6/14.
//  Copyright © 2017年 MTY. All rights reserved.
//

#import "TYPropertyViewController.h"

@interface TYPropertyViewController ()

@property (nonatomic, strong) UIDynamicAnimator *dynamicAnimator;
@property (nonatomic, strong) UIGravityBehavior *gravityBehavior;
@property (nonatomic, strong) UIImageView *imageView_first;
@property (nonatomic, strong) UIImageView *imageView_second;
@property (nonatomic, strong) UICollisionBehavior *collisionBehavior;
@property (nonatomic, strong) UIDynamicItemBehavior *dynamicItemBehavior;

@end

@implementation TYPropertyViewController

#pragma mark - lazy load

- (UIDynamicAnimator *)dynamicAnimator {
    if (nil == _dynamicAnimator) {
        _dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    }
    return _dynamicAnimator;
}

- (UIGravityBehavior *)gravityBehavior {
    if (nil == _gravityBehavior) {
        _gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.imageView_first,self.imageView_second]];
    }
    return _gravityBehavior;
}

- (UICollisionBehavior *)collisionBehavior {
    if (nil == _collisionBehavior) {
        _collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.imageView_first, self.imageView_second]];
        _collisionBehavior.collisionMode = UICollisionBehaviorModeBoundaries;
        _collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    }
    return _collisionBehavior;
}

- (UIDynamicItemBehavior *)dynamicItemBehavior {
    if (nil == _dynamicItemBehavior) {
        _dynamicItemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.imageView_first]];
        _dynamicItemBehavior.elasticity                        // 与其他物体碰撞时的弹性.(0.0~1.0).0.0表示没有弹性.1.0表示反弹的力与作用力一样
        = 1.0f;
        _dynamicItemBehavior.allowsRotation = NO;              // 指定物体在受力时是否旋转
        _dynamicItemBehavior.angularResistance = 0.0f;         // 指定旋转阻力,值越大,旋转速度下降越快
        _dynamicItemBehavior.density = 3.0f;                   // 物体的密度.调整密度影响重力和碰撞效果
        _dynamicItemBehavior.friction = 0.5f;                  // 物体之间的滑动阻力.0.0表示无摩擦力.1.0表示摩擦力很大.可以超过1.0
        _dynamicItemBehavior.resistance = 0.5f;                // 空气阻力.(0.0~CGFLOAT_MAX).0.0表示没有空气阻力.1.0表示一旦其他作用力消失,物体就会停止
    }
    return _dynamicItemBehavior;
}

- (UIImageView *)imageView_first {
    if (nil == _imageView_first) {
        _imageView_first = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lufei"]];
        _imageView_first.frame = CGRectMake(100, 100, 100, 100);
    }
    return _imageView_first;
}

- (UIImageView *)imageView_second {
    if (nil == _imageView_second) {
        _imageView_second = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"路飞"]];
        _imageView_second.frame = CGRectMake(150, 300, 100, 100);
    }
    return _imageView_second;
}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0];
    [self.view addSubview:self.imageView_first];
    [self.view addSubview:self.imageView_second];
    [self.dynamicAnimator addBehavior:self.dynamicItemBehavior];
    [self.dynamicAnimator addBehavior:self.gravityBehavior];
    [self.dynamicAnimator addBehavior:self.collisionBehavior];
}

@end
