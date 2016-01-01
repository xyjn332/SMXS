//
//  QDTradeHodingViewController.m
//  QDBMPloginViewControllerDemo
//
//  Created by Weber on 15/8/5.
//  Copyright (c) 2015年 tsci. All rights reserved.
//

#import "QDTradeHodingViewController.h"
#import "TTTAttributedLabel.h"
#import "CBStoreHouseRefreshControl.h"



#pragma mark - 常量
static const NSInteger TableRowHeight = 46;  //行高
static const NSInteger TableSectionHeadHeight = 30;  //section高
static const NSInteger TableSectionFooterHeight = 15;  //section高
static const NSInteger OffsetSideWidth = 2;  //边界距离
static const NSInteger OffsetTitleWidth = 35;  //title间距


@interface QDTradeHodingViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UITableView *holdingTableView; //持仓view
@property (nonatomic, strong)NSMutableDictionary *holdingDataSource; //持仓数据源
@property (nonatomic, strong)NSMutableArray *staticTitleLabelArray; //显示标题
@property (nonatomic, strong)UIView *customFooterView;

@property (nonatomic, strong) CBStoreHouseRefreshControl *storeHouseRefreshControl;


@end

@implementation QDTradeHodingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeData];
    [self createUI];
    
}

#pragma mark - initialize

- (void)initializeData{
    _staticTitleLabelArray = [[NSMutableArray alloc] initWithObjects:
                              [NSNumber numberWithInt:tHoldingM_Name],//名称
                              [NSNumber numberWithInt:tHoldingM_MarketValue],//市值
                              
                              [NSNumber numberWithInt:tHoldingM_CurrentPrice],//现价
                              [NSNumber numberWithInt:tHoldingM_Cost],//成本
                              
                              [NSNumber numberWithInt:tHoldingM_Holding],//持仓
                              [NSNumber numberWithInt:tHoldingM_Available],//可用
                              
                              [NSNumber numberWithInt:tHoldingM_ProfitLoss], //浮动盈亏
                              nil];
    _dataSouce = [[NSMutableArray alloc] initWithCapacity:10];
}

#pragma  mark - create view

- (void)createUI{
//    [QDTool adjustIOS7NavigationController:self];
    
//    CGRect frame = self.view.bounds;
//    frame.size.height -= AdjustHeight(TableSectionFooterHeight);
   
    
    self.view.backgroundColor = [UIColor clearColor];
    _holdingTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _holdingTableView.delegate = self;
    _holdingTableView.dataSource = self;
    _holdingTableView.backgroundColor = UIColorFromRGBA(0xeef2f6, 1.0);
//UIColorFromRGBA(0x1d2228, 1.0);
    _holdingTableView.tableFooterView = [[UIView alloc] init];

    [self.view addSubview:_holdingTableView];
    
    //自定义footView
    self.customFooterView = [self createCustomerFooterView];
    [self.view addSubview:self.customFooterView];
    
    //分割线
    UILabel *seperator = [[UILabel alloc] init];
    seperator.tag = 100001;
    seperator.backgroundColor = UIColorFromRGBA(0x315c7f, 1.0);
    [self.view addSubview:seperator];
    
    //隐藏view
    _maskView = [UIView new];
    self.maskView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_maskView];
    
//    self.holdingTableView.frame = frame;
//    self.customFooterView.frame = CGRectMake(0 ,CGRectGetMaxY(self.holdingTableView.frame), frame.size.width, AdjustHeight(TableSectionFooterHeight));
//    seperator.frame = CGRectMake(0, frame.origin.x-1, ScreenWidth, 1);
//    self.maskView.frame = CGRectMake(0, frame.origin.x-1-AdjustHeight(12.5), ScreenWidth, AdjustHeight(12.5));
    
    // Let the show begins
    self.storeHouseRefreshControl = [CBStoreHouseRefreshControl attachToScrollView:self.holdingTableView target:self refreshAction:@selector(refreshTriggered:) plist:@"TSCI" color:UIColorFromRGBA(0x676767, 1.0) lineWidth:1.5 dropHeight:70 scale:1 horizontalRandomness:150 reverseLoadingAnimation:YES internalAnimationFactor:0.5];
}

- (UIView*)createCustomerFooterView{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = UIColorFromRGBA(0xe6e6e6, 1.0);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(AdjustWidth(OffsetSideWidth), 0, ScreenWidth, AdjustHeight(TableSectionFooterHeight))];
    label.backgroundColor = UIColorFromRGBA(0xe6e6e6, 1.0);
    label.font = [UIFont systemFontOfSize:AdjustFontSize(10)];
    label.textColor = UIColorFromRGBA(0x909090, 1.0);
    label.textAlignment = NSTextAlignmentLeft;
    label.adjustsFontSizeToFitWidth = YES;
    label.text = @"This is weber, just for looking";
    [view addSubview:label];
    return view;
    
}


#pragma  mark - 布局
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    CGRect frame = self.view.bounds;
    frame.size.height -= AdjustHeight(TableSectionFooterHeight);
    self.holdingTableView.frame = frame;
    self.customFooterView.frame = CGRectMake(0 ,CGRectGetMaxY(self.holdingTableView.frame), frame.size.width, AdjustHeight(TableSectionFooterHeight));
    UILabel *seperator = (UILabel*)[self.view viewWithTag:100001];
    seperator.frame = CGRectMake(0, frame.origin.x-1, ScreenWidth, 1);
    self.maskView.frame = CGRectMake(0, frame.origin.x-1-AdjustHeight(12.5), ScreenWidth, AdjustHeight(12.5));
}

#pragma mark - button action
- (void)holdingTitleAction:(UIControl*)btn{
    static short count = 0;
    static UIControl *oldControl;
    UILabel *firstLabel = (UILabel*)[btn viewWithTag:10001];
    UILabel *secondLabel = (UILabel*)[btn viewWithTag:10002];
    UIImageView *acsendingImg = (UIImageView*)[btn viewWithTag:10003];
    UIImageView *descendingImg = (UIImageView*)[btn viewWithTag:10004];
    UIImageView *arrowImg = (UIImageView*)[btn viewWithTag:10005];
    
    if([secondLabel.text isEqualToString:[[QDStockSingletonConfigTools sharedManager] getHoldingMemberName:tHoldingM_MarketValue]]){
        firstLabel = secondLabel;
    }
    
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
            
            [[QDStockSingletonConfigTools sharedManager] holdingSortByWitchOne:firstLabel.text orderby:YES];
            
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
    
    if([secondLabel.text isEqualToString:[[QDStockSingletonConfigTools sharedManager] getHoldingMemberName:tHoldingM_MarketValue]]){
        firstLabel = secondLabel;
    }
    
    firstLabel.textColor = UIColorFromRGBA(0x676767, 1.0);
    acsendingImg.hidden = YES;
    descendingImg.hidden = YES;
    arrowImg.hidden = NO;
}

#pragma mark - tableview datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;//self.dataSouce.count;
}
#define OffsetValueWidth (OffsetTitleWidth-10)
#define LabelWidth ((ScreenWidth-AdjustWidth(OffsetValueWidth)*3-AdjustWidth(OffsetSideWidth)*2)/4)
#define OffsetHeight (5)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentifier = @"cellIndentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        cell.backgroundColor = UIColorFromRGBA(0xeef2f6, 1.0);
        //------------------------------------------------------------第一列--------------------------------------------------------------
        UILabel *name = [self createLabelWithFrame:CGRectMake(AdjustWidth(OffsetSideWidth), 0, LabelWidth, AdjustHeight(16)) fontsize:12 textColor:[UIColor blackColor] alignment:NSTextAlignmentLeft];
        name.tag = 10001;
        [cell.contentView addSubview:name];
        
        UIImageView *flagImg = [[UIImageView alloc] initWithFrame:CGRectMake(AdjustWidth(OffsetSideWidth), CGRectGetMaxY(name.frame), AdjustWidth(12), AdjustHeight(11))];
        flagImg.tag = 10002;
        [cell.contentView addSubview:flagImg];
        
        UILabel *stockCode = [self createLabelWithFrame:CGRectMake(CGRectGetMaxX(flagImg.frame), flagImg.frame.origin.y, LabelWidth-flagImg.frame.size.width, flagImg.frame.size.height) fontsize:10 textColor:[UIColor blackColor] alignment:NSTextAlignmentLeft];
        stockCode.tag = 10003;
        [cell.contentView addSubview:stockCode];
        
        TTTAttributedLabel *marketValue = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(AdjustWidth(OffsetSideWidth), CGRectGetMaxY(flagImg.frame), LabelWidth, AdjustHeight(TableRowHeight)-CGRectGetMaxY(flagImg.frame)-AdjustHeight(5))];
        marketValue.tag = 10004;
        marketValue.adjustsFontSizeToFitWidth = YES;
        marketValue.font = [UIFont systemFontOfSize:10];
        [cell.contentView addSubview:marketValue];
        //------------------------------------------------------------第二列--------------------------------------------------------------
        UILabel *currentPrice = [self createLabelWithFrame:CGRectMake(LabelWidth+AdjustWidth(OffsetValueWidth), AdjustHeight(OffsetHeight), LabelWidth, (AdjustHeight(TableRowHeight)-AdjustHeight(OffsetHeight)*3)/2) fontsize:14 textColor:[UIColor blackColor] alignment:NSTextAlignmentRight];
        currentPrice.tag = 20001;
        [cell.contentView addSubview:currentPrice];
        
        
        UILabel *cost = [self createLabelWithFrame:CGRectMake(currentPrice.frame.origin.x, CGRectGetMaxY(currentPrice.frame)+AdjustHeight(OffsetHeight), currentPrice.frame.size.width, currentPrice.frame.size.height) fontsize:10 textColor:UIColorFromRGBA(0x676767, 1.0) alignment:NSTextAlignmentRight];
        cost.tag = 20002;
        [cell.contentView addSubview:cost];
        //------------------------------------------------------------第三列--------------------------------------------------------------
        UILabel *holding = [self createLabelWithFrame:CGRectMake((LabelWidth+AdjustWidth(OffsetValueWidth))*2, AdjustHeight(OffsetHeight), LabelWidth, (AdjustHeight(TableRowHeight)-AdjustHeight(OffsetHeight)*3)/2) fontsize:14 textColor:[UIColor blackColor] alignment:NSTextAlignmentRight];
        holding.tag = 30001;
        [cell.contentView addSubview:holding];
        
        UILabel *avilible = [self createLabelWithFrame:CGRectMake(holding.frame.origin.x, CGRectGetMaxY(holding.frame)+AdjustHeight(OffsetHeight), holding.frame.size.width, holding.frame.size.height) fontsize:10 textColor:UIColorFromRGBA(0x676767, 1.0) alignment:NSTextAlignmentRight];
        avilible.tag = 30002;
        [cell.contentView addSubview:avilible];
        //------------------------------------------------------------第四列--------------------------------------------------------------
        TTTAttributedLabel *profitLoss = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake((LabelWidth+AdjustWidth(OffsetValueWidth))*3, AdjustHeight(OffsetHeight), LabelWidth, (AdjustHeight(TableRowHeight)-AdjustHeight(OffsetHeight)*3)/2)];
        profitLoss.tag = 40001;
        profitLoss.adjustsFontSizeToFitWidth = YES;
        profitLoss.font = [UIFont systemFontOfSize:14];
        [cell.contentView addSubview:profitLoss];
        
        UILabel *profitLossRate = [self createLabelWithFrame:CGRectMake(profitLoss.frame.origin.x, CGRectGetMaxY(profitLoss.frame)+AdjustHeight(OffsetHeight), profitLoss.frame.size.width, profitLoss.frame.size.height) fontsize:10 textColor:UIColorFromRGBA(0x676767, 1.0) alignment:NSTextAlignmentRight];
        profitLossRate.tag = 40002;
        [cell.contentView addSubview:profitLossRate];
        //-------------------------------------------------------------over--------------------------------------------------------------
    }
    [[QDStockSingletonConfigTools sharedManager] holdingVCResetCellDataSourceWithCell:cell];
    return cell;
}


- (UILabel*)createLabelWithFrame:(CGRect)frame fontsize:(NSInteger)fontsize textColor:(UIColor*)tc alignment:(NSTextAlignment)align{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.font = [UIFont systemFontOfSize:AdjustFontSize(fontsize)];
    label.textColor = tc;
    label.textAlignment = align;
    label.adjustsFontSizeToFitWidth = YES;
    return label;

}



#pragma mark - tableview delegate

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdjustHeight(TableRowHeight);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return AdjustHeight(TableSectionHeadHeight);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, AdjustHeight(TableSectionHeadHeight))];
    view.backgroundColor = UIColorFromRGBA(0xeef2f6, 1.0);
    //-------------------------------------------------------------------------------------------------------------------------------
    UIControl *background1 = [self createStaticTitleLabel:nil isFirst:NO index:0];
    [background1 addTarget:self action:@selector(holdingTitleAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:background1];
    //-------------------------------------------------------------------------------------------------------------------------------
    UIControl *background2 = [self createStaticTitleLabel:background1 isFirst:YES index:1];
    [background2 addTarget:self action:@selector(holdingTitleAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:background2];
    //-------------------------------------------------------------------------------------------------------------------------------
    UIControl *background3 = [self createStaticTitleLabel:background2 isFirst:YES index:2];
    [background3 addTarget:self action:@selector(holdingTitleAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:background3];
    //-------------------------------------------------------------------------------------------------------------------------------
    UIControl *background4 = [self createStaticTitleLabelSpecial:background3 index:3];
    [background4 addTarget:self action:@selector(holdingTitleAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:background4];
    //-------------------------------------------------------------------------------------------------------------------------------

    
    return view;
}

- (UIControl*)createStaticTitleLabelSpecial:(UIControl*)priorControl index:(NSInteger)index{
    UIControl *background = [[UIControl alloc] initWithFrame:CGRectMake(priorControl == nil ? AdjustWidth(OffsetSideWidth):(CGRectGetMaxX(priorControl.frame)+AdjustWidth(OffsetTitleWidth)), 0, (ScreenWidth-AdjustWidth(OffsetTitleWidth)*3-AdjustWidth(OffsetSideWidth)*2)/4, AdjustHeight(TableSectionHeadHeight))];
    
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(0, (AdjustHeight(TableSectionHeadHeight)-AdjustHeight(TableSectionHeadHeight/2))/2, (background.frame.size.width-AdjustWidth(4)-AdjustWidth(4)), AdjustHeight(TableSectionHeadHeight/2))];
    name.textColor = UIColorFromRGBA(0x676767, 1.0);
    name.textAlignment = NSTextAlignmentCenter;
    name.font = [UIFont systemFontOfSize:AdjustFontSize(10)];
    name.text = [[QDStockSingletonConfigTools sharedManager] getHoldingMemberName:[self.staticTitleLabelArray[index*2] intValue]];
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
    
    UIControl *background = [[UIControl alloc] initWithFrame:CGRectMake(priorControl == nil ? AdjustWidth(OffsetSideWidth):(CGRectGetMaxX(priorControl.frame)+AdjustWidth(OffsetTitleWidth)), 0, (ScreenWidth-AdjustWidth(OffsetTitleWidth)*3-AdjustWidth(OffsetSideWidth)*2)/4, AdjustHeight(TableSectionHeadHeight))];

    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(0, (AdjustHeight(TableSectionHeadHeight)-AdjustHeight(TableSectionHeadHeight/2))/2, (background.frame.size.width-AdjustWidth(4)-AdjustWidth(4))/2, AdjustHeight(TableSectionHeadHeight/2))];
    name.tag = 10001;
    name.textColor = UIColorFromRGBA(0x676767, 1.0);
    name.textAlignment = NSTextAlignmentCenter;
    name.font = [UIFont systemFontOfSize:AdjustFontSize(10)];
    name.text = [[QDStockSingletonConfigTools sharedManager] getHoldingMemberName:[self.staticTitleLabelArray[index*2] intValue]];
    [background addSubview:name];

    UILabel *seperator = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(name.frame), (AdjustHeight(TableSectionHeadHeight)-AdjustHeight(TableSectionHeadHeight/2))/2, AdjustWidth(4), AdjustHeight(TableSectionHeadHeight/2))];
    seperator.textColor = UIColorFromRGBA(0x676767, 1.0);
    seperator.textAlignment = NSTextAlignmentLeft;
    seperator.font = [UIFont systemFontOfSize:AdjustFontSize(10)];
    seperator.text = @"/";
    [background addSubview:seperator];

    UILabel *market = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(seperator.frame), (AdjustHeight(TableSectionHeadHeight)-AdjustHeight(TableSectionHeadHeight/2))/2, (background.frame.size.width-AdjustWidth(4)-AdjustWidth(4))/2, AdjustHeight(TableSectionHeadHeight/2))];
    market.tag = 10002;
    market.textColor = UIColorFromRGBA(0x676767, 1.0);
    market.textAlignment = NSTextAlignmentLeft;
    market.font = [UIFont systemFontOfSize:AdjustFontSize(10)];
    market.text = [[QDStockSingletonConfigTools sharedManager] getHoldingMemberName:[self.staticTitleLabelArray[index*2+1] intValue]];
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

#pragma mark - Notifying refresh control of scrolling

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.storeHouseRefreshControl scrollViewDidScroll];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.storeHouseRefreshControl scrollViewDidEndDragging];
}

#pragma mark - Listening for the user to trigger a refresh

- (void)refreshTriggered:(id)sender
{
    [self performSelector:@selector(finishRefreshControl) withObject:nil afterDelay:2 inModes:@[NSRunLoopCommonModes]];
}

- (void)finishRefreshControl
{
    [self.storeHouseRefreshControl finishingLoading];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
