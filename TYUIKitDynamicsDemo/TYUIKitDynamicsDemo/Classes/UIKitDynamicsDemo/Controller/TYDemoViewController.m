//
//  TYDemoViewController.m
//  TYUIKitDynamicsDemo
//
//  Created by 马天野 on 2017/6/13.
//  Copyright © 2017年 MTY. All rights reserved.
//

#import "TYDemoViewController.h"
#import "TYGravityViewController.h"
#import "TYCollisionViewController.h"
#import "TYAttachmentViewController.h"
#import "TYSpringsViewController.h"
#import "TYSnapViewController.h"
#import "TYPushViewController.h"
#import "TYPropertyViewController.h"

@interface TYDemoViewController ()

@property (nonatomic, strong) NSArray *functionList;
@property (nonatomic, strong) NSArray *functionListChinese;

@end

@implementation TYDemoViewController

#pragma mark - 懒加载

- (NSArray *)functionList {
    if (nil == _functionList) {
        _functionList = [NSArray array];
        _functionList = @[@"Gravity",@"Collisions",@"Attachments",@"Springs",@"Snap",@"Forces",@"Properties"];
    }
    return _functionList;
}

- (NSArray *)functionListChinese {
    if (nil == _functionListChinese) {
        _functionListChinese = [NSArray array];
        _functionListChinese = @[@"重力",@"碰撞",@"连接",@"弹簧效果",@"吸附",@"推力",@"物体属性"];
    }
    return _functionListChinese;
}

#pragma mark - View 的生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.functionList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = self.functionList[indexPath.row];
    cell.detailTextLabel.text = self.functionListChinese[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 1.重力测试
    if (0 == indexPath.row) {
        TYGravityViewController *gravityVc = [[TYGravityViewController alloc] init];
        [self.navigationController pushViewController:gravityVc animated:YES];
    }
    
    // 2.碰撞测试
    if (1 == indexPath.row) {
        TYCollisionViewController *collisionVc = [[TYCollisionViewController alloc] init];
        [self.navigationController pushViewController:collisionVc animated:YES];
    }
    
    // 3.连接测试
    if (2 == indexPath.row) {
        TYAttachmentViewController *attachmentVc = [[TYAttachmentViewController alloc] init];
        [self.navigationController pushViewController:attachmentVc animated:YES];
    }
    
    // 4.弹簧效果测试
    if (3 == indexPath.row) {
        TYSpringsViewController *springsVc = [[TYSpringsViewController alloc] init];
        [self.navigationController pushViewController:springsVc animated:YES];
    }
    
    // 5.吸附测试
    if (4 == indexPath.row) {
        TYSnapViewController *snapVc = [[TYSnapViewController alloc] init];
        [self.navigationController pushViewController:snapVc animated:YES];
    }
    
    // 6.推力测试
    if (5 == indexPath.row) {
        TYPushViewController *pushVc = [[TYPushViewController alloc] init];
        [self.navigationController pushViewController:pushVc animated:YES];
    }
    
    // 7.属性测试
    if (6 == indexPath.row) {
        TYPropertyViewController *propertyVc = [[TYPropertyViewController alloc] init];
        [self.navigationController pushViewController:propertyVc animated:YES];
    }
    
}

@end
