//
//  QDTradeQueryHistoryOrderViewController.m
//  QDBMPloginViewControllerDemo
//
//  Created by Weber on 15/8/14.
//  Copyright (c) 2015年 tsci. All rights reserved.
//

#import "QDTradeQueryHistoryOrderViewController.h"
#import "QDTradeQueryDateChooseView.h"

@interface QDTradeQueryHistoryOrderViewController ()


@end

@implementation QDTradeQueryHistoryOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    QDTradeQueryDateChooseView *dateChooseView = [[QDTradeQueryDateChooseView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, AdjustHeight(51))];
    dateChooseView.tag = 11111;
    [self.view addSubview:dateChooseView];
    self.todayOrderTableView.frame = CGRectMake(0, CGRectGetMaxY(dateChooseView.frame), ScreenWidth, self.view.frame.size.height-dateChooseView.frame.size.height);
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    QDTradeQueryDateChooseView *dateChooseView = (QDTradeQueryDateChooseView*)[self.view viewWithTag:11111];
    if(dateChooseView.hasShowFlatDatePicker){
        [dateChooseView.flatDatePicker dismiss];
        dateChooseView.hasShowFlatDatePicker = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
