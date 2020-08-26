//
//  ViewController.m
//  TestBtn
//
//  Created by likun on 2020/8/26.
//  Copyright © 2020 likun. All rights reserved.
//

#import "ViewController.h"
#import "LKGiveLikeAnimate.h"

@interface ViewController ()

@property (nonatomic, strong) NSTimer *burstTimer;
@property (nonatomic, strong) UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.frame = CGRectMake(self.view.center.x, self.view.center.y, 18, 18);
    [btn setBackgroundImage:[UIImage imageNamed:@"000"] forState:(UIControlStateNormal)];
    [btn setBackgroundImage:[UIImage imageNamed:@"001"] forState:(UIControlStateSelected)];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    self.btn = btn;
}

- (void)btnAction:(UIButton *)sender {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    if (sender.selected) {
        sender.selected = NO;
    } else {
        sender.selected = YES;
        animation.values = @[@1.0, @1.5 ,@2.5, @1.5,@1.0];
        animation.duration = 0.2;
        animation.calculationMode = kCAAnimationCubic;
        [sender.layer addAnimation:animation forKey:@"transform.scale"];
        
        __weak typeof(self) weakSelf = self;
        _burstTimer = [NSTimer scheduledTimerWithTimeInterval:0.12 target:self selector:@selector(showTheLove) userInfo:nil repeats:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.burstTimer invalidate];
            weakSelf.burstTimer = nil;
        });
    }
}

- (void)showTheLove {
    LKGiveLikeAnimate *giveLike = [[LKGiveLikeAnimate alloc]initWithFrame:CGRectMake(0, 0, 18, 18) sendCenter:CGPointMake(self.btn.center.x, self.btn.center.y)];
    [self.view addSubview:giveLike];
}

@end
