//
//  ViewController.h
//  QDBMPloginViewControllerDemo
//
//  Created by Weber on 15/6/24.
//  Copyright (c) 2015年 tsci. All rights reserved.
//  资金界面

#import <UIKit/UIKit.h>

@interface QDTradeCashViewController : UIViewController


@property (nonatomic, strong)NSMutableDictionary *dataSouce;//总的数据源
@property (nonatomic)BOOL isBankTransaction; //是否有银证转账


@end

