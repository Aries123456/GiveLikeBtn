//
//  LKGiveLikeAnimate.m
//  TestBtn
//
//  Created by likun on 2020/8/26.
//  Copyright © 2020 likun. All rights reserved.
//

#import "LKGiveLikeAnimate.h"

#define DMRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define DMRandColor DMRGBColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))

@interface LKGiveLikeAnimate ()

@property (nonatomic, strong) UIImageView *contentImgV;
@property (nonatomic, assign) CGPoint sendCenter;

@end

@implementation LKGiveLikeAnimate

- (instancetype)initWithFrame:(CGRect)frame sendCenter:(CGPoint)sendCenter {
    self = [super initWithFrame:frame];
    if (self) {
        self.sendCenter = sendCenter;
        self.contentImgV = [[UIImageView alloc] initWithFrame:frame];
        int num = arc4random() % (5) + 1;
        self.contentImgV.image = [UIImage imageNamed:[NSString stringWithFormat:@"00%d",num]];
        [self addSubview:self.contentImgV];
        [self startAnimate];
    }
    return self;
}

- (void)startAnimate {
    NSTimeInterval totalAnimationDuration = 1;
    //图片尺寸
    CGFloat heartSize = CGRectGetWidth(self.bounds);
    //中心点
    CGFloat heartCenterX = self.sendCenter.x;

    //Pre-Animation setup
    self.transform = CGAffineTransformMakeScale(0, 0);
    self.alpha = 0;
    
    //Bloom
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 0.8;
    } completion:NULL];

    //随机的控制点
    NSInteger i = arc4random_uniform(2);
    NSInteger rotationDirection = 1 - (2*i);// -1 OR 1
        
    //固定的出发点(按钮中心)
    UIBezierPath *heartTravelPath = [UIBezierPath bezierPath];
    [heartTravelPath moveToPoint:self.sendCenter];

    //随机的终点(终点的宽度为2倍的图片宽度)
    CGPoint endPoint = CGPointMake(heartCenterX + (rotationDirection) * arc4random_uniform(2 * heartSize), self.sendCenter.y - 100);
    [heartTravelPath addLineToPoint:endPoint];

    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyFrameAnimation.path = heartTravelPath.CGPath;
    keyFrameAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    keyFrameAnimation.duration = totalAnimationDuration;
    [self.layer addAnimation:keyFrameAnimation forKey:@"positionOnPath"];
    
    //从父视图中移除
    [UIView animateWithDuration:totalAnimationDuration animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
