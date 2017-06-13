//
//  TYGravityViewController.m
//  TYUIKitDynamicsDemo
//
//  Created by 马天野 on 2017/6/13.
//  Copyright © 2017年 MTY. All rights reserved.
//

#import "TYGravityViewController.h"

@interface TYGravityViewController ()

/**
 力学动画生成器
 */
@property (nonatomic, strong) UIDynamicAnimator *dynamicAnimator;

/**
 重力行为对象
 */
@property (nonatomic, strong) UIGravityBehavior *gravityBehavior;

/**
 重力效果视图
 */
@property (nonatomic, strong) UIImageView *gravityEffectView;

@end

@implementation TYGravityViewController

#pragma mark - lazy load

- (UIDynamicAnimator *)dynamicAnimator {
    if (nil == _dynamicAnimator) {
        _dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    }
    return _dynamicAnimator;
}

- (UIGravityBehavior *)gravityBehavior {
    if (nil == _gravityBehavior) {
        _gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.gravityEffectView]];
    }
    return _gravityBehavior;
}

- (UIImageView *)gravityEffectView {
    if (nil == _gravityEffectView) {
        _gravityEffectView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lufei"]];
        _gravityEffectView.frame = CGRectMake(100, 100, 100, 100);
    }
    return _gravityEffectView;
}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0];
    
    // 1.添加重力效果视图
    [self.view addSubview:self.gravityEffectView];
    
    // 2.设置重力行为
    [self.gravityBehavior setAngle:M_PI_2 magnitude:0.2f];
    
    // 3.添加到力学动画生成器中
    [self.dynamicAnimator addBehavior:self.gravityBehavior];
    
}

@end
