//
//  NAViewController.m
//  QDBMPloginViewControllerDemo
//
//  Created by brkt on 15/10/25.
//  Copyright © 2015年 tsci. All rights reserved.
//

#import "NAViewController.h"
#import "TTTAttributedLabel.h"
#import "Masonry.h"
#import <AVFoundation/AVFoundation.h>

#define ROWHEIGHT 30.0
#define LABELSPACINGBWTEENSLIDE 10.0
#define LateralInset 5.0
@interface NAViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UIColor *StrokeColor;
@property (nonatomic, strong)UIColor *Fillcolor;
@property (nonatomic, strong)UITableView *TopInfoTable;
@property (nonatomic, strong)UITableView *FootInfoTable;
@property (nonatomic, assign)CGFloat TopViewHightScale;
@property (nonatomic, assign)CGFloat FootViewHightScale;
@property (nonatomic, strong)AVAudioPlayer *play;
@property (nonatomic)TradeSystemBuyOrSell currentType;
@end

@implementation NAViewController

- (id)initWithData:(NSDictionary *)dict andFootdict:(NSDictionary *)footdict orderType:(TradeSystemBuyOrSell)type{
    if(self = [super init]){
        self.topdict = dict;
        self.footdict = footdict;
        switch (type) {
            case tradeSystem_Buy:
            {
                _StrokeColor = [QDTool hexStringToColor:@"fef5f4"];
                _Fillcolor   = [QDTool hexStringToColor:@"CD0000"];
                _currentType = tradeSystem_Buy;
                _TopViewHightScale  = 120.0/568.0;
                _FootViewHightScale = 250.0/568.0;
            }
                break;
            case tradeSystem_Sell:
            {
                _StrokeColor = [QDTool hexStringToColor:@"f4f9ff"];
                _Fillcolor   = [QDTool hexStringToColor:@"1E90FF"];
                _currentType = tradeSystem_Sell;
                _TopViewHightScale  = 120.0/568.0;
                _FootViewHightScale = 250.0/568.0;
            }
                break;
            case tradeSystem_Buy_describe:
            {
                _StrokeColor = [QDTool hexStringToColor:@"fef5f4"];
                _Fillcolor   = [QDTool hexStringToColor:@"CD0000"];
                _currentType = tradeSystem_Buy_describe;
                _TopViewHightScale  = 150.0/568.0;
                _FootViewHightScale = 280.0/568.0;

            }
                break;
            case tradeSystem_Sell_describe:
            {
                _StrokeColor = [QDTool hexStringToColor:@"f4f9ff"];
                _Fillcolor   = [QDTool hexStringToColor:@"1E90FF"];
                _currentType = tradeSystem_Sell_describe;
                _TopViewHightScale  = 150.0/568.0;
                _FootViewHightScale = 280.0/568.0;
            }
            default:
                break;
        }
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGBA(0xeef2f6, 1.0);
    NSDictionary * dict=[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];    
    //@"t1_stock_navi_bg_128.png"
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"t1_stock_navi_bg_128.png"] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
//    self.navigationItem.leftBarButtonItem =
    self.title = @"订单确认";
    self.navigationController.navigationBar.titleTextAttributes = dict;
    if (self.currentType == tradeSystem_Buy_describe||self.currentType == tradeSystem_Sell_describe) {
        UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(confirmButtonAciton:)];
        anotherButton.tintColor = [UIColor whiteColor];
        self.navigationItem.rightBarButtonItem = anotherButton;

    }
   
      [self Create_UI];
}
- (void)Create_UI{
    WS(ws);
    UIView *TopInfoView =  [[UIView alloc]initWithFrame:CGRectMake(LateralInset, LateralInset, CGRectGetWidth(self.view.frame)-10,self.view.frame.size.height*self.TopViewHightScale)];
    [TopInfoView creatCorneView:_StrokeColor FillColor:_Fillcolor];
    [self.view addSubview:TopInfoView];
    _TopInfoTable = [[UITableView alloc]initWithFrame:TopInfoView.frame];
    _TopInfoTable.backgroundColor = [UIColor clearColor];
    _TopInfoTable.delegate = self;
    _TopInfoTable.dataSource = self;
    _TopInfoTable.showsVerticalScrollIndicator = NO;
    _TopInfoTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIView *view1 = [[UIView alloc]init];
    view1.backgroundColor = [UIColor clearColor];
    [_TopInfoTable setTableFooterView:view1];
    [self.view addSubview:_TopInfoTable];
    
    UIView *FootInfoView = [[UIView alloc]initWithFrame:CGRectMake(LateralInset, TopInfoView.frame.size.height+TopInfoView.frame.origin.y+LateralInset, CGRectGetWidth(self.view.frame)-10, self.view.frame.size.height*self.FootViewHightScale)];
    [FootInfoView creatCorneView:[QDTool hexStringToColor:@"ffffff"] FillColor:[QDTool hexStringToColor:@"DBDBDB"]];
    [self.view addSubview:FootInfoView];
    _FootInfoTable = [[UITableView alloc]initWithFrame:FootInfoView.frame];
    _FootInfoTable.backgroundColor = [UIColor clearColor];
    _FootInfoTable.delegate = self;
    _FootInfoTable.dataSource = self;
    _FootInfoTable.showsVerticalScrollIndicator = NO;
    _FootInfoTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIView *view2 = [[UIView alloc]init];
    view2.backgroundColor = [UIColor clearColor];
    [_FootInfoTable setTableFooterView:view2];
    [self.view addSubview:_FootInfoTable];
    
    UILabel *staticReferAmount = [QDTool createLabelWithFrame:CGRectMake(AdjustWidth(15), FootInfoView.frame.origin.y+FootInfoView.frame.size.height+AdjustHeight(21), (ScreenWidth-AdjustWidth(15)*2)/2, AdjustHeight(22)) fontColor:[UIColor blackColor] fontSize:AdjustFontSize(18) textAligment:NSTextAlignmentLeft];
    staticReferAmount.text = @"参考金额()";

    [self.view addSubview:staticReferAmount];
    
    UILabel *staticReferAmountRemark = [QDTool createLabelWithFrame:CGRectMake(AdjustWidth(15), CGRectGetMaxY(staticReferAmount.frame)+8, (ScreenWidth-AdjustWidth(15)*2)/2, AdjustHeight(12)) fontColor:UIColorFromRGBA(0x676767, 1.0) fontSize:AdjustFontSize(9) textAligment:NSTextAlignmentLeft];
    staticReferAmountRemark.text = @"本页信息以港币计价";
    [self.view addSubview:staticReferAmountRemark];
    _referenceAmount = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(staticReferAmount.frame), FootInfoView.frame.origin.y+FootInfoView.frame.size.height+AdjustHeight(8), (ScreenWidth-AdjustWidth(15)*2)/2,  AdjustHeight(42))];
    _referenceAmount.text = [QDTool getAnomalyString:26878.8623 integerColor:self.Fillcolor decimalColor:UIColorFromRGBA(0x676767, 1.0) integerFontSize:AdjustFontSize(25) decimalFontSize:AdjustFontSize(13) haveSufix:0 textAlignment:NSTextAlignmentRight];

    [self.view addSubview:_referenceAmount];
    _referenceAmountByChinese = [QDTool createLabelWithFrame:CGRectMake(CGRectGetMaxX(staticReferAmount.frame), CGRectGetMaxY(_referenceAmount.frame), (ScreenWidth-AdjustWidth(15)*2)/2, AdjustHeight(12)) fontColor:UIColorFromRGBA(0x676767, 1.0) fontSize:AdjustFontSize(9) textAligment:NSTextAlignmentRight];
    _referenceAmountByChinese.text = [QDTool convertNumberToChinese:28553.26];
    [self.view addSubview:_referenceAmountByChinese];
    
    _clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_clearButton setBackgroundImage:[UIImage imageNamed:@"transaction_cancel_big"] forState:UIControlStateNormal];
    [self.clearButton addTarget:self action:@selector(confirmButtonAciton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_clearButton];
    
    _actionButon = [UIButton buttonWithType:UIButtonTypeCustom];
    if(self.currentType == tradeSystem_Buy){
        [_actionButon setBackgroundImage:[UIImage imageNamed:@"transaction_buy_big"] forState:UIControlStateNormal];
        [_actionButon addTarget:self action:@selector(confirmButtonAciton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_actionButon];
    }
    else if(self.currentType == tradeSystem_Sell){
        [_actionButon setBackgroundImage:[UIImage imageNamed:@"transaction_Sale_big"] forState:UIControlStateNormal];
        [_actionButon addTarget:self action:@selector(confirmButtonAciton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_actionButon];
    }
    else{
    
        
    }
    if (self.currentType == tradeSystem_Sell||self.currentType == tradeSystem_Buy) {
        [_clearButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(staticReferAmountRemark.mas_bottom).with.offset(AdjustHeight(11));
            make.left.equalTo(ws.view.mas_left).with.offset(AdjustWidth(15));
            make.height.equalTo(@(AdjustHeight(55)));
            make.right.equalTo(ws.actionButon.mas_left).with.offset(-5);
            make.width.equalTo(@(AdjustWidth(71)));
        }];
        
        [_actionButon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_clearButton.mas_centerY);
            make.left.equalTo(ws.clearButton.mas_right).with.offset(AdjustWidth(5));
            make.height.equalTo(_clearButton.mas_height);
            make.right.equalTo(ws.view).with.offset(-15);
        }];
    }


}
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (motion != UIEventSubtypeMotionShake) {
        return;
    }
     NSURL *url = [[NSBundle mainBundle]URLForResource:@"kakaotalk提示音.mp3" withExtension:Nil] ;
    self.play = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    [self.play prepareToPlay];
    self.play.numberOfLoops = 1;
    [self.play play];
}
- (void)confirmButtonAciton:(UIButton*)send{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return ROWHEIGHT;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.TopInfoTable) {
        NSInteger row = indexPath.row;
        static NSString *cellInditifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellInditifier];
        
        static NSString *cellInditifier1 = @"bothinfocell";
        TopInfoLabrlCell *bothinfocell = [tableView dequeueReusableCellWithIdentifier:cellInditifier1];
        if(cell == nil || bothinfocell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellInditifier];
            cell.backgroundColor = [UIColor clearColor];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            bothinfocell = [[TopInfoLabrlCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellInditifier1];
            bothinfocell.backgroundColor = [UIColor clearColor];
            [bothinfocell setSelectionStyle:UITableViewCellSelectionStyleNone];
            UILabel *labelLeft = [[UILabel alloc ]initWithFrame:CGRectMake(LABELSPACINGBWTEENSLIDE, 0, (cell.frame.size.width-LABELSPACINGBWTEENSLIDE*2)/2, ROWHEIGHT)];
            UILabel *labelRight = [[UILabel alloc ]initWithFrame:CGRectMake(CGRectGetMaxX(labelLeft.frame), 0, (self.view.frame.size.width-labelLeft.frame.size.width-2*LABELSPACINGBWTEENSLIDE-LateralInset), ROWHEIGHT)];
            labelLeft.textColor = [QDTool hexStringToColor:@"#b1b1b1"];
            labelLeft.textAlignment = NSTextAlignmentLeft;
            labelLeft.font = [UIFont systemFontOfSize:13];
            labelLeft.tag =101;
            
            labelRight.textAlignment = NSTextAlignmentRight;
            labelRight.font = [UIFont systemFontOfSize:13];
            labelRight.tag  = 102;
            [cell.contentView addSubview:labelLeft];
            [cell.contentView addSubview:labelRight];
        }
        UILabel *labelLeft  = (UILabel*)[cell.contentView viewWithTag:101];
        UILabel *labelRight = (UILabel*)[cell.contentView viewWithTag:102];
        if (indexPath.row>1) {
            [bothinfocell resetcellContent:[self getTypeName:(int)row*2-2]LeftConten:[self.topdict objectForKey:[NSNumber numberWithInteger:(int)row*2-2]] RightTitle:[self getTypeName:(int)indexPath.row*2+1-2] RightContent:[self.topdict objectForKey:[NSNumber numberWithInteger:(int)row*2+1-2]]];
            return bothinfocell;
        }
        else{
            labelLeft.text  = [self getTypeName:(int)indexPath.row];
            labelRight.text = [self.topdict objectForKey:[NSNumber numberWithInteger:indexPath.row]];
            return cell;
        }
    }
    if (tableView == self.FootInfoTable) {
        static NSString *cellInditifier = @"Footcell";
        UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:cellInditifier];
    if (cell2 == nil) {
        cell2 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellInditifier];
        UILabel *labelLeft = [[UILabel alloc ]initWithFrame:CGRectMake(LABELSPACINGBWTEENSLIDE, 0, (cell2.frame.size.width-LABELSPACINGBWTEENSLIDE*2)/2, ROWHEIGHT)];
        UILabel *labelRight = [[UILabel alloc ]initWithFrame:CGRectMake(CGRectGetMaxX(labelLeft.frame), 0, (self.view.frame.size.width-labelLeft.frame.size.width-2*LABELSPACINGBWTEENSLIDE-LateralInset), ROWHEIGHT)];
        labelLeft.textColor = [QDTool hexStringToColor:@"#b1b1b1"];
        labelLeft.textAlignment = NSTextAlignmentLeft;
        labelLeft.font = [UIFont systemFontOfSize:13];
        labelLeft.tag =103;
        
        labelRight.textAlignment = NSTextAlignmentRight;
        labelRight.font = [UIFont systemFontOfSize:13];
        labelRight.textColor = [QDTool hexStringToColor:@"#b1b1b1"];
        labelRight.tag  = 104;
        [cell2.contentView addSubview:labelLeft];
        [cell2.contentView addSubview:labelRight];
         cell2.backgroundColor = [UIColor clearColor];
    }
        UILabel *labelLeft  = (UILabel*)[cell2.contentView viewWithTag:103];
        UILabel *labelRight = (UILabel*)[cell2.contentView viewWithTag:104];
        labelLeft.text = [self getTypeName:(int)indexPath.row+self.topdict.count];
        labelRight.text = [self.footdict objectForKey:[NSNumber numberWithInteger:indexPath.row+self.topdict.count]];
        return cell2;
    }
    return nil;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger num;
    if (tableView == self.TopInfoTable)
        
    {  num= (self.topdict.count-2)/2+2;
        return num;
    }
    else
        return self.footdict.count;
}
#pragma mark - 取名字
- (NSString *)getTypeName: (BuyStockConfirmType)typeName{
    switch (typeName) {
        case DelegationType:
            return NSLocalizedString(@"委托类型", @"");
            break;
        case CostomerNumber:
            return NSLocalizedString(@"客户编号", @"");
            break;
        case SecurityOperate:
            return NSLocalizedString(@"证券操作", @"");
            break;
        case SecurityName:
            return NSLocalizedString(@"证券名称", @"");
            break;
        case SecurityCode:
            return NSLocalizedString(@"证券代码", @"");
            break;
        case DelegationPrice:
            return NSLocalizedString(@"委托价格", @"");
            break;
        case DelegationQuantity:
            return NSLocalizedString(@"委托数量", @"");
            break;
        case TradingAmount:
            return NSLocalizedString(@"交易金额", @"");
            break;
        case BrokerageFee:
            return NSLocalizedString(@"经纪佣金", @"");
            break;
        case TradingFee:
            return NSLocalizedString(@"交易费", @"");
            break;
        case TradingSystemUsingFee:
            return NSLocalizedString(@"交易系统使用费", @"");
            break;
        case TradingImpost:
            return NSLocalizedString(@"交易征费", @"");
            break;
        case StockSettlementFee:
            return NSLocalizedString(@"股份结算费用", @"");
            break;
        case StockStampFee:
            return NSLocalizedString(@"股票印花税", @"");
            break;
        case InvestorCompensateImpost:
            return NSLocalizedString(@"投资者赔偿征费", @"");
            break;
        case ResaleStampFee:
            return NSLocalizedString(@"转手印花税", @"");
            break;
        case AssignedOtherFee:
            return NSLocalizedString(@"过户费用", @"");
            break;
        case SecurityCombineFee:
            return NSLocalizedString(@"证券组合费用", @"");
            break;
        case AmountInTotal:
        {
            NSString *result=[NSString stringWithFormat:@"金额合计(HKD)"];
            return result;
            break;
        }
            
        case USBrokerageFee:
            return NSLocalizedString(@"交易佣金", @"");
            break;
        case ClearFee:
            return NSLocalizedString(@"清算费用", @"");
            break;
        case OtherFee:
            return NSLocalizedString(@"股息税", @"");
            break;
            
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
@interface TopInfoLabrlCell()
@property (nonatomic,copy)NSString *leftText;
@property (nonatomic,copy)NSString *leftcontent;
@property (nonatomic,copy)NSString *rightText;
@property (nonatomic,copy)NSString *rightContent;
@end
@implementation TopInfoLabrlCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
       self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *LeftTitleLabel = [[UILabel alloc]init];
        [LeftTitleLabel setFont:[UIFont fontWithName:@"Arial" size:13.0]];
        [LeftTitleLabel setTextColor:[QDTool hexStringToColor:@"#b1b1b1"]];
        LeftTitleLabel.textAlignment = NSTextAlignmentLeft;
        LeftTitleLabel.adjustsFontSizeToFitWidth = YES;
        LeftTitleLabel.shadowColor = UIColor.clearColor;
        LeftTitleLabel.shadowOffset = CGSizeMake(.0, .0);
        [self.contentView addSubview:LeftTitleLabel];
        self.leftTitleLabel = LeftTitleLabel;
        
        UILabel *RightTitleLabel = [[UILabel alloc]init];
        [RightTitleLabel setFont:[UIFont fontWithName:@"Arial" size:13.0]];
  
        [RightTitleLabel setTextColor:[QDTool hexStringToColor:@"#b1b1b1"]];
        RightTitleLabel.textAlignment = NSTextAlignmentLeft;
        RightTitleLabel.adjustsFontSizeToFitWidth = YES;
        RightTitleLabel.shadowColor = UIColor.clearColor;
        RightTitleLabel.shadowOffset = CGSizeMake(.0, .0);
        [self.contentView addSubview:RightTitleLabel];
        self.rightTitleLabel = RightTitleLabel;
        
        TTTAttributedLabel *LeftContentLabel = [[TTTAttributedLabel alloc]init];
        LeftContentLabel.textAlignment = NSTextAlignmentRight;
        LeftContentLabel.adjustsFontSizeToFitWidth = YES;
        LeftContentLabel.font = [UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:LeftContentLabel];
        self.leftContentLabel = LeftContentLabel;
        
        TTTAttributedLabel *RightContentLabel = [[TTTAttributedLabel alloc]init];
        RightContentLabel.textAlignment = NSTextAlignmentRight;
        RightContentLabel.adjustsFontSizeToFitWidth = YES;
        RightContentLabel.font = [UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:RightContentLabel];
        self.rightContentLabel = RightContentLabel;

//        if ([[QDTool getCurrentSkin] isEqualToString:QDBLACKSKIP]) {
//            self.backgroundColor = [QDTool hexStringToColor:@"#1d2228"];
//            self.rightContentLabel.textColor =  self.leftContentLabel.textColor =[UIColor whiteColor];
//        }else{
//            self.backgroundColor = [UIColor whiteColor];
//            self.rightContentLabel.textColor =  self.leftContentLabel.textColor =[UIColor blackColor];
//        }
    }

    return self;

}
- (void)resetcellContent:(NSString *)leftTitle LeftConten:(id)leftContent RightTitle:(NSString *)rightTitle RightContent:(id)rightContent{
    _leftText = leftTitle;  _leftcontent = leftContent;_rightText = rightTitle; _rightContent = rightContent;
    if ([leftContent isKindOfClass:[NSString class]]) { }
//    self.leftContentLabel.text  = [QDTool getAnomalyString:26878.8623 integerColor:[UIColor redColor] decimalColor:UIColorFromRGBA(0x676767, 1.0) integerFontSize:AdjustFontSize(6) decimalFontSize:AdjustFontSize(6) haveSufix:0 textAlignment:NSTextAlignmentRight];
    self.leftContentLabel.text  = leftContent;
    self.rightContentLabel.text = rightContent;
    self.leftTitleLabel.text    = leftTitle;
    self.rightTitleLabel.text   = rightTitle;
    
   [self setTopCellFram];
}
- (void)setTopCellFram{
    self.leftTitleLabel.frame = CGRectMake(LABELSPACINGBWTEENSLIDE, 0, 58, ROWHEIGHT);
    self.leftContentLabel.frame = CGRectMake(LateralInset+self.leftTitleLabel.frame.size.width, 2, ScreenWidth/2-self.leftTitleLabel.frame.size.width-2*LateralInset, ROWHEIGHT);
    self.rightTitleLabel.frame = CGRectMake(ScreenWidth/2, 0, 58, ROWHEIGHT);
    self.rightContentLabel.frame = CGRectMake(LateralInset+self.rightTitleLabel.frame.size.width+ScreenWidth/2-LateralInset, 2, self.leftContentLabel.frame.size.width-LateralInset, ROWHEIGHT);
}
@end
