//
//  QDTradeQueryBaseViewController.m
//  QDBMPloginViewControllerDemo
//
//  Created by Weber on 15/8/13.
//  Copyright (c) 2015年 tsci. All rights reserved.
//

#import "QDTradeQueryBaseViewController.h"
#import "Masonry.h"
#import "QDTradeQueryTableViewCell.h"
#import "QDTradeQueryTodayOrderViewController.h"
#import "QDTradeQueryTodayDelegateViewController.h"
#import "QDTradeQueryHistoryOrderViewController.h"
#import "QDTradeQueryHistoryDelegateViewController.h"



static const CGFloat TableViewRowHeight = 36;

@interface QDTradeQueryBaseViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UITableView *layoutTableView; //布局tableview
@property (nonatomic, strong) QDTradeQueryTodayOrderViewController *todayOrder; //今日成交
@property (nonatomic, strong) QDTradeQueryTodayDelegateViewController *todayDelegate; //今日委托
@property (nonatomic, strong) QDTradeQueryHistoryOrderViewController *historyOrder; //历史成交
@property (nonatomic, strong) QDTradeQueryHistoryDelegateViewController *historyDelegate;//历史委托


@end

@implementation QDTradeQueryBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initialize];
    
    [self createUI];
}

#pragma mark - initialize Data

- (void)initialize{
    _dataSource = [[NSMutableArray alloc] initWithCapacity:5];
    [_dataSource addObjectsFromArray:@[@"资金流水", @"当日委托", @"当日成交", @"历史委托", @"历史成交"]];
}

#pragma mark - createUI
- (void)createUI{
    _layoutTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.layoutTableView.delegate = self;
    self.layoutTableView.dataSource = self;
    self.layoutTableView.separatorInset = UIEdgeInsetsMake(0, AdjustWidth(38), 0, 0);
    [self.view addSubview:_layoutTableView];
  
    [_layoutTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
#pragma mark - tableview dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentifier = @"cellIndentifier";
    QDTradeQueryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if(cell == nil){
        cell = [[QDTradeQueryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.leftImageView.image = [UIImage imageNamed:@"search"];
        cell.textLabel.font = [UIFont systemFontOfSize:AdjustFontSize(15)];
    }
    @try {
        cell.textLabel.text = self.dataSource[indexPath.row];
    }
    @catch (NSException *exception) {
        NSLog(@"数组越界:%s", __FUNCTION__);
        cell.textLabel.text = @"😁";
    }


    
    return cell;
}

- (QDTradeQueryHistoryOrderViewController*)historyOrder{
    if(_historyOrder == nil){
        _historyOrder = [[QDTradeQueryHistoryOrderViewController alloc] init];
        _historyOrder.title = NSLocalizedString(@"历史成交", @"") ;
    }
    return _historyOrder;
}
- (QDTradeQueryHistoryDelegateViewController*)historyDelegate{
    if(_historyDelegate == nil){
        _historyDelegate = [[QDTradeQueryHistoryDelegateViewController alloc] init];
        _historyDelegate.title = NSLocalizedString(@"历史委托", @"");
    }
    return _historyDelegate;
}
- (QDTradeQueryTodayOrderViewController*)todayOrder{
    if(_todayOrder == nil){
        _todayOrder = [[QDTradeQueryTodayOrderViewController alloc] init];
        _todayOrder.title = NSLocalizedString(@"当日成交", @"");
    }
    return _todayOrder;
}
- (QDTradeQueryTodayDelegateViewController*)todayDelegate{
    if(_todayDelegate == nil){
        _todayDelegate = [[QDTradeQueryTodayDelegateViewController alloc] init];
        _todayDelegate.title = NSLocalizedString(@"当日委托", @"");
    }
    return _todayDelegate;
}

#pragma mark - tableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdjustHeight(TableViewRowHeight);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if( [((NSString*)self.dataSource[indexPath.row]) isEqualToString:NSLocalizedString(@"当日委托", @"")]){
        [self.navigationController pushViewController:self.todayDelegate animated:YES];
    }else if( [((NSString*)self.dataSource[indexPath.row]) isEqualToString:NSLocalizedString(@"当日成交", @"")]){
        [self.navigationController pushViewController:self.todayOrder animated:YES];
    }else if( [((NSString*)self.dataSource[indexPath.row]) isEqualToString:NSLocalizedString(@"历史委托", @"")]){
        [self.navigationController pushViewController:self.historyDelegate animated:YES];
    }else if( [((NSString*)self.dataSource[indexPath.row]) isEqualToString:NSLocalizedString(@"历史成交", @"")]){
        [self.navigationController pushViewController:self.historyOrder animated:YES];
    }

    [self.layoutTableView deselectRowAtIndexPath:indexPath animated:YES];
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
