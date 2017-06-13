//
//  TYSpringsViewController.m
//  TYUIKitDynamicsDemo
//
//  Created by 马天野 on 2017/6/14.
//  Copyright © 2017年 MTY. All rights reserved.
//

#import "TYSpringsViewController.h"

@interface TYSpringsViewController ()

@property (nonatomic, strong) UIDynamicAnimator *dynamicAnimator;
@property (nonatomic, strong) UIGravityBehavior *gravityBehavior;
@property (nonatomic, strong) UICollisionBehavior *collisionBehavior;
@property (nonatomic, strong) UIAttachmentBehavior *attachmentBehavior;
@property (nonatomic, strong) UIImageView *imageView_first;
@property (nonatomic, strong) UIImageView *imageView_second;

@end

@implementation TYSpringsViewController

#pragma mark - lazy load

- (UIDynamicAnimator *)dynamicAnimator {
    if (nil == _dynamicAnimator) {
        _dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    }
    return _dynamicAnimator;
}

- (UIGravityBehavior *)gravityBehavior {
    if (nil == _gravityBehavior) {
        _gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.imageView_second]];
    }
    return _gravityBehavior;
}

- (UICollisionBehavior *)collisionBehavior {
    if (nil == _collisionBehavior) {
        _collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.imageView_first,self.imageView_second]];
        _collisionBehavior.collisionMode = UICollisionBehaviorModeBoundaries;
        _collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    }
    return _collisionBehavior;
}

- (UIAttachmentBehavior *)attachmentBehavior {
    if (nil == _attachmentBehavior) {
        _attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.imageView_second attachedToAnchor:CGPointMake(self.imageView_first.center.x, self.imageView_first.center.y)];
        [_attachmentBehavior setFrequency:1.0f];    // 设置振动频率
        [_attachmentBehavior setDamping:0.1f];      // 熨平动画的峰值
        [_attachmentBehavior setLength:100.0f];     // 设置连接的长度
    }
    return _attachmentBehavior;
}

- (UIImageView *)imageView_first {
    if (nil == _imageView_first) {
        _imageView_first = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lufei"]];
        _imageView_first.frame = CGRectMake(100, 300,100, 100);
    }
    return _imageView_first;
}

- (UIImageView *)imageView_second {
    if (nil == _imageView_second) {
        _imageView_second = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"路飞"]];
        _imageView_second.frame = CGRectMake(150, 100, 100, 100);
    }
    return _imageView_second;
}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0];
    [self.view addSubview:self.imageView_first];
    [self.view addSubview:self.imageView_second];
    [self addPanGesture];
    [self.dynamicAnimator addBehavior:self.gravityBehavior];
    [self.dynamicAnimator addBehavior:self.collisionBehavior];
    [self.dynamicAnimator addBehavior:self.attachmentBehavior];
}

// 添加平移手势
- (void)addPanGesture {
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecMethod:)];
    self.imageView_first.userInteractionEnabled = YES;
    [self.imageView_first addGestureRecognizer:panGes];
}

- (void)panGestureRecMethod:(UIPanGestureRecognizer *)pan {
    CGPoint point = [pan locationInView:self.view];
    self.imageView_first.center = point;
    [self.attachmentBehavior setAnchorPoint:point];
    
}

@end
