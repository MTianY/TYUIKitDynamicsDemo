//
//  TYSnapViewController.m
//  TYUIKitDynamicsDemo
//
//  Created by 马天野 on 2017/6/14.
//  Copyright © 2017年 MTY. All rights reserved.
//

#import "TYSnapViewController.h"

@interface TYSnapViewController ()

@property (nonatomic, strong) UIDynamicAnimator *dynamicAnimator;
@property (nonatomic, strong) UIImageView *imageView_first;

@end

@implementation TYSnapViewController

#pragma mark - lazy load

- (UIDynamicAnimator *)dynamicAnimator {
    if (nil == _dynamicAnimator) {
        _dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    }
    return _dynamicAnimator;
}

- (UIImageView *)imageView_first {
    if (nil == _imageView_first) {
        _imageView_first = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lufei"]];
        _imageView_first.frame = CGRectMake(100, 100, 100, 100);
    }
    return _imageView_first;
}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0];
    [self.view addSubview:self.imageView_first];
    [self addTapGes];
}

- (void)addTapGes {
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMethod:)];
    [self.view addGestureRecognizer:tapGes];
}

- (void)tapMethod:(UITapGestureRecognizer *)tap {
    CGPoint point = [tap locationInView:self.view];
    UISnapBehavior *snapBehavior = [[UISnapBehavior alloc] initWithItem:self.imageView_first snapToPoint:point];
    snapBehavior.damping = 0.75f;
    [self.dynamicAnimator removeAllBehaviors];  // 如果要进行连续的吸附行为,那么就必须把之前的吸附行为从力学动画器中移除
    [self.dynamicAnimator addBehavior:snapBehavior];
}

@end
