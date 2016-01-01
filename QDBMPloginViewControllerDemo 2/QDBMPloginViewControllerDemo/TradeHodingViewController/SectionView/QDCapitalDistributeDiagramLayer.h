//
//  QDCapitalDistributeDiagramLayer.h
//  QDBMPloginViewControllerDemo
//
//  Created by Weber on 15/7/3.
//  Copyright (c) 2015年 tsci. All rights reserved.
//  自定义layer，用来画扇形图的

#import <QuartzCore/QuartzCore.h>

@interface QDCapitalDistributeDiagramLayer : CALayer
@property (nonatomic) CGFloat leftTotal; //账面结余
@property (nonatomic) CGFloat freezeCapital; //冻结资金
@property (nonatomic) CGFloat totalMarketValue; //总市值
@end
