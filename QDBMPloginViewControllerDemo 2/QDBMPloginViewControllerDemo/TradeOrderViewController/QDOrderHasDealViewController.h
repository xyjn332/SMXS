//
//  QDHasDealViewController.h
//  QDBMPloginViewControllerDemo
//
//  Created by Weber on 15/8/12.
//  Copyright (c) 2015年 tsci. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QDOrderHasDealViewDelegate <NSObject>

- (void)didSelectCellSendArry:(NSMutableArray *)arry andSendDic:(NSMutableDictionary *)dic;

@end

@interface QDOrderHasDealViewController : UIViewController

@property (nonatomic,assign)id<QDOrderHasDealViewDelegate>delegate;

@end
