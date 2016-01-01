//
//  QDTradeQueryTodayDelegateViewController.m
//  QDBMPloginViewControllerDemo
//
//  Created by Weber on 15/8/14.
//  Copyright (c) 2015年 tsci. All rights reserved.
//

#import "QDTradeQueryTodayDelegateViewController.h"
#import "QDOrdelNavigationController.h"
#import "NAViewController.h"

static const CGFloat TableViewRowHeight = 45;
static const CGFloat TableViewSectionHeight = 30;

@interface QDTradeQueryTodayDelegateViewController ()<UITableViewDataSource, UITableViewDelegate>
@end

@implementation QDTradeQueryTodayDelegateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initialize];
    
    [self createUI];
}



#pragma mark - initialize Data
- (void)initialize{
    _titleArray = [NSMutableArray arrayWithCapacity:10];
    NSArray *tempArray = @[
                           @{@(tTodayDelegateM_Name):@"名称", @(tTodayDelegaterM_DealTime):@"时间"},
                           @{@(tTodayDelegateM_Price):@"委托价", @(tTodayDelegateM_Action):@"操作"},
                           @{@(tTodayDelegateM_Delegate):@"委托", @(tTodayDelegateM_HBCJSL):@"成交量"},
                           @{@(tTodayDelegaterM_Status):@"状态"}
                           ];
    
    [_titleArray addObjectsFromArray:tempArray];
}

#pragma mark - createUI
- (void)createUI{
    _todayDelegateTableView = [UITableView new];
    _todayDelegateTableView.delegate = self;
    _todayDelegateTableView.dataSource = self;
    _todayDelegateTableView.frame = self.view.bounds;
    _todayDelegateTableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_todayDelegateTableView];
}



#pragma mark - tableview dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentifier = @"cellIndentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if(cell == nil){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        cell.backgroundColor = UIColorFromRGBA(0xeef2f6, 1.0);
        
        CGSize dateSize = [QDTool getStringSizeWithString:@"2015-06-25" font:[UIFont systemFontOfSize:AdjustFontSize(10)] lableHeight:1000 width:1000];
        CGSize timeSize = [QDTool getStringSizeWithString:@"14:20:30" font:[UIFont systemFontOfSize:AdjustFontSize(10)] lableHeight:1000 width:1000];
        UILabel *stockName = [QDTool createLabelWithFrame:CGRectMake(AdjustWidth(2), AdjustHeight(1.5), dateSize.width+timeSize.width+AdjustWidth(2.5), AdjustHeight(15.5)) fontColor:[UIColor blackColor] fontSize:AdjustFontSize(12) textAligment:NSTextAlignmentLeft];
        stockName.tag = 20001;
        
        [cell.contentView addSubview:stockName];
        
        UIImageView *flagImg = [[UIImageView alloc] initWithFrame:CGRectMake(AdjustWidth(2), CGRectGetMaxY(stockName.frame)+AdjustHeight(2.5), AdjustWidth(12), AdjustHeight(10))];
        flagImg.tag = 20002;
        flagImg.image = [UIImage imageNamed:@"comm_market_type_hk"];
        [cell.contentView addSubview:flagImg];
        UILabel *stokCode = [QDTool createLabelWithFrame:CGRectMake(CGRectGetMaxX(flagImg.frame), flagImg.frame.origin.y, (ScreenWidth-AdjustWidth(2)*2-AdjustWidth(130)-AdjustWidth(30))/2-CGRectGetMaxX(flagImg.frame), flagImg.frame.size.height) fontColor:UIColorFromRGBA(0x676767, 1.0) fontSize:AdjustFontSize(10) textAligment:NSTextAlignmentLeft];
        stokCode.tag = 20003;
        
        [cell.contentView addSubview:stokCode];
        
        UILabel *date = [QDTool createLabelWithFrame:CGRectMake(stockName.frame.origin.x, CGRectGetMaxY(flagImg.frame)+AdjustHeight(2.5), dateSize.width, dateSize.height) fontColor:UIColorFromRGBA(0x676767, 1.0) fontSize:AdjustFontSize(10) textAligment:NSTextAlignmentRight];
        date.tag = 20004;
        
        [cell.contentView addSubview:date];
        
        UILabel *time = [QDTool createLabelWithFrame:CGRectMake(CGRectGetMaxX(date.frame)+AdjustWidth(2.5), CGRectGetMaxY(flagImg.frame)+AdjustHeight(2.5), timeSize.width, timeSize.height) fontColor:UIColorFromRGBA(0x676767, 1.0) fontSize:AdjustFontSize(10) textAligment:NSTextAlignmentRight];
        time.tag = 20005;
        
        [cell.contentView addSubview:time];
        
        
        UILabel *delegatePrice =  [QDTool createLabelWithFrame:CGRectMake(CGRectGetMaxX(time.frame), AdjustHeight(7.5), (ScreenWidth/2-CGRectGetMaxX(time.frame))+AdjustWidth(2.5), AdjustHeight(15.5)) fontColor:[UIColor blackColor] fontSize:AdjustFontSize(14) textAligment:NSTextAlignmentRight];
        delegatePrice.tag = 20006;
        
        [cell.contentView addSubview:delegatePrice];
        
        UILabel *avgPrice = [QDTool createLabelWithFrame:CGRectMake(delegatePrice.frame.origin.x, CGRectGetMaxY(delegatePrice.frame)+AdjustHeight(4), delegatePrice.frame.size.width, flagImg.frame.size.height) fontColor:UIColorFromRGBA(0x676767, 1.0) fontSize:AdjustFontSize(10) textAligment:NSTextAlignmentRight];
        avgPrice.tag = 20007;
        
        [cell.contentView addSubview:avgPrice];
        
        
        UILabel *quantity = [QDTool createLabelWithFrame:CGRectMake(CGRectGetMaxX(delegatePrice.frame)+AdjustWidth(10), AdjustHeight(7.5), AdjustWidth(125)/2, delegatePrice.frame.size.height) fontColor:[UIColor blackColor] fontSize:AdjustFontSize(14) textAligment:NSTextAlignmentRight];
        quantity.tag = 20008;
        [cell.contentView addSubview:quantity];
        
        UILabel *delegate = [QDTool createLabelWithFrame:CGRectMake(quantity.frame.origin.x, avgPrice.frame.origin.y, quantity.frame.size.width, flagImg.frame.size.height) fontColor:UIColorFromRGBA(0x676767, 1.0) fontSize:AdjustFontSize(10) textAligment:NSTextAlignmentRight];
        delegate.tag = 20009;
        [cell.contentView addSubview:delegate];
        
        UILabel *staticStatus = [QDTool createLabelWithFrame:CGRectMake(CGRectGetMaxX(quantity.frame)+AdjustWidth(15), delegatePrice.frame.origin.y, quantity.frame.size.width+AdjustWidth(5), quantity.frame.size.height) fontColor:[UIColor blackColor] fontSize:AdjustFontSize(14) textAligment:NSTextAlignmentRight];
        staticStatus.tag = 20010;
        [cell.contentView addSubview:staticStatus];
        
        UILabel *status = [QDTool createLabelWithFrame:CGRectMake(staticStatus.frame.origin.x, avgPrice.frame.origin.y, staticStatus.frame.size.width, flagImg.frame.size.height) fontColor:UIColorFromRGBA(0x676767, 1.0) fontSize:AdjustFontSize(10) textAligment:NSTextAlignmentRight];
        status.tag = 20011;
        [cell.contentView addSubview:status];
    }

    UILabel *stockName = (UILabel*)[cell viewWithTag:20001];
    UILabel *stockCode = (UILabel*)[cell viewWithTag:20003];
    UILabel *date = (UILabel*)[cell viewWithTag:20004];
    UILabel *time = (UILabel*)[cell viewWithTag:20005];

    UILabel *delegatPrice = (UILabel*)[cell viewWithTag:20006];
    UILabel *action = (UILabel*)[cell viewWithTag:20007];
    stockName.text = @"新世界发展";
    stockCode.text = @"00017";
    delegatPrice.text = @"0.900";
    date.text = @"2015-06-01";
    time.text = @"13.45:30";

    UILabel *delegate = (UILabel*)[cell viewWithTag:20008];
    UILabel *quantity = (UILabel*)[cell viewWithTag:20009];
    UILabel *status = (UILabel*)[cell viewWithTag:20010];
    UILabel *type = (UILabel*)[cell viewWithTag:20011];
    delegate.text = @"2000";
    quantity.text = @"1000";
    status.text = @"部分成交";
    type.text = @"增强限价盘";



    if(indexPath.row %2 ==0){
        delegatPrice.textColor = action.textColor = UIColorFromRGBA(0x1a90f0, 1.0);
        action.text = @"卖出";
        
    }
    else{
        delegatPrice.textColor =  action.textColor = UIColorFromRGBA(0xcb271b, 1.0);
        action.text = @"买入";
    }


    return cell;
}


#pragma mark - tableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdjustHeight(TableViewRowHeight);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return AdjustHeight(TableViewSectionHeight);
}
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dicFootInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                 @"0.001",[NSNumber numberWithInt:BrokerageFee],
                                 @"0.002",[NSNumber numberWithInt:TradingImpost],
                                 @"0.003",[NSNumber numberWithInt:TradingFee],
                                 @"0.004",[NSNumber numberWithInt:TradingSystemUsingFee],
                                 @"0.005",[NSNumber numberWithInt:StockSettlementFee],
                                 @"0.006",[NSNumber numberWithInt:StockStampFee],
                                 @"0.007",[NSNumber numberWithInt:InvestorCompensateImpost],
                                 @"0.008",[NSNumber numberWithInt:ResaleStampFee],
                                 @"0.009",[NSNumber numberWithInt:AssignedOtherFee],nil];
    NSDictionary *dicTopInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                 @"HKATTTT001.0152",[NSNumber numberWithInt:CostomerNumber],
                                 @"竞价限价盘",[NSNumber numberWithInt:DelegationType],
                                 @"买入",[NSNumber numberWithInt:SecurityOperate],
                                 @"156.00",[NSNumber numberWithInt:DelegationPrice],
                                 @"00700",[NSNumber numberWithInt:SecurityCode],
                                 @"1500",[NSNumber numberWithInt:DelegationQuantity],
                                 @"腾讯控股",[NSNumber numberWithInt:SecurityName],
                                 @"234.00",[NSNumber numberWithInt:TradingAmount],nil];
    NAViewController *NA = [[NAViewController alloc]initWithData:dicTopInfo andFootdict:dicFootInfo orderType:tradeSystem_Buy_describe];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:NA];
    [self.navigationController presentViewController:nav animated:YES completion:^{
    }];
//    [self.navigationController pushViewController:NA animated:YES];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(self.tableViewSectionHeadView == nil){
        _tableViewSectionHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, AdjustHeight(TableViewSectionHeight))];
        _tableViewSectionHeadView.backgroundColor = UIColorFromRGBA(0xeef2f6, 1.0);
        
        UIControl *background1 = [QDTool createTitleNameWithTitleArray:self.titleArray height:TableViewSectionHeight position:AdjustWidth(2) isFist:NO index:0 fontSize:AdjustFontSize(10)];
        [background1 addTarget:self action:@selector(holdingTitleAction:) forControlEvents:UIControlEventTouchUpInside];
        [_tableViewSectionHeadView addSubview:background1];
        
        UIControl *background2 = [QDTool createTitleNameWithTitleArray:self.titleArray height:TableViewSectionHeight position:CGRectGetMaxX(background1.frame)+AdjustWidth(58) isFist:YES index:1 fontSize:AdjustFontSize(10)];
        [background2 addTarget:self action:@selector(holdingTitleAction:) forControlEvents:UIControlEventTouchUpInside];
        [_tableViewSectionHeadView addSubview:background2];
        
        UIControl *background3 = [QDTool createTitleNameWithTitleArray:self.titleArray height:TableViewSectionHeight position:CGRectGetMaxX(background2.frame)+AdjustWidth(12) isFist:YES index:2 fontSize:AdjustFontSize(10)];
        [background3 addTarget:self action:@selector(holdingTitleAction:) forControlEvents:UIControlEventTouchUpInside];
        [_tableViewSectionHeadView addSubview:background3];
        
        
        UIControl *background4 = [QDTool createTitleNameWithTitleArray:self.titleArray height:TableViewSectionHeight position:CGRectGetMaxX(background3.frame)+AdjustWidth(53.5) isFist:YES index:3 fontSize:AdjustFontSize(10)];
        [_tableViewSectionHeadView addSubview:background4];
    }
    
    
    return self.tableViewSectionHeadView;
    
}



#pragma mark - button Action

- (void)holdingTitleAction:(UIControl*)btn{
    static short count = 0;
    static UIControl *oldControl;
    UILabel *firstLabel = (UILabel*)[btn viewWithTag:10001];
    UILabel *secondLabel = (UILabel*)[btn viewWithTag:10002];
    UIImageView *acsendingImg = (UIImageView*)[btn viewWithTag:10003];
    UIImageView *descendingImg = (UIImageView*)[btn viewWithTag:10004];
    UIImageView *arrowImg = (UIImageView*)[btn viewWithTag:10005];
    
    if([secondLabel.text isEqualToString:self.titleArray[0][@(tTodayDelegaterM_DealTime)]])
        firstLabel = secondLabel;
    
    if(++count>2 ){
        count = 0;
    }
    
    if(oldControl != nil && btn != oldControl){
        count = 1;
    }
    switch (count) {
        case 0:
        {
            firstLabel.textColor = UIColorFromRGBA(0x676767, 1.0);
            acsendingImg.hidden = YES;
            descendingImg.hidden = YES;
            
            arrowImg.hidden = NO;
        }
            break;
        case 1:
        {
            firstLabel.textColor = UIColorFromRGBA(0x62a0ee, 1.0);
            acsendingImg.hidden = NO;
            descendingImg.hidden = YES;
            arrowImg.hidden = YES;
            NSArray *subviews = [[btn superview] subviews];
            for(UIControl *control in subviews){
                if(![control isEqual:btn])
                    [self resetControlState:control];
            }
            
            //            [[QDStockSingletonConfigTools sharedManager] holdingSortByWitchOne:firstLabel.text orderby:YES];
            
        }
            break;
        case 2:
        {
            firstLabel.textColor = UIColorFromRGBA(0x62a0ee, 1.0);
            acsendingImg.hidden = YES;
            descendingImg.hidden = NO;
            arrowImg.hidden = YES;
//            [[QDStockSingletonConfigTools sharedManager] holdingSortByWitchOne:firstLabel.text orderby:NO];
        }
            break;
            
        default:
            break;
    }
    oldControl = btn;
}

- (void)resetControlState:(UIControl*)control{
    UILabel *firstLabel = (UILabel*)[control viewWithTag:10001];
    UILabel *secondLabel = (UILabel*)[control viewWithTag:10002];
    UIImageView *acsendingImg = (UIImageView*)[control viewWithTag:10003];
    UIImageView *descendingImg = (UIImageView*)[control viewWithTag:10004];
    UIImageView *arrowImg = (UIImageView*)[control viewWithTag:10005];
    
    if([secondLabel.text isEqualToString:self.titleArray[0][@(tTodayDelegaterM_DealTime)]]){
        firstLabel = secondLabel;
    }
    
    firstLabel.textColor = UIColorFromRGBA(0x676767, 1.0);
    acsendingImg.hidden = YES;
    descendingImg.hidden = YES;
    arrowImg.hidden = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
