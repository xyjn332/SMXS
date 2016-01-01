//
//  QDOrderBaseViewController.m
//  QDBMPloginViewControllerDemo
//
//  Created by Weber on 15/8/12.
//  Copyright (c) 2015年 tsci. All rights reserved.
// 订单的承载页面

#import "QDOrderBaseViewController.h"
#import "QDOrderCannotDealViewController.h"
#import "QDOrderHasDealViewController.h"
#import "Masonry.h"
#import "OrdelDetailViewController.h"

@interface QDOrderBaseViewController ()<QDOrderHasDealViewDelegate>
@property (nonatomic, strong)QDOrderHasDealViewController *hasDealViewController;
@property (nonatomic, strong)QDOrderCannotDealViewController *cannotDealViewController;
@end

@implementation QDOrderBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self initialize];
    
    [self createUI];
}

#pragma mark - initialize Data

- (void)initialize{
    
}
#pragma mark - createUI
- (void)createUI{

    _cannotDealViewController = [[QDOrderCannotDealViewController alloc] init];;
    [self.view addSubview:_cannotDealViewController.view];
    
    _hasDealViewController = [[QDOrderHasDealViewController alloc] init];
    _hasDealViewController.delegate = self;
    [self.view addSubview:_hasDealViewController.view];

    
    WS(ws);
    [_cannotDealViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.view.mas_left);
        make.right.equalTo(ws.view.mas_right);
        make.top.equalTo(ws.view.mas_top);
        make.height.equalTo(ws.hasDealViewController.view.mas_height);
         make.bottom.equalTo(ws.hasDealViewController.view.mas_top);
    }];
    [_hasDealViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.view.mas_left);
        make.right.equalTo(ws.view.mas_right);
        make.height.equalTo(ws.cannotDealViewController.view.mas_height);
        make.top.equalTo(ws.cannotDealViewController.view.mas_bottom);
        make.bottom.equalTo(ws.view.mas_bottom);
    }];
}

- (void)didSelectCellSendArry:(NSMutableArray *)arry andSendDic:(NSMutableDictionary *)dic{
    OrdelDetailViewController *VC = [[OrdelDetailViewController alloc]init];
    VC.title = @"订单详情";
    if (arry!=nil) VC.arry = arry;        
    if (dic!=nil)  VC.dic  = dic;
    [self.navigationController pushViewController:VC animated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    NSLog(@"%s", __func__);
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
