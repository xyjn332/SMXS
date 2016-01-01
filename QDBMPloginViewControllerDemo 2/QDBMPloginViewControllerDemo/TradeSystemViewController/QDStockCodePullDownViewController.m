//
//  QDStockCodePullDownViewController.m
//  QDBMPloginViewControllerDemo
//
//  Created by Weber on 15/8/11.
//  Copyright (c) 2015年 tsci. All rights reserved.
//

#import "QDStockCodePullDownViewController.h"

@interface QDStockCodePullDownViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)UITableView *showDataTableView;
@end

@implementation QDStockCodePullDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _showDataTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
}


- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.showDataTableView.frame = self.view.bounds;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
