//
//  QDOrderBaseViewController.m
//  QDBMPloginViewControllerDemo
//
//  Created by Weber on 15/7/14.
//  Copyright (c) 2015年 tsci. All rights reserved.
//

#import "QDOrderCannotDealViewController.h"
#import "Masonry.h"
#import "QDTableAlert.h"



static const CGFloat TableViewRowHeight = 41;
static const CGFloat TableViewSectionHeight = 30;

@interface QDOrderCannotDealViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)NSMutableArray *dataArr; //数据源
@property (nonatomic, strong)UITableView *hasDealTableview;
@property (nonatomic, strong)NSIndexPath *oldIndexPath; //用来记录所选的indexpath
@end

@implementation QDOrderCannotDealViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initialize];

    [self createUI];
    
}

#pragma mark - initialize Data

- (void)initialize{
    _dataArr = [[NSMutableArray alloc] initWithCapacity:10];
    [_dataArr addObject:[NSNumber numberWithInt:1]];
    [_dataArr addObject:[NSNumber numberWithInt:2]];
    [_dataArr addObject:[NSNumber numberWithInt:3]];
    [_dataArr addObject:[NSNumber numberWithInt:4]];
    [_dataArr addObject:[NSNumber numberWithInt:1]];
    [_dataArr addObject:[NSNumber numberWithInt:2]];
    [_dataArr addObject:[NSNumber numberWithInt:3]];
    [_dataArr addObject:[NSNumber numberWithInt:4]];
    
    [_dataArr addObject:[NSNumber numberWithInt:1]];
    [_dataArr addObject:[NSNumber numberWithInt:2]];
    [_dataArr addObject:[NSNumber numberWithInt:3]];
    [_dataArr addObject:[NSNumber numberWithInt:4]];
    
    [_dataArr addObject:[NSNumber numberWithInt:1]];
    [_dataArr addObject:[NSNumber numberWithInt:2]];
    [_dataArr addObject:[NSNumber numberWithInt:3]];
    [_dataArr addObject:[NSNumber numberWithInt:4]];
}

#pragma mark - createUI
- (void)createUI{
    _hasDealTableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _hasDealTableview.delegate = self;
    _hasDealTableview.dataSource = self;
    _hasDealTableview.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_hasDealTableview];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.hasDealTableview.frame = self.view.bounds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdjustHeight(TableViewRowHeight);
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return AdjustHeight(TableViewSectionHeight);
}




- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, AdjustHeight(TableViewSectionHeight))];
    view.backgroundColor = UIColorFromRGBA(0xeef2f6, 1.0);
    //-------------------------------------------------------------------------------------------------------------------------------
    UIControl *background1 = [self createStaticTitleLabelSpecial:CGRectMake(AdjustWidth(2), 0, AdjustWidth(50), AdjustHeight(TableViewSectionHeight)) title:@"证券名称"];
    [view addSubview:background1];
    //-------------------------------------------------------------------------------------------------------------------------------
    UIControl *background2 = [self createStaticTitleLabel:background1 isFirst:YES index:1];
    [background2 addTarget:self action:@selector(orderTitleAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:background2];
    //-------------------------------------------------------------------------------------------------------------------------------
    UIControl *background3 = [self createStaticTitleLabelSpecial:CGRectMake(CGRectGetMaxX(background2.frame)+AdjustWidth(75), 0, AdjustWidth(30), TableViewSectionHeight) title: @"状态"];
    [background3 addTarget:self action:@selector(orderTitleAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:background3];
    //-------------------------------------------------------------------------------------------------------------------------------
    
    
    return view;
}

- (UIControl*)createStaticTitleLabelSpecial:(CGRect)frame title:(NSString*)title{
    UIControl *background = [[UIControl alloc] initWithFrame:frame];
    
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(0, (AdjustHeight(TableViewSectionHeight)-AdjustHeight(TableViewSectionHeight/2))/2, (background.frame.size.width-AdjustWidth(4)-AdjustWidth(4)), AdjustHeight(TableViewSectionHeight/2))];
    name.textColor = UIColorFromRGBA(0x676767, 1.0);
    name.textAlignment = NSTextAlignmentCenter;
    name.font = [UIFont systemFontOfSize:AdjustFontSize(10)];
    name.text = title;
    name.tag = 10001;
    [background addSubview:name];
    
    UIImageView *ascendingImg = [[UIImageView alloc] initWithFrame:CGRectMake((name.frame.size.width-AdjustWidth(7))/2, name.frame.origin.y-AdjustHeight(4), AdjustWidth(7), AdjustHeight(4))];
    ascendingImg.image = [UIImage imageNamed:@"icon_up"];
    ascendingImg.hidden = YES;
    ascendingImg.tag = 10003;
    [background addSubview:ascendingImg];
    
    UIImageView *descendingImg = [[UIImageView alloc] initWithFrame:CGRectMake((name.frame.size.width-AdjustWidth(7))/2, CGRectGetMaxY(name.frame), AdjustWidth(7), AdjustHeight(4))];
    descendingImg.image = [UIImage imageNamed:@"icon_down"];
    descendingImg.tag = 10004;
    descendingImg.hidden = YES;
    [background addSubview:descendingImg];
    
    UIImageView *arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame), CGRectGetMaxY(name.frame)-AdjustHeight(4), AdjustWidth(4), AdjustHeight(4))];
    arrowImg.image = [UIImage imageNamed:@"icon_arrow"];
    arrowImg.tag = 10005;
    [background addSubview:arrowImg];
    
    return background;
}

- (UIControl*)createStaticTitleLabel:(UIControl *)priorControl isFirst:(BOOL)isFirst index:(NSInteger)index{

    CGSize textSize = [QDTool getStringSizeWithString:@"委托价" font:[UIFont systemFontOfSize:AdjustFontSize(10)] lableHeight:1000 width:1000];
    CGSize textSize2 = [QDTool getStringSizeWithString:@"均价*" font:[UIFont systemFontOfSize:AdjustFontSize(10)] lableHeight:1000 width:1000];
    
    UIControl *background = [[UIControl alloc] initWithFrame:CGRectMake(CGRectGetMaxX(priorControl.frame)+AdjustWidth(44), 0, textSize.width+AdjustWidth(4)+textSize2.width, AdjustHeight(TableViewSectionHeight))];
    
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(0, (AdjustHeight(TableViewSectionHeight)-AdjustHeight(TableViewSectionHeight/2))/2, textSize.width, AdjustHeight(TableViewSectionHeight/2))];
    name.tag = 10001;
    name.textColor = UIColorFromRGBA(0x676767, 1.0);
    name.textAlignment = NSTextAlignmentCenter;
    name.font = [UIFont systemFontOfSize:AdjustFontSize(10)];
    name.text = @"委托价";
    [background addSubview:name];
    
    UILabel *seperator = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame), (AdjustHeight(TableViewSectionHeight)-AdjustHeight(TableViewSectionHeight/2))/2, AdjustWidth(4), AdjustHeight(TableViewSectionHeight/2))];
    seperator.textColor = UIColorFromRGBA(0x676767, 1.0);
    seperator.textAlignment = NSTextAlignmentLeft;
    seperator.font = [UIFont systemFontOfSize:AdjustFontSize(10)];
    seperator.text = @"/";
    [background addSubview:seperator];
    
    UILabel *market = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(seperator.frame), (AdjustHeight(TableViewSectionHeight)-AdjustHeight(TableViewSectionHeight/2))/2, textSize2.width, AdjustHeight(TableViewSectionHeight/2))];
    market.tag = 10002;
    market.textColor = UIColorFromRGBA(0x676767, 1.0);
    market.textAlignment = NSTextAlignmentLeft;
    market.font = [UIFont systemFontOfSize:AdjustFontSize(10)];
    market.text = @"均价*";
    [background addSubview:market];
    
    UIImageView *ascendingImg = [[UIImageView alloc] initWithFrame:CGRectMake((isFirst?0:(name.frame.size.width+AdjustWidth(4)))+((isFirst?(name.frame.size.width):(market.frame.size.width))-AdjustWidth(7))/2, (isFirst?(name.frame.origin.y):(market.frame.origin.y))-AdjustHeight(4), AdjustWidth(7), AdjustHeight(4))];
    ascendingImg.tag = 10003;
    ascendingImg.hidden = YES;
    ascendingImg.image = [UIImage imageNamed:@"icon_up"];
    [background addSubview:ascendingImg];
    
    UIImageView *descendingImg = [[UIImageView alloc] initWithFrame:CGRectMake((isFirst?0:(name.frame.size.width+AdjustWidth(4)))+((isFirst?(name.frame.size.width):(market.frame.size.width))-AdjustWidth(7))/2, CGRectGetMaxY(isFirst?market.frame:name.frame), AdjustWidth(7), AdjustHeight(4))];
    descendingImg.tag = 10004;
    descendingImg.hidden = YES;
    descendingImg.image = [UIImage imageNamed:@"icon_down"];
    [background addSubview:descendingImg];
    
    UIImageView *arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(market.frame), CGRectGetMaxY(market.frame)-AdjustHeight(4), AdjustWidth(4), AdjustHeight(4))];
    arrowImg.image = [UIImage imageNamed:@"icon_arrow"];
    arrowImg.tag = 10005;
    [background addSubview:arrowImg];
    
    return background;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //如果设置了cell的selectionStyle = UITableViewCellSelectionStyleNone时，cell上的分割线会无缘无故消失，
    //需要deselectRowAtIndexPath才会恢复，  I don't know why?
    [self.hasDealTableview deselectRowAtIndexPath:indexPath animated:YES];
    //如果点击的是同一个，则收起来
    if(self.oldIndexPath != nil && self.oldIndexPath.row == indexPath.row){
        [self.dataArr removeObjectAtIndex:indexPath.row+1];
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section];
        self.oldIndexPath = nil;  //之前的bug原因。必须放在更新前，否则依旧显示
        [self.hasDealTableview beginUpdates];
        [self.hasDealTableview deleteRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationMiddle];
        [self.hasDealTableview endUpdates];
        
        NSLog(@"the same row!");
        return ;
    }
    //如果点击的是新插入的，则不作为
    if(self.oldIndexPath != nil && self.oldIndexPath.row+1 == indexPath.row){
        NSLog(@"the inser row can't click!");
        return ;
    }
    //如果有old并且点击其他行，则先删除旧行，再添加新行
    if(self.oldIndexPath != nil){
        [self.dataArr removeObjectAtIndex:self.oldIndexPath.row+1];
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:self.oldIndexPath.row+1 inSection:indexPath.section];
        [self.hasDealTableview beginUpdates];
        [self.hasDealTableview deleteRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationMiddle];
        [self.hasDealTableview endUpdates];
        NSLog(@"the old row!");
        //校正indexpath
        if(self.oldIndexPath.row < indexPath.row){
            indexPath = [NSIndexPath indexPathForRow:indexPath.row-1 inSection:indexPath.section];
        }
    }
    //正常情况下点击增加一行
    self.oldIndexPath = indexPath;
    [self.dataArr insertObject:[NSNumber numberWithInteger:indexPath.row+1] atIndex:indexPath.row+1];
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section];
    [self.hasDealTableview beginUpdates];
    [_hasDealTableview insertRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationMiddle];
    [self.hasDealTableview endUpdates];
    //如果是最后一行，则让滚动到新添加的行
    if(indexpath.row == self.dataArr.count-1){
        [tableView scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    self.hasDealTableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}


#pragma mark - table datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.oldIndexPath != nil && self.oldIndexPath.row+1 == indexPath.row){
        static NSString *inserCellIndetifer = @"insertCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:inserCellIndetifer];
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:inserCellIndetifer];
            cell.backgroundColor = UIColorFromRGBA(0xe4e7e9, 1.0);
            //改单
            UIButton* modifyOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            modifyOrderBtn.frame = CGRectMake((ScreenWidth-AdjustWidth(52)*2)/4, (AdjustHeight(TableViewRowHeight)-AdjustHeight(19))/2, AdjustWidth(52), AdjustHeight(19));
            [modifyOrderBtn setBackgroundImage:[UIImage imageNamed:@"transaction_change"] forState:UIControlStateNormal];
            [modifyOrderBtn addTarget:self action:@selector(modifyBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            modifyOrderBtn.tag = 10001;
            [cell.contentView addSubview:modifyOrderBtn];
            
            //撤单
            UIButton *cancleOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            cancleOrderBtn.frame = CGRectMake(ScreenWidth/2+(ScreenWidth-AdjustWidth(52)*2)/4, (AdjustHeight(TableViewRowHeight)-AdjustHeight(19))/2, AdjustWidth(52), AdjustHeight(19));
            [cancleOrderBtn setBackgroundImage:[UIImage imageNamed:@"transaction_cancellation"] forState:UIControlStateNormal];
            [cancleOrderBtn addTarget:self action:@selector(cancleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            cancleOrderBtn.tag = 10002;
            [cell.contentView addSubview:cancleOrderBtn];
    
            

            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }
    
    static NSString *cellIndetifier = @"cantDealCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndetifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndetifier];
        cell.backgroundColor = UIColorFromRGBA(0xeef2f6, 1.0);
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
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
        
        UILabel *delegatePrice =  [QDTool createLabelWithFrame:CGRectMake(CGRectGetMaxX(stockName.frame), AdjustHeight(7.5), (ScreenWidth-AdjustWidth(2)-AdjustWidth(5)-AdjustWidth(125)-AdjustWidth(30))/2, AdjustHeight(15.5)) fontColor:UIColorFromRGBA(0xcb271b, 1.0) fontSize:AdjustFontSize(14) textAligment:NSTextAlignmentRight];
        delegatePrice.tag = 20004;

        [cell.contentView addSubview:delegatePrice];
        UILabel *avgPrice = [QDTool createLabelWithFrame:CGRectMake(delegatePrice.frame.origin.x, CGRectGetMaxY(delegatePrice.frame)+AdjustHeight(2.5), delegatePrice.frame.size.width, flagImg.frame.size.height) fontColor:UIColorFromRGBA(0x676767, 1.0) fontSize:AdjustFontSize(10) textAligment:NSTextAlignmentRight];
        avgPrice.tag = 20005;

        [cell.contentView addSubview:avgPrice];
        
        UILabel *backGroundView = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(delegatePrice.frame)+AdjustWidth(30), delegatePrice.frame.origin.y, AdjustWidth(125), AdjustHeight(12))];
        backGroundView.backgroundColor = UIColorFromRGBA(0xfe6856, 1.0);
        backGroundView.layer.cornerRadius = 6.0;
        backGroundView.layer.masksToBounds = YES;
        backGroundView.font = [UIFont systemFontOfSize:AdjustFontSize(10)];
        backGroundView.textColor = [UIColor whiteColor];
        backGroundView.textAlignment = NSTextAlignmentRight;
        backGroundView.tag = 20006;
        [cell.contentView addSubview:backGroundView];
        
        
        UILabel *foreGroundView = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(delegatePrice.frame)+AdjustWidth(30), delegatePrice.frame.origin.y, AdjustWidth(125)/2, AdjustHeight(12))];
        foreGroundView.backgroundColor = UIColorFromRGBA(0xcb271b, 1.0);
        foreGroundView.layer.cornerRadius = 6.0;
        foreGroundView.layer.masksToBounds = YES;
        foreGroundView.font = [UIFont systemFontOfSize:AdjustFontSize(10)];
        foreGroundView.textColor = [UIColor whiteColor];
        foreGroundView.textAlignment = NSTextAlignmentLeft;
        foreGroundView.tag = 20007;
        [cell.contentView addSubview:foreGroundView];
        
        UILabel *time = [QDTool createLabelWithFrame:CGRectMake(backGroundView.frame.origin.x, CGRectGetMaxY(backGroundView.frame)+AdjustHeight(5), backGroundView.frame.size.width*2/5, flagImg.frame.size.height) fontColor:UIColorFromRGBA(0x676767, 1.0) fontSize:AdjustFontSize(10) textAligment:NSTextAlignmentLeft];
        time.tag = 20008;
        [cell.contentView addSubview:time];
        
        UILabel *status = [QDTool createLabelWithFrame:CGRectMake(CGRectGetMaxX(time.frame), CGRectGetMaxY(backGroundView.frame)+AdjustHeight(5), backGroundView.frame.size.width*3/5, flagImg.frame.size.height) fontColor:UIColorFromRGBA(0x676767, 1.0) fontSize:AdjustFontSize(10) textAligment:NSTextAlignmentLeft];
        status.tag = 20009;
        [cell.contentView addSubview:status];

    }
    UILabel *stockName = (UILabel*)[cell viewWithTag:20001];
    UILabel *stockCode = (UILabel*)[cell viewWithTag:20003];
    UILabel *delegatePrice = (UILabel*)[cell viewWithTag:20004];
    UILabel *avgPrice = (UILabel*)[cell viewWithTag:20005];
    stockName.text = @"新世界发展";
    stockCode.text = @"00017";
    delegatePrice.text = @"10.180";
    avgPrice.text = @"10.180";
    
    UILabel *background = (UILabel*)[cell viewWithTag:20006];
    UILabel *foreground = (UILabel*)[cell viewWithTag:20007];
    if(indexPath.row %2 ==0)
        foreground.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    else
        foreground.backgroundColor = UIColorFromRGBA(0xcb271b, 1.0);
    background.text = @"2000股";
    foreground.text = @"买入";
    
    UILabel *time = (UILabel*)[cell viewWithTag:20008];
    UILabel *status = (UILabel*)[cell viewWithTag:20009];
    time.text = @"14:30:00";
    status.text = @"已经成交1000股";
    return cell;
}

#pragma mark - button action


- (void)orderTitleAction:(UIControl*)btn{
    static short count = 0;
    static UIControl *oldControl;
    UILabel *firstLabel = (UILabel*)[btn viewWithTag:10001];
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
    UIImageView *acsendingImg = (UIImageView*)[control viewWithTag:10003];
    UIImageView *descendingImg = (UIImageView*)[control viewWithTag:10004];
    UIImageView *arrowImg = (UIImageView*)[control viewWithTag:10005];
    
    firstLabel.textColor =  UIColorFromRGBA(0x676767, 1.0);
    acsendingImg.hidden = YES;
    descendingImg.hidden = YES;
    arrowImg.hidden = NO;
}

- (void)modifyBtnAction:(UIButton*)button{
    NSLog(@"改单row:%ld",  self.oldIndexPath.row);
    
    self.alert = [QDTableAlert tableAlertWithTitle:@"订单确认" confirmButtonType:ConfirmChangOrdelStyle skinType:BlackType amountStep:100 afferentpriceStep:0 emMarket:mkt_HKG OrderChainArry:^NSArray *(NSInteger section) {
        NSBundle *bundle = [NSBundle mainBundle];
        NSString *path = [bundle pathForResource:@"Property List" ofType:@"plist"];
        return  [NSArray arrayWithContentsOfFile:path];
    }];
    [self.alert ConfirmBlock:^(NSMutableArray *arry) {

        for (NSDictionary *dic in arry) {
            NSLog(@"%@-%@",[[dic allKeys]lastObject],[[dic allValues]lastObject]);
        }
    } andCancelBlock:^{
        [self cancel];
    }];
    self.alert.isAnimate = YES;
    [self.alert show];
    
}
- (void)cancel{
    NSLog(@"取消");
}
- (void)cancleBtnAction:(UIButton*)button{

    NSLog(@"撤单row:%ld", self.oldIndexPath.row);
    self.alert = [QDTableAlert tableAlertWithTitle:@"订单确认" confirmButtonType:ConfirmCancelOrdelStyle skinType:BlueType amountStep:100 afferentpriceStep:0 emMarket:mkt_HKG OrderChainArry:^NSArray *(NSInteger section) {
        NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"567854353453476",@"客户编号", nil];
        NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"88888",@"订单编号", nil];
        NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"港股",@"交易市场",   nil];
        NSDictionary *dic4 = [NSDictionary dictionaryWithObjectsAndKeys:@"买入",@"证券操作",   nil];
        NSDictionary *dic5 = [NSDictionary dictionaryWithObjectsAndKeys:@"00700",@"证券代码",  nil];
        NSDictionary *dic6 = [NSDictionary dictionaryWithObjectsAndKeys:@"腾讯控股",@"证券名称",  nil];
        NSDictionary *dic7 =  [NSDictionary dictionaryWithObjectsAndKeys:@"增强限价盘",@"交易类型",  nil];
        NSDictionary *dic8 = [NSDictionary dictionaryWithObjectsAndKeys:@"100.0", @"委托价格",  nil];
        NSDictionary *dic9 = [NSDictionary
                              dictionaryWithObjectsAndKeys:@"8700", @"委托数量",nil];
        
        NSArray *arr = [NSArray arrayWithObjects:dic1,dic2,dic3,dic4,dic5,dic6,dic7,dic8,dic9, nil];
        return arr;
    }];
    [self.alert show];
}


@end
