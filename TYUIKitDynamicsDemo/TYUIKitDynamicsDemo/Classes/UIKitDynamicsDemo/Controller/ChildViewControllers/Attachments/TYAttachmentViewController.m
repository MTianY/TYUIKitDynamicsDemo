//
//  TYAttachmentViewController.m
//  TYUIKitDynamicsDemo
//
//  Created by 马天野 on 2017/6/13.
//  Copyright © 2017年 MTY. All rights reserved.
//

#import "TYAttachmentViewController.h"

@interface TYAttachmentViewController ()

@property (nonatomic, strong) UIImageView *imageView_first;
@property (nonatomic, strong) UIImageView *imageView_second;
@property (nonatomic, strong) UIDynamicAnimator *dynamicAnimator;
@property (nonatomic, strong) UIGravityBehavior *gravityBehavior;
@property (nonatomic, strong) UICollisionBehavior *collisionBehavior;
@property (nonatomic, strong) UIAttachmentBehavior *attachmentBehavior;

@end

@implementation TYAttachmentViewController

#pragma mark - lazy load

- (UIImageView *)imageView_first {
    if (nil == _imageView_first) {
        _imageView_first = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"路飞"]];
        _imageView_first.frame = CGRectMake(50, 100, 100, 100);
    }
    return _imageView_first;
}

- (UIImageView *)imageView_second {
    if (nil == _imageView_second) {
        _imageView_second = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lufei"]];
        _imageView_second.frame = CGRectMake(200, 300, 100, 100);
    }
    return _imageView_second;
}

- (UIDynamicAnimator *)dynamicAnimator {
    if (nil == _dynamicAnimator) {
        _dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    }
    return _dynamicAnimator;
}

- (UIGravityBehavior *)gravityBehavior {
    if (nil == _gravityBehavior) {
        _gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.imageView_first]];
        [_gravityBehavior setAngle:M_PI_2 magnitude:0.3];
    }
    return _gravityBehavior;
}

- (UICollisionBehavior *)collisionBehavior {
    if (nil == _collisionBehavior) {
        _collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.imageView_first,self.imageView_second]];
        _collisionBehavior.collisionMode = UICollisionBehaviorModeEverything;
        _collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    }
    return _collisionBehavior;
}

- (UIAttachmentBehavior *)attachmentBehavior {
    if (nil == _attachmentBehavior) {
        _attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.imageView_first attachedToAnchor:CGPointMake(self.imageView_second.center.x,self.imageView_second.center.y)];
    }
    return _attachmentBehavior;
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
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panMethod:)];
    self.imageView_second.userInteractionEnabled = YES;
    [self.imageView_second addGestureRecognizer:panGes];
}

- (void)panMethod:(UIPanGestureRecognizer *)pan {
    CGPoint panPoint = [pan locationInView:self.view];
    self.imageView_second.center = panPoint;
    [self.attachmentBehavior setAnchorPoint:panPoint];
}

@end
