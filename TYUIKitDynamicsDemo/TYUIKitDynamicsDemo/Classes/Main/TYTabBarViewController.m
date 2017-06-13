//
//  TYTabBarViewController.m
//  TYUIKitDynamicsDemo
//
//  Created by 马天野 on 2017/6/13.
//  Copyright © 2017年 MTY. All rights reserved.
//

#import "TYTabBarViewController.h"
#import "TYDemoViewController.h"
#import "TYNavigationViewController.h"

@interface TYTabBarViewController ()

@end

@implementation TYTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildVcs];
}

#pragma mark - 添加子控制器

- (void)addChildVcs {
    TYDemoViewController *demoVc = [[TYDemoViewController alloc] init];
    TYNavigationViewController *navVc_demo = [[TYNavigationViewController alloc] initWithRootViewController:demoVc];
    demoVc.title = @"UIKit Dynamics";
    [self addChildViewController:navVc_demo];
}

@end
