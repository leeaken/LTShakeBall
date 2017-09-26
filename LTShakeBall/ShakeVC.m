//
//  ShakeVC.m
//  LTShakeBall
//
//  Created by aken on 2017/9/26.
//  Copyright © 2017年 aken. All rights reserved.
//

#import "ShakeVC.h"
#import "LTCollisionView.h"

@interface ShakeVC ()

@property (nonatomic, strong) LTCollisionView *collView;

@end

@implementation ShakeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (LTCollisionView *)collView {

    if (!_collView) {

        _collView = [[LTCollisionView alloc] initWithFrame:self.view.bounds];
    }

    return _collView;
}

@end
