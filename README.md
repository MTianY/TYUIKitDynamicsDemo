# TYUIKitDynamicsDemo
&lt;iOS 组件与框架> --- UIKit Dynamics Demo

## UIKit Dynamics

> 结合 『iOS 组件与框架 』一书.总结的知识点与demo
> demo 地址: [GitHub地址](https://github.com/MTianY/TYUIKitDynamicsDemo)

### 一.概述
1.UIKit Dynamics 是 iOS 7 新增的内容.其 `目的` 就是为了可以让 `UIView能够模拟逼真的物理效果`.

2.通过使用 `UIDynamicItem协议` 及 支持它的动态物体(dynamic item),可极大的改善用户体验.现在,给界面添加`重力、碰撞、弹簧和吸附 (snap)` 等效果易如反掌,这些效果让应用给人耳目一新之感. 

3.下面会结合示例来讲解.(真机运行效果会更好)

### 二.UIKit Dynamics 简介

1.UIKit Dynamics 是 iOS 7 新增的一组`类和方法`,可赋予 UIView 逼真的行为和特征,让开发人员能够轻松的改善应用的用户体验.简单的说就是,UIKit Dynamics 是个基本的 UIKit 物理引擎,但不像传统物理引擎那样用于开发游戏.

2.要实现动态行为,可创建一个`力学动画生成器 UIDynamicAnimator`.每个力学动画生成器,都可以使用各种属性和行为进行定制.如`重力,碰撞检测,密度,摩擦力`等等.

3.共有 6 个可用于定制 UIDynamicAnimator 的类.以下这些类都支持定制,他们赋予相关联的 UIView 逼真的行为和动画.

- UIAttchmentBehavior
- UICollisionBehavior
- UIDynamicItemBehavior
- UIGravityBehavior
- UIPushBehavior
- UISnapBehavior

### 三.实现 UIKit Dynamics

##### 力学动画生成器 (UIDynamicAnimator) 注意点

- 每个 UIDynamicAnimator 都是独立的,多个 UIDynamicAnimator 可同时运行.
- 如果要想让 UIDynamicAnimator 持续运行,必须有指向它的有效引用.
- 相关的物体都处于静止状态后, UIDynamicAnimator 将暂停.不再执行任何计算.但对于未用的 UIDynamicAnimator,,建议将其删除.

#### 1.重力

1.重力是最容易实现,也是最实用的动态行为.效果图

![重力效果图](/Users/Maty/Desktop/Gravity.gif)

2.实现步骤

- 首先创建一个`力学动画生成器  UIDynamicAniamtor`.并对其强引用.其参考视图设置为当期控制器的view
- 创建`动力行为对象 UIGravityBehavior`.并使用数组来初始化它,该数组包含的是要应用重力效果的视图(注意: 动态物体必须是参考视图的子视图,否则力学动画生成器将不会生成任何动态效果).
- 设置重力行为.通过`setAngle: magnitude:`方法
- 将重力行为加到力学动画生成器中

3.代码示例

```objc
// 1.创建力学动画生成器
// self.view 为力学动画生成器的参考视图
- (UIDynamicAnimator *)dynamicAnimator {
    if (nil == _dynamicAnimator) {
        _dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    }
    return _dynamicAnimator;
}

// 2. 创建重力行为对象
// @[self.gravityEffectView]是用于展示重力行为的视图.自己创建的
- (UIGravityBehavior *)gravityBehavior {
    if (nil == _gravityBehavior) {
        _gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.gravityEffectView]];
    }
    return _gravityBehavior;
}

// 3.设置重力行为
[self.gravityBehavior setAngle:M_PI_2 magnitude:0.3f];
```

4.方法解析

```objc
- (void)setAngle:(CGFloat)angle magnitude:(CGFloat)magnitude;
```

- 主要用来: 设置重力行为的矢量角度和大小
- 参数 angle : 重力矢量的弧度,使用标准的 UIKit 几何.如果指定值 M_PI_2 ,也就是90°,那么就是创建一个力,将重力展示视图向下拖动到参考视图的底部.如果是M_PI_4,就是以45°来拖动.
- 参数 magnitude: 重力的大小.1.0则表示加速度为 1000 点/秒

5.其他说明

- UIKit Dynamics 使用自己的力学系统,被戏称为 UIKit 牛顿定律.(相当接近)
- magnitude的大小,1.0相当于地球引力.带来的加速度为 9.80655 m/s².
- 要指定大约1/10的地球引力.可将作用了设置为0.1
- 如果将 angle,设置为负值的话,那么就会向上拖动
- 本例向下设置,因为没有设置边界碰撞.这个物体不会与别的东西碰撞而停止下落,而是不断往下落

#### 2.碰撞

因为如果只有重力效果的话,那么到达底部的时候,不会停止.而是继续下落.

1.效果图

- 物体只与物体碰撞效果

![物体只与物体碰撞效果](/Users/Maty/Desktop/碰撞1.gif)

- 物体只与边界碰撞效果

![物体只与边界碰撞效果](/Users/Maty/Desktop/碰撞2.gif)

- 所有东西都可以碰撞(这种的话,两个视图要同时放在一个重力行为中,和一个碰撞行为中,重力和碰撞行为要放在一个力学动画生成器中.)

![所有东西都可以碰撞](/Users/Maty/Desktop/碰撞3.gif)

2.实现步骤

- 创建力学动画生成器 UIDynamicAnimator
- 创建重力行为对象.并设置其 item
- 创建碰撞行为对象,并设置其 item | collisionMode | 定义边界状态 | 代理

3.方法分析

1.碰撞行为模式一共有三种

- UICollisionBehaviorModeItems   			// 只能物体间碰撞
- UICollisionBehaviorModeBoundaries		// 只能与边界碰撞,不能与物体碰撞
- UICollisionBehaviorModeEverything		// 与所有东西都可以碰撞

2.如果让物体与边界碰撞,必须定义边界.

```objc
// 可以使用这个方法,激活边界
_collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
```

3.代理方法有4个

```objc
/**
 碰撞开始时调用.并指出了边界及接触点

 @param behavior 碰撞行为
 @param item 发生碰撞行为的视图
 @param identifier 接触的边界的标识
 @param p 接触点
 */
- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p {

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
```

#### 3.连接

1.概念

- 连接(attachment)指定了两个物体之间的动态连接.让一个物体的行为和移动受制于另一个物体的移动.
- 默认情况下, UIAttachmentBehaviors 将物体的中心指定为连接点,但可将任何点指定为连接点

2.效果图

![](/Users/Maty/Desktop/连接1.gif)


#### 4.弹簧效果

弹簧效果是对连接行为的扩展.如下看效果图.

![](/Users/Maty/Desktop/弹簧1.gif)

1.UIKitDynamics 让您能够修改 UIAttachmentBehavior 的其他属性,如振动频率和阻尼.

2.创建 `UIAttachmentBehavior` 对象后可设置了3个属性.

- 设置振动频率

```objc
setFrequency
```

- 熨平动画的峰值

```objc
setDamping
```

- 调整了连接的长度,使其不再是两个图像视图最初的距离.

```objc
setLength
```

3.为更好的延时这些行为,还添加了重力效果.

4.方法解析

```objc
/*
 * 方法目的 : 初始化动态项的中心附加到指定锚点的行为
 * 此方法创建的行为就像一个实心杆，将该项连接到指定的锚点。该项目可以自由地围绕锚点旋转，但它的距离锚定点仍然是固定的。
 * item : 动态项
 * point : 锚点
 */
- (instancetype)initWithItem:(id<UIDynamicItem>)item attachedToAnchor:(CGPoint)point;
```

5.弹簧效果与连接不同之处在于,三个设置选项

```objc
- (UIAttachmentBehavior *)attachmentBehavior {
    if (nil == _attachmentBehavior) {
        _attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.imageView_second attachedToAnchor:CGPointMake(self.imageView_first.center.x, self.imageView_first.center.y)];
        [_attachmentBehavior setFrequency:1.0f];    // 设置振动频率
        [_attachmentBehavior setDamping:0.1f];      // 熨平动画的峰值
        [_attachmentBehavior setLength:100.0f];     // 设置连接的长度
    }
    return _attachmentBehavior;
}
```

#### 5.吸附

吸附(snap)行为非常简单,它让物体动态地移到屏幕的另一个地方.

在示例应用中,这种行为是由轻按手势触发的.无论用户再屏幕的什么地方轻按,指定的视图都会跳到指定的地方.`每个 UISnapBehavior 都只与一个物体相关联.初始化 UISnapBehavior 时必须指定物体的移动重点.还可指定属性 damping,它决定了物体被吸附时的弹跳粒度`.

1.效果图

![](/Users/Maty/Desktop/吸附.gif)

2.注意点

- `如果要想达到如效果图那般连续的吸附行为,必须将之前的吸附行为从力学动画器中移除,然后再添加.否则不会有此效果`

3.代码示意

```objc
// 轻按手势监听方法
- (void)tapMethod:(UITapGestureRecognizer *)tap {
    CGPoint point = [tap locationInView:self.view];
    UISnapBehavior *snapBehavior = [[UISnapBehavior alloc] initWithItem:self.imageView_first snapToPoint:point];
    snapBehavior.damping = 0.75f;
    [self.dynamicAnimator removeAllBehaviors];  // 如果要进行连续的吸附行为,那么就必须把之前的吸附行为从力学动画器中移除
    [self.dynamicAnimator addBehavior:snapBehavior];
}
```

#### 6.推力

UIPushBehavior 使用其来要较之前的复杂一些.但与其他物理引擎相比还是非常容易的.

这里依然使用 collisionBehavior 行为,确保执行推力效果时图像视图始终在屏幕内.

1.效果图

![](/Users/Maty/Desktop/推力.gif)

2.计算

这里计算就较为复杂一些,用到一些函数

```objc
// 1.计算以 x 为底数的 y 次幂
double pow(double x, double y)

// 2.功能与 pow 一致.只是输入与输出皆为浮点数
float powf(float x, float y)

// 3.开平方
double sqrt (double)

// 4.反正切(整圆值),结果介于[-PI,PI]
double atan2(double, double)
```
3.点按手势监听代码

```objc

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
```

#### 7.物体属性

动态物体有很多默认的属性,我们可以对这些属性进行配置.以定制物理引擎对动态物体的影响.

1.效果图

![](/Users/Maty/Desktop/属性.gif)

2.各属性含义

```objc
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
```
