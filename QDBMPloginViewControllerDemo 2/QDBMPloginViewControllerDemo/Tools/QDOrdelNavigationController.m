//
//  QDOrdelNavigationController.m
//  iQDII_CIC
//
//  Created by brkt on 15/10/18.
//  Copyright © 2015年 TSCI. All rights reserved.
//

#import "QDOrdelNavigationController.h"
#import "TTTAttributedLabel.h"
#import "Masonry.h"

@interface QDOrdelNavigationController ()
@property (nonatomic, strong)UIColor *skinColor;
@property (nonatomic)TradeSystemBuyOrSell currentType;
@end

@implementation QDOrdelNavigationController

- (id)initWithType:(TradeSystemBuyOrSell)type{
    if(self = [super init]){
        switch (type) {
            case tradeSystem_Buy:
            {
                _skinColor = UIColorFromRGBA(0xcb271b, 1.0);
                _currentType = tradeSystem_Buy;
            }
                break;
            case tradeSystem_Sell:
            {
                _skinColor = UIColorFromRGBA(0x1a90f0, 1.0);
                _currentType = tradeSystem_Sell;
            }
                break;
            default:
                break;
        }
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGBA(0xeef2f6, 1.0);
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"t1_stock_navi_bg_128.png"] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
    
    UILabel *Title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    [Title setText:@"发布商品"];
    Title.textColor = [UIColor whiteColor];
    Title.textAlignment = NSTextAlignmentCenter;
    Title.font = [UIFont boldSystemFontOfSize:16];
    self.navigationItem.titleView = Title;
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = anotherButton;

//        self.title = @"kkkk";
  
}
- (void)Create_UI{
    WS(ws);
    UIView *TopInfoView =  [[UIView alloc]initWithFrame:CGRectMake(5, 70, CGRectGetWidth(self.view.frame)-10, 150)];
    [TopInfoView creatCorneView:[QDTool hexStringToColor:@"fef5f4"] FillColor:[QDTool hexStringToColor:@"CD0000"]];
    [self.view addSubview:TopInfoView];
    UITableView *table1 = [[UITableView alloc]initWithFrame:TopInfoView.frame];
    table1 = UITableViewCellSeparatorStyleNone;
    table1.backgroundColor = [UIColor clearColor];
    [self.view addSubview:table1];
    UIView *FootInfoView = [[UIView alloc]initWithFrame:CGRectMake(5, TopInfoView.frame.size.height+TopInfoView.frame.origin.y+5, CGRectGetWidth(self.view.frame)-10, 280)];
    [FootInfoView creatCorneView:[QDTool hexStringToColor:@"ffffff"] FillColor:[QDTool hexStringToColor:@"DBDBDB"]];
    [self.view addSubview:FootInfoView];
    UITableView *table2 = [[UITableView alloc]initWithFrame:FootInfoView.frame];
    table2 = UITableViewCellSeparatorStyleNone;
    table2.backgroundColor = [UIColor clearColor];
    [self.view addSubview:table2];

    UILabel *staticReferAmount = [QDTool createLabelWithFrame:CGRectMake(AdjustWidth(15), FootInfoView.frame.origin.y+FootInfoView.frame.size.height+AdjustHeight(18), (ScreenWidth-AdjustWidth(15)*2)/2, AdjustHeight(22)) fontColor:[UIColor blackColor] fontSize:AdjustFontSize(18) textAligment:NSTextAlignmentLeft];
    staticReferAmount.text = @"参考金额()";
    [self.view addSubview:staticReferAmount];
    
    UILabel *staticReferAmountRemark = [QDTool createLabelWithFrame:CGRectMake(AdjustWidth(15), CGRectGetMaxY(staticReferAmount.frame), (ScreenWidth-AdjustWidth(15)*2)/2, AdjustHeight(12)) fontColor:UIColorFromRGBA(0x676767, 1.0) fontSize:AdjustFontSize(9) textAligment:NSTextAlignmentLeft];
    staticReferAmountRemark.text = @"本页信息以港币计价";
    [self.view addSubview:staticReferAmountRemark];
    _referenceAmount = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(staticReferAmount.frame), FootInfoView.frame.origin.y+FootInfoView.frame.size.height+AdjustHeight(8), (ScreenWidth-AdjustWidth(15)*2)/2,  AdjustHeight(42))];
//    if(self.currentType == tradeSystem_Buy){
//        _referenceAmount.text = [QDTool getAnomalyString:28553.26 integerColor:self.skinColor decimalColor:UIColorFromRGBA(0x676767, 1.0) integerFontSize:AdjustFontSize(25) decimalFontSize:AdjustFontSize(12) haveSufix:0 textAlignment:NSTextAlignmentRight];
//    }else{
    _referenceAmount.text = [QDTool getAnomalyString:26878.8623 integerColor:[QDTool hexStringToColor:@"#CC0033"] decimalColor:UIColorFromRGBA(0x676767, 1.0) integerFontSize:AdjustFontSize(25) decimalFontSize:AdjustFontSize(13) haveSufix:0 textAlignment:NSTextAlignmentRight];
   
//    }
    [self.view addSubview:_referenceAmount];
    _referenceAmountByChinese = [QDTool createLabelWithFrame:CGRectMake(CGRectGetMaxX(staticReferAmount.frame), CGRectGetMaxY(_referenceAmount.frame), (ScreenWidth-AdjustWidth(15)*2)/2, AdjustHeight(12)) fontColor:UIColorFromRGBA(0x676767, 1.0) fontSize:AdjustFontSize(9) textAligment:NSTextAlignmentRight];
    _referenceAmountByChinese.text = [QDTool convertNumberToChinese:28553.26];
    [self.view addSubview:_referenceAmountByChinese];
    
    _clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_clearButton setBackgroundImage:[UIImage imageNamed:@"transaction_clear_big"] forState:UIControlStateNormal];
     [self.clearButton addTarget:self action:@selector(confirmButtonAciton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_clearButton];
    
    _actionButon = [UIButton buttonWithType:UIButtonTypeCustom];
//    if(self.currentType == tradeSystem_Buy)
//        [_actionButon setBackgroundImage:[UIImage imageNamed:@"transaction_buy_big"] forState:UIControlStateNormal];
//    else
    [_actionButon setBackgroundImage:[UIImage imageNamed:@"transaction_sale_big"] forState:UIControlStateNormal];
    [_actionButon addTarget:self action:@selector(confirmButtonAciton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_actionButon];
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
- (void)confirmButtonAciton:(UIButton*)send{
    [self dismissViewControllerAnimated:YES completion:^{
      
    }];
}
@end
