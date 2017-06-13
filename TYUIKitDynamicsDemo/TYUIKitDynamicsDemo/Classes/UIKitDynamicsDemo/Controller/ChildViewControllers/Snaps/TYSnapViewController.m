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
@property (nonatomic, strong) UISnapBehavior *snapBehavior;
@property (nonatomic, strong) UIImageView *imageView_first;
@property (nonatomic, strong) UITapGestureRecognizer *tap;

@end

@implementation TYSnapViewController

#pragma mark - lazy load

- (UIDynamicAnimator *)dynamicAnimator {
    if (nil == _dynamicAnimator) {
        _dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    }
    return _dynamicAnimator;
}

//- (UISnapBehavior *)snapBehavior {
//    if (nil == _snapBehavior) {
//        CGPoint point = [self.tap locationInView:self.view];
//        _snapBehavior = [[UISnapBehavior alloc] initWithItem:self.imageView_first snapToPoint:point];
//        _snapBehavior.damping = 0.75f;
//    }
//    return _snapBehavior;
//}

- (UIImageView *)imageView_first {
    if (nil == _imageView_first) {
        _imageView_first = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lufei"]];
        _imageView_first.frame = CGRectMake(100, 100, 100, 100);
    }
    return _imageView_first;
}

- (UITapGestureRecognizer *)tap {
    if (nil == _tap) {
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMethod:)];
    }
    return _tap;
}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0];
    self.imageView_first.userInteractionEnabled = YES;
    [self.imageView_first addGestureRecognizer:self.tap];
    [self.view addSubview:self.imageView_first];
    [self.dynamicAnimator addBehavior:self.snapBehavior];
}

- (void)tapMethod:(UITapGestureRecognizer *)tap {
    CGPoint point = [tap locationInView:self.view];
    self.snapBehavior = [[UISnapBehavior alloc] initWithItem:self.imageView_first snapToPoint:point];
    self.snapBehavior.damping = 0.75f;
}

@end
