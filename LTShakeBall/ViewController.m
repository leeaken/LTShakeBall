//
//  ViewController.m
//  LTShakeBall
//
//  Created by aken on 2017/9/26.
//  Copyright © 2017年 aken. All rights reserved.
//

#import "ViewController.h"
#import "ShakeVC.h"

@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)shakeClick:(id)sender {

    ShakeVC *shakeVC = [[ShakeVC alloc] init];
    [self.navigationController pushViewController:shakeVC animated:YES];
}

@end
