//
//  QDTradeSettingViewController.h
//  QDBMPloginViewControllerDemo
//
//  Created by Weber on 15/7/22.
//  Copyright (c) 2015年 tsci. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QDTradeSetingViewControllerDelegate

- (void)panGestureWillEnd:(BOOL)isIn byRate:(CGFloat)rate; //pan 将要结束，并且要有个变化率
- (void)panGestureDidEnd:(BOOL)isIn; //pan已经结束

@end

@interface QDTradeSettingViewController : UIViewController
@property (nonatomic, weak)id <QDTradeSetingViewControllerDelegate>delegate;

@end
