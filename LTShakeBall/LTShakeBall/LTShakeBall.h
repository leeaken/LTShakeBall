//
//  LTShakeBall.h
//  LTShakeBall
//
//  碰撞的小球
//  Created by aken on 2017/9/26.
//  Copyright © 2017年 aken. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

#define weakify(var) \
autoreleasepool {} \
__weak __typeof__(var) var ## _weak = var;

#define strongify(var) \
autoreleasepool {} \
__strong __typeof__(var) var = var ## _weak;

@interface LTShakeBall : UIView

// 是否可拖拽
@property (nonatomic, assign) BOOL isDragable;

// 速率
@property (nonatomic, assign) CGFloat velocity;

// 反弹速率,数字越小，反弹越小，反之就越大
@property (nonatomic, assign) CGFloat reduceSpeed;

// 设置球图片
- (void)setBallImage:(NSString*)imagePath;

// 开始滚动
- (void)start;

// 设置球半径
- (void)setBallRornerRadius:(CGFloat)radius;

@end
