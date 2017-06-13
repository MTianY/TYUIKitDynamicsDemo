//
//  TYCollisionViewController.m
//  TYUIKitDynamicsDemo
//
//  Created by 马天野 on 2017/6/13.
//  Copyright © 2017年 MTY. All rights reserved.
//

#import "TYCollisionViewController.h"

@interface TYCollisionViewController () <UICollisionBehaviorDelegate>

/**
 力学动画生成器
 */
@property (nonatomic, strong) UIDynamicAnimator *dynamicAnimator;

@property (nonatomic, strong) UIDynamicAnimator *dynamicAnimator_01;

/**
 重力行为对象
 */
@property (nonatomic, strong) UIGravityBehavior *gravityBehavior;
@property (nonatomic, strong) UIGravityBehavior *gravityBehavior_01;

/**
 碰撞行为对象
 */
@property (nonatomic, strong) UICollisionBehavior *collisionBehavior;
@property (nonatomic, strong) UICollisionBehavior *collisionBehavior_01;

/**
 第一个碰撞效果视图
 */
@property (nonatomic, strong) UIImageView *collisionEffectView_first;

/**
 第二个碰撞效果视图
 */
@property (nonatomic, strong) UIImageView *collisionEffectView_second;

@end

@implementation TYCollisionViewController

#pragma mark - lazy load

- (UIDynamicAnimator *)dynamicAnimator {
    if (nil == _dynamicAnimator) {
        _dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    }
    return _dynamicAnimator;
}

- (UIDynamicAnimator *)dynamicAnimator_01 {
    if (nil == _dynamicAnimator_01) {
        _dynamicAnimator_01 = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    }
    return _dynamicAnimator_01;
}

- (UIGravityBehavior *)gravityBehavior {
    if (nil == _gravityBehavior) {
        _gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.collisionEffectView_first,self.collisionEffectView_second]];
        [_gravityBehavior setAngle:M_PI_2 magnitude:0.5];   // 指定以0.5的重力向下拖动
    }
    return _gravityBehavior;
}

- (UIGravityBehavior *)gravityBehavior_01 {
    if (nil == _gravityBehavior_01) {
        _gravityBehavior_01 = [[UIGravityBehavior alloc] initWithItems:@[self.collisionEffectView_second]];
        [_gravityBehavior_01 setAngle:M_PI_2 magnitude:0.1];
    }
    return _gravityBehavior_01;
}

- (UICollisionBehavior *)collisionBehavior {
    if (nil == _collisionBehavior) {
        _collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.collisionEffectView_first,self.collisionEffectView_second]];
        _collisionBehavior.collisionMode = UICollisionBehaviorModeEverything;   // 碰撞模式
        _collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;         // 定义边界为活跃状态
        _collisionBehavior.collisionDelegate = self;
    }
    return _collisionBehavior;
}

- (UICollisionBehavior *)collisionBehavior_01 {
    if (nil == _collisionBehavior_01) {
        _collisionBehavior_01 = [[UICollisionBehavior alloc] initWithItems:@[self.collisionEffectView_second]];
        _collisionBehavior_01.collisionMode = UICollisionBehaviorModeEverything;   // 碰撞模式
        _collisionBehavior_01.translatesReferenceBoundsIntoBoundary = YES;         // 定义边界为活跃状态
        _collisionBehavior_01.collisionDelegate = self;
    }
    return _collisionBehavior_01;
}

- (UIImageView *)collisionEffectView_first {
    if (nil == _collisionEffectView_first) {
        _collisionEffectView_first = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lufei"]];
        _collisionEffectView_first.frame = CGRectMake(100, 100, 100, 100);
    }
    return _collisionEffectView_first;
}

- (UIImageView *)collisionEffectView_second {
    if (nil == _collisionEffectView_second) {
        _collisionEffectView_second = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"路飞"]];
        _collisionEffectView_second.frame = CGRectMake(130, 310, 100, 100);
    }
    return _collisionEffectView_second;
}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0];
   
    // 1.碰撞测试
    [self borderCollisionTest];
    
}

// 碰撞测试
- (void)borderCollisionTest {
    [self.view addSubview:self.collisionEffectView_first];
    [self.view addSubview:self.collisionEffectView_second];
    [self.dynamicAnimator addBehavior:self.gravityBehavior];
    [self.dynamicAnimator addBehavior:self.collisionBehavior];
//    [self.dynamicAnimator_01 addBehavior:self.gravityBehavior_01];
//    [self.dynamicAnimator_01 addBehavior:self.collisionBehavior_01];
}

#pragma mark - UICollisionBehaviorDelegate

/**
 碰撞开始时调用.并指出了边界及接触点

 @param behavior 碰撞行为
 @param item 发生碰撞行为的视图
 @param identifier 接触的边界的标识
 @param p 接触点
 */
- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p {
    
    if ([item isEqual:self.collisionEffectView_first]) {
        NSLog(@"第一个图碰到了---%zd",p);
    }
    
    if ([item isEqual:self.collisionEffectView_second]) {
        NSLog(@"第二个图碰到了---%zd",p);
    }
    
}

/**
 碰撞开始的时候调用,没有指出边界

 @param behavior 碰撞行为
 @param item1 发生碰撞的视图1
 @param item2 发生碰撞的视图2
 @param p 接触点
 */
- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item1 withItem:(id<UIDynamicItem>)item2 atPoint:(CGPoint)p {
    
}

/**
 碰撞结束时调用,没有指出边界
 
 @param behavior 碰撞行为
 @param item1 发生碰撞的视图1
 @param item2 发生碰撞的视图2
 */
- (void)collisionBehavior:(UICollisionBehavior *)behavior endedContactForItem:(id<UIDynamicItem>)item1 withItem:(id<UIDynamicItem>)item2 {
    
}

/**
 碰撞结束时调用,指出边界

 @param behavior 碰撞行为
 @param item 发生碰撞的视图1
 @param identifier 边界的标识
 */
- (void)collisionBehavior:(UICollisionBehavior *)behavior endedContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier {
    
}



@end
