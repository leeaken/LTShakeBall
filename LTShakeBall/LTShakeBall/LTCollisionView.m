//
//  LTCollisionView.m
//  LTShakeBall
//
//  Created by aken on 2017/9/26.
//  Copyright © 2017年 aken. All rights reserved.
//

#import "LTCollisionView.h"
#import <CoreMotion/CoreMotion.h>
#import "LTShakeBall.h"

static  NSInteger const maxBallCount = 5;

@interface LTCollisionView()

// 球的加速度
@property (nonatomic, strong) NSArray *ballVelocityArray;

// 球的减速
@property (nonatomic, strong) NSArray *ballReduceSpeedArray;

// 球的大小
@property (nonatomic, strong) NSArray *ballSizeArray;

// 球的图片名称
@property (nonatomic, strong) NSArray *ballImageNameArray;

@end

@implementation LTCollisionView

- (id)initWithFrame:(CGRect)frame {

    self=[super initWithFrame:frame];

    if (self) {

        [self setupUI];
        [self addGravityBalls];
    }

    return self;
}

- (void)dealloc {

    _ballVelocityArray=nil;
    _ballReduceSpeedArray=nil;
    _ballImageNameArray = nil;
    _ballSizeArray = nil;
}

- (void)setupUI {

    self.ballVelocityArray=@[@20.2,@20.8,@21.0,@21.8,@22];
    self.ballReduceSpeedArray=@[@1.02,@1.01,@1.05,@1.06,@1.07];

    self.ballSizeArray=@[@61,@41,@128,@41,@168];
    self.ballImageNameArray=@[@"ball1",@"ball2",@"ball3",@"ball2",@"ball3"];

}

- (void)addGravityBalls {

    [self removeAllBall];

    NSInteger maxCount = MIN(maxBallCount, self.ballSizeArray.count);
    for (int i = 0; i < maxCount; i++) {

        int width=[self.ballSizeArray[i] intValue];
        LTShakeBall *ball=[[LTShakeBall alloc] initWithFrame:CGRectMake(arc4random()%10/10.0 * 200,
                                                                          0,
                                                                          width, width)];
        [ball setBallImage:self.ballImageNameArray[i]];
        [ball setBallRornerRadius:width/2];
        [self addSubview:ball];

        [ball start];

    }
}

- (void)removeAllBall {

    for (UIView *v in self.subviews) {

        if (v) {
            [v removeFromSuperview];
        }
    }
}

@end


