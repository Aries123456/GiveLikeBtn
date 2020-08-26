//
//  LKGiveLikeAnimate.h
//  TestBtn
//
//  Created by likun on 2020/8/26.
//  Copyright © 2020 likun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LKGiveLikeAnimate : UIImageView

- (instancetype)initWithFrame:(CGRect)frame sendCenter:(CGPoint)sendCenter;

- (void)startAnimate;

@end

NS_ASSUME_NONNULL_END
