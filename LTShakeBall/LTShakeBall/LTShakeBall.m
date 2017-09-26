//
//  LTShakeBall.m
//  LTShakeBall
//
//  Created by aken on 2017/9/26.
//  Copyright © 2017年 aken. All rights reserved.
//

#import "LTShakeBall.h"
#import "UIView+Extension.h"

@interface LTShakeBall()
{
    BOOL isDragging;
}

@property (nonatomic, assign) CGFloat accelerationX;

@property (nonatomic, assign) CGFloat accelerationY;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) CMMotionManager *motionManager;

@end

@implementation LTShakeBall

-(id)initWithFrame:(CGRect)frame {

    if(self = [super initWithFrame:frame]){

        self.isDragable = NO;
        isDragging = NO;
        self.velocity=20;
        self.reduceSpeed = 1;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {

    self.imageView.frame = self.bounds;
    [self addSubview:self.imageView];


}

- (void)dealloc {

    [self stopAccelerometerUpdate];

    if (_motionManager) {
        _motionManager =  nil;
    }
}


#pragma mark - Public

- (void)start  {

    // shake
    self.motionManager = [[CMMotionManager alloc] init];

    if (self.motionManager.accelerometerAvailable) {

        @weakify(self)
        self.motionManager.deviceMotionUpdateInterval = 1.0 / 60.0;//0.1;
        [self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue]
                                                withHandler:^(CMDeviceMotion *motion, NSError *error) {

                                                    @strongify(self)
                                                    [self motionMethod:motion];
                                                }];
    }


}

- (void)stopAccelerometerUpdate {

    [self.motionManager stopAccelerometerUpdates];
}

- (void)setBallImage:(NSString*)imagePath {

    self.imageView.image = [UIImage imageNamed:imagePath];
}

- (void)setBallRornerRadius:(CGFloat)radius {

    self.imageView.layer.cornerRadius = radius;
}

#pragma mark - Private

-(void)motionMethod:(CMDeviceMotion *)deviceMotion {

    [self collisionView:self acceleration:deviceMotion];
}

- (void)collisionView:(LTShakeBall*)collisionView acceleration:(CMDeviceMotion*)deviceMotion {

    collisionView.accelerationX += deviceMotion.userAcceleration.x * deviceMotion.gravity.x * 3;
    collisionView.accelerationY += deviceMotion.userAcceleration.y * deviceMotion.gravity.y * -2;


    collisionView.x +=collisionView.accelerationX * self.velocity;
    collisionView.y +=collisionView.accelerationY * self.velocity;

    UIView *parentView=[self superview];

    //边界检测
    if(collisionView.x <= 0) {

        collisionView.x = 0;
        //加入反弹，削弱速度
        collisionView.accelerationX *= -0.8 * self.reduceSpeed;
    }
    if (collisionView.y <= 64) {

        collisionView.y = 64;
        collisionView.accelerationY *= -0.8 * self.reduceSpeed;
    }
    if (collisionView.maxX >= parentView.width) {

        collisionView.maxX = parentView.width;
        collisionView.accelerationX *= -0.8 * self.reduceSpeed;
    }
    if (collisionView.maxY >= parentView.height) {

        collisionView.maxY = parentView.height;
        collisionView.accelerationY *= -0.8 * self.reduceSpeed;
    }
}

#pragma mark - Delegate

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if(!self.isDragable)
        return;
    isDragging = YES;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if(!self.isDragable)
        return;

    UITouch *touch = [touches anyObject];
    CGPoint currentTouch = [touch locationInView:[self superview]];
    [self setFrame:CGRectMake(currentTouch.x, currentTouch.y, self.frame.size.width, self.frame.size.height)];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent*)event{

    if(!self.isDragable)
        return;
    isDragging = NO;
}


#pragma mark - Getters

- (UIImageView *)imageView {

    if (!_imageView) {

        _imageView=[[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.userInteractionEnabled = YES;
        _imageView.layer.cornerRadius = 50;
        _imageView.layer.masksToBounds = YES;
    }

    return _imageView;
}

@end


