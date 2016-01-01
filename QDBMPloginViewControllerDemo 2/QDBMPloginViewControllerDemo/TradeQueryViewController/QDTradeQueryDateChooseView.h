//
//  QDTradeQueryDateChooseView.h
//  QDBMPloginViewControllerDemo
//
//  Created by Weber on 15/8/15.
//  Copyright (c) 2015年 tsci. All rights reserved.
//  日期选择器

#import <UIKit/UIKit.h>
#import "FlatDatePicker/FlatDatePicker.h"

@protocol QDTradeQueryDateChooseViewDelegate <NSObject>

@end


@class FlatDatePicker;
@interface QDTradeQueryDateChooseView : UIView

@property(nonatomic, weak)id<QDTradeQueryDateChooseViewDelegate> delegate;
@property (nonatomic, strong)NSDate *startDate;
@property (nonatomic, strong)NSDate *endDate;
//时间选择器
@property (nonatomic, strong)   FlatDatePicker          *flatDatePicker;
@property (nonatomic)BOOL hasShowFlatDatePicker;

@end
