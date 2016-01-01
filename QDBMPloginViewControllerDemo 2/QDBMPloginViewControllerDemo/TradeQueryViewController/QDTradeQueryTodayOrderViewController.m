//
//  QDTradeQueryTodayOrderViewController.m
//  QDBMPloginViewControllerDemo
//
//  Created by Weber on 15/8/13.
//  Copyright (c) 2015年 tsci. All rights reserved.
//

#import "QDTradeQueryTodayOrderViewController.h"
#import "Masonry.h"

static const CGFloat TableViewRowHeight = 41;
static const CGFloat TableViewSectionHeight = 30;

@interface QDTradeQueryTodayOrderViewController ()



@end

@implementation QDTradeQueryTodayOrderViewController

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
                           @{@(tTodayOderM_Name):@"证券名称"},//证券名称
                           @{@(tTodayOderM_Price):@"价格*", @(tTodayOderM_Action):@"操作"}, //价格, 操作
                           @{@(tTodayOderM_HBCJSL):@"成交数量"},//成交数量
                           @{@(tTodayOderM_DealTime):@"成交时间"} //成交时间
                           ];
    
    [_titleArray addObjectsFromArray:tempArray];
}

#pragma mark - createUI
- (void)createUI{
    _todayOrderTableView = [UITableView new];
    _todayOrderTableView.delegate = self;
    _todayOrderTableView.dataSource = self;
    _todayOrderTableView.frame = self.view.bounds;
    _todayOrderTableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_todayOrderTableView];
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
        UILabel *stockName = [QDTool createLabelWithFrame:CGRectMake(AdjustWidth(2), AdjustHeight(7.5), (ScreenWidth-AdjustWidth(2)-AdjustWidth(5)-AdjustWidth(125)-AdjustWidth(30))/2, AdjustHeight(15.5)) fontColor:[UIColor blackColor] fontSize:AdjustFontSize(12) textAligment:NSTextAlignmentLeft];
        stockName.tag = 20001;
        [cell.contentView addSubview:stockName];
        UIImageView *flagImg = [[UIImageView alloc] initWithFrame:CGRectMake(AdjustWidth(2), CGRectGetMaxY(stockName.frame)+AdjustHeight(2.5), AdjustWidth(12), AdjustHeight(10))];
        flagImg.tag = 20002;
        flagImg.image = [UIImage imageNamed:@"comm_market_type_hk"];
        [cell.contentView addSubview:flagImg];
        UILabel *stokCode = [QDTool createLabelWithFrame:CGRectMake(CGRectGetMaxX(flagImg.frame), flagImg.frame.origin.y, (ScreenWidth-AdjustWidth(2)*2-AdjustWidth(125)-AdjustWidth(30))/2-CGRectGetMaxX(flagImg.frame), flagImg.frame.size.height) fontColor:UIColorFromRGBA(0x676767, 1.0) fontSize:AdjustFontSize(10) textAligment:NSTextAlignmentLeft];
        stokCode.tag = 20003;
        
        [cell.contentView addSubview:stokCode];
        
        UILabel *delegatePrice =  [QDTool createLabelWithFrame:CGRectMake(CGRectGetMaxX(stockName.frame), AdjustHeight(7.5), (ScreenWidth-AdjustWidth(2)-AdjustWidth(5)-AdjustWidth(130)-AdjustWidth(30))/2, AdjustHeight(15.5)) fontColor:[UIColor blackColor] fontSize:AdjustFontSize(14) textAligment:NSTextAlignmentRight];
        delegatePrice.tag = 20004;
        
        [cell.contentView addSubview:delegatePrice];
        UILabel *avgPrice = [QDTool createLabelWithFrame:CGRectMake(delegatePrice.frame.origin.x, CGRectGetMaxY(delegatePrice.frame)+AdjustHeight(2.5), delegatePrice.frame.size.width, flagImg.frame.size.height) fontColor:UIColorFromRGBA(0x676767, 1.0) fontSize:AdjustFontSize(10) textAligment:NSTextAlignmentRight];
        avgPrice.tag = 20005;
        
        [cell.contentView addSubview:avgPrice];
        
        
        UILabel *quantity = [QDTool createLabelWithFrame:CGRectMake(CGRectGetMaxX(delegatePrice.frame)+AdjustWidth(10), (AdjustHeight(TableViewRowHeight)-delegatePrice.frame.size.height)/2, AdjustWidth(125)/2, delegatePrice.frame.size.height) fontColor:[UIColor blackColor] fontSize:AdjustFontSize(14) textAligment:NSTextAlignmentRight];
        quantity.tag = 20006;
        [cell.contentView addSubview:quantity];
        
        //        UILabel *time = [QDTool createLabelWithFrame:CGRectMake(quantity.frame.origin.x, CGRectGetMaxY(quantity.frame)+AdjustHeight(2.5), quantity.frame.size.width, flagImg.frame.size.height) fontColor:UIColorFromRGBA(0x676767, 1.0) fontSize:AdjustFontSize(10) textAligment:NSTextAlignmentRight];
        //        time.tag = 20007;
        //        [cell.contentView addSubview:time];
        
        UILabel *staticStatus = [QDTool createLabelWithFrame:CGRectMake(CGRectGetMaxX(quantity.frame)+AdjustWidth(15), delegatePrice.frame.origin.y, quantity.frame.size.width+AdjustWidth(5), quantity.frame.size.height) fontColor:[UIColor blackColor] fontSize:AdjustFontSize(14) textAligment:NSTextAlignmentRight];
        staticStatus.tag = 20007;
        [cell.contentView addSubview:staticStatus];
        
        UILabel *status = [QDTool createLabelWithFrame:CGRectMake(staticStatus.frame.origin.x, CGRectGetMaxY(staticStatus.frame)+AdjustHeight(2.5), staticStatus.frame.size.width, flagImg.frame.size.height) fontColor:UIColorFromRGBA(0x676767, 1.0) fontSize:AdjustFontSize(10) textAligment:NSTextAlignmentRight];
        status.tag = 20008;
        [cell.contentView addSubview:status];
    }
    
    UILabel *stockName = (UILabel*)[cell viewWithTag:20001];
    UILabel *stockCode = (UILabel*)[cell viewWithTag:20003];
    UILabel *price = (UILabel*)[cell viewWithTag:20004];
    UILabel *action = (UILabel*)[cell viewWithTag:20005];
    stockName.text = @"新世界发展";
    stockCode.text = @"00017";
    price.text = @"0.900";
    
    UILabel *quantity = (UILabel*)[cell viewWithTag:20006];
    UILabel *date = (UILabel*)[cell viewWithTag:20007];
    UILabel *time = (UILabel*)[cell viewWithTag:20008];
    
    quantity.text = @"5000";
    date.text = @"2015-06-01";
    time.text = @"13.45:30";
    
    
    if(indexPath.row %2 ==0){
        price.textColor = action.textColor = UIColorFromRGBA(0x1a90f0, 1.0);
        action.text = @"卖出";
        
    }
    else{
        price.textColor =  action.textColor = UIColorFromRGBA(0xcb271b, 1.0);
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, AdjustHeight(TableViewSectionHeight))];
    view.backgroundColor = UIColorFromRGBA(0xeef2f6, 1.0);
    
    UIControl *background1 = [QDTool createTitleNameWithTitleArray:self.titleArray height:TableViewSectionHeight position:AdjustWidth(2) isFist:YES index:0 fontSize:AdjustFontSize(10)];
    //不惨与排序就不要写这行
//    [background1 addTarget:self action:@selector(holdingTitleAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:background1];
    
    UIControl *background2 = [QDTool createTitleNameWithTitleArray:self.titleArray height:TableViewSectionHeight position:CGRectGetMaxX(background1.frame)+AdjustWidth(60) isFist:YES index:1 fontSize:AdjustFontSize(10)];
    [background2 addTarget:self action:@selector(holdingTitleAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:background2];
    
    UIControl *background3 = [QDTool createTitleNameWithTitleArray:self.titleArray height:TableViewSectionHeight position:CGRectGetMaxX(background2.frame)+AdjustWidth(29.5) isFist:YES index:2 fontSize:AdjustFontSize(10)];
    [background3 addTarget:self action:@selector(holdingTitleAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:background3];
    
    
    UIControl *background4 = [QDTool createTitleNameWithTitleArray:self.titleArray height:TableViewSectionHeight position:CGRectGetMaxX(background3.frame)+AdjustWidth(34.5) isFist:YES index:3 fontSize:AdjustFontSize(10)];
    [background4 addTarget:self action:@selector(holdingTitleAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:background4];
    
    
    return view;
    
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
            [[QDStockSingletonConfigTools sharedManager] holdingSortByWitchOne:firstLabel.text orderby:NO];
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
    
//    if([secondLabel.text isEqualToString:[[QDStockSingletonConfigTools sharedManager] getHoldingMemberName:tHoldingM_MarketValue]]){
//        firstLabel = secondLabel;
//    }
    
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
