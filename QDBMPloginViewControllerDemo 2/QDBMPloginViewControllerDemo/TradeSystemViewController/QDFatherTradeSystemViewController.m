//
//  QDFatherTradeSystemViewController.m
//  QDBMPloginViewControllerDemo
//
//  Created by Weber on 15/8/8.
//  Copyright (c) 2015年 tsci. All rights reserved.
//

#import "QDFatherTradeSystemViewController.h"
#import "Masonry.h"
#import "QDTool.h"
#import "KYAnimatedPageControl.h"
#import "QDCompetitionHorizontallyLine.h"
#import "TTTAttributedLabel.h"
#import "AppDelegate.h"
#import "QDCompetiton_DianJiBaoJia_PickView.h"
#import "QDCompetiton_SelectMarket_PickView.h"

@interface QDFatherTradeSystemViewController ()<UIScrollViewDelegate, UITextFieldDelegate>
@property (nonatomic, strong)KYAnimatedPageControl *pc;
@property (nonatomic, strong)UIColor *skinColor;
@property (nonatomic)TradeSystemBuyOrSell currentType;

@end

@implementation QDFatherTradeSystemViewController


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
    // Do any additional setup after loading the view.
    [self initializeData];
    [self createUI];
}

#pragma mark - initialize data
- (void)initializeData{
    _dataSource = [[NSMutableArray alloc] initWithCapacity:5];
    [_dataSource addObjectsFromArray:@[@1, @2, @3, @4]];
}

#pragma mark - create UI

- (void)createUI{
    WS(ws);
    
    self.view.backgroundColor = UIColorFromRGBA(0xeef2f6, 1.0);
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKeyBoard:)];
    tapGesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapGesture];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    
    //市场
    _marketButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_marketButton setBackgroundImage:[UIImage imageNamed:@"market_button_small"] forState:UIControlStateNormal];
    [_marketButton setTitleColor:UIColorFromRGBA(0x676767, 1.0) forState:UIControlStateNormal];
    [_marketButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -14, 0, 0)];
    _marketButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    //todo
    [_marketButton setTitle:@"港股" forState:UIControlStateNormal];
    _marketButton.titleLabel.font = [UIFont systemFontOfSize:AdjustFontSize(14)];
    [self.marketButton addTarget:self action:@selector(marketButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_marketButton];
    
    //股票代码
    _stockCodeTextField = [UITextField new];
    _stockCodeTextField.delegate = self;
    
    _stockCodeTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_stockCodeTextField];
    
    
    
    
    //报价
    _quotePriceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_quotePriceButton setBackgroundImage:[UIImage imageNamed:@"quote_button"] forState:UIControlStateNormal];
    [_quotePriceButton setTitleColor:self.skinColor forState:UIControlStateNormal];
    //todo
    [_quotePriceButton setTitle:@"报价" forState:UIControlStateNormal];
    _quotePriceButton.titleLabel.font = [UIFont systemFontOfSize:AdjustFontSize(14)];
    [self.quotePriceButton addTarget:self action:@selector(quotePriceButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_quotePriceButton];
    //分割线1
    UIView *seperatorLine1 = [[UIView alloc] initWithFrame:CGRectMake(0, AdjustHeight(55), ScreenWidth, 0.5)];
    [self.view addSubview:seperatorLine1];
    
    
    //布局
    [_marketButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.view).with.offset(AdjustHeight(11));
        make.bottom.equalTo(seperatorLine1).with.offset(AdjustHeight(-10.5));
        make.left.equalTo(ws.view).with.offset(AdjustWidth(15));
        make.width.equalTo(@(AdjustWidth(50)));
    }];
    [_stockCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.marketButton.mas_centerY);
        make.left.equalTo(ws.marketButton.mas_right).with.mas_offset(AdjustWidth(4));
        make.height.equalTo(ws.marketButton.mas_height);
        make.width.equalTo(@(AdjustWidth(147)));
    }];
    [_quotePriceButton mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerY.equalTo(ws.marketButton.mas_centerY);
       make.left.equalTo(ws.stockCodeTextField.mas_right).with.mas_offset(AdjustWidth(4));
        make.height.equalTo(ws.marketButton.mas_height);
        make.width.equalTo(@(AdjustWidth(85)));
    }];
    
    
    
    //股票名称
    _stockName = [QDTool createLabelWithFrame:CGRectMake(AdjustWidth(69), seperatorLine1.frame.origin.y-AdjustHeight(10), AdjustWidth(80), AdjustHeight(21)) fontColor:self.skinColor fontSize:AdjustFontSize(9) textAligment:NSTextAlignmentLeft];
    _stockName.text = @"腾讯控股";
    [self.view addSubview:_stockName];
    
    
    //减号数量
    _minusAmountButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_minusAmountButton setBackgroundImage:[UIImage imageNamed:@"transaction_buy_minus_big"] forState:UIControlStateNormal];
    [self.view addSubview:_minusAmountButton];
    
    //数量
    _amountTextField = [UITextField new];
    _amountTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_amountTextField];
    
    //加号数量
    _plusAmountButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_plusAmountButton setBackgroundImage:[UIImage imageNamed:@"transaction_buy_plus_big"] forState:UIControlStateNormal];
    [self.view addSubview:_plusAmountButton];
    
    //分割线2
    UIView *seperatorLine2 = [[UIView alloc] initWithFrame:CGRectMake(0, 2*AdjustHeight(55), ScreenWidth, 0.5)];
    [self.view addSubview:seperatorLine2];
    
    
    //布局
    [_minusAmountButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(ws.view).with.offset(AdjustWidth(15));
        make.top.equalTo(seperatorLine1).with.offset(AdjustHeight(10.5));
        make.bottom.equalTo(seperatorLine2).with.offset(AdjustHeight(-10.5));
        make.width.equalTo(_minusAmountButton.mas_height);
    }];
    
    [_amountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.minusAmountButton.mas_centerY);
        make.left.equalTo(ws.stockCodeTextField.mas_left);
        make.width.equalTo(@(AdjustWidth(181)));
        make.height.equalTo(ws.minusAmountButton.mas_height);
    }];
    
    [_plusAmountButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.minusAmountButton.mas_centerY);
        make.size.equalTo(ws.minusAmountButton);
        make.left.equalTo(ws.amountTextField.mas_right).with.offset(AdjustWidth(20));
    }];
    
    UILabel *statciAvgNumber = [QDTool createLabelWithFrame:CGRectMake(self.stockName.frame.origin.x, seperatorLine2.frame.origin.y-AdjustHeight(10), AdjustWidth(35), AdjustHeight(21)) fontColor:UIColorFromRGBA(0x676767, 1.0) fontSize:AdjustFontSize(9) textAligment:NSTextAlignmentLeft];
    statciAvgNumber.text = @"每手股数";
    [self.view addSubview:statciAvgNumber];
    
    _avgStockNumber = [QDTool createLabelWithFrame:CGRectMake(CGRectGetMaxX(statciAvgNumber.frame), seperatorLine2.frame.origin.y-AdjustHeight(10), AdjustWidth(25), AdjustHeight(21)) fontColor:self.skinColor fontSize:AdjustFontSize(9) textAligment:NSTextAlignmentCenter];
    _avgStockNumber.text = @"1000000";
    [self.view addSubview:_avgStockNumber];
    
    
    UILabel *statciAvgNumberGu = [QDTool createLabelWithFrame:CGRectMake(CGRectGetMaxX(_avgStockNumber.frame), seperatorLine2.frame.origin.y-AdjustHeight(10), AdjustWidth(10), AdjustHeight(21)) fontColor:UIColorFromRGBA(0x676767, 1.0) fontSize:AdjustFontSize(9) textAligment:NSTextAlignmentLeft];
    statciAvgNumberGu.text = @"股";
    [self.view addSubview:statciAvgNumberGu];
    
    
    UILabel *statciAvaliableNumberGu = [QDTool createLabelWithFrame:CGRectMake(ScreenWidth-AdjustWidth(82), seperatorLine2.frame.origin.y-AdjustHeight(10), AdjustWidth(10), AdjustHeight(21)) fontColor:UIColorFromRGBA(0x676767, 1.0) fontSize:AdjustFontSize(9) textAligment:NSTextAlignmentLeft];
    statciAvaliableNumberGu.text = @"股";
     [self.view addSubview:statciAvaliableNumberGu];
    
    
    _avaliableStockNumber = [QDTool createLabelWithFrame:CGRectMake(statciAvaliableNumberGu.frame.origin.x-AdjustWidth(25), seperatorLine2.frame.origin.y-AdjustHeight(10), AdjustWidth(25), AdjustHeight(21)) fontColor:self.skinColor fontSize:AdjustFontSize(9) textAligment:NSTextAlignmentCenter];
    _avaliableStockNumber.text = @"5,000,000";
    [self.view addSubview:_avaliableStockNumber];
    
    UILabel *statciAvaliableNumber = [QDTool createLabelWithFrame:CGRectMake(_avaliableStockNumber.frame.origin.x-AdjustWidth(35), seperatorLine2.frame.origin.y-AdjustHeight(10), AdjustWidth(35), AdjustHeight(21)) fontColor:UIColorFromRGBA(0x676767, 1.0) fontSize:AdjustFontSize(9) textAligment:NSTextAlignmentLeft];
    statciAvaliableNumber.text = @"可买股数";
    [self.view addSubview:statciAvaliableNumber];
    
  
    
    //减号价格
    _minusPriceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_minusPriceButton setBackgroundImage:[UIImage imageNamed:@"transaction_buy_minus_big"] forState:UIControlStateNormal];
    [self.view addSubview:_minusPriceButton];
    
    //价格
    _priceTextField = [UITextField new];
    _priceTextField.borderStyle = UITextBorderStyleRoundedRect;
    _priceTextField.delegate = self;
    [self.view addSubview:_priceTextField];
    
    //加号价格
    _plusPriceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_plusPriceButton setBackgroundImage:[UIImage imageNamed:@"transaction_buy_plus_big"] forState:UIControlStateNormal];
    [self.view addSubview:_plusPriceButton];

    
    //分割线3
    UIView *seperatorLine3 = [[UIView alloc] initWithFrame:CGRectMake(0, 3*AdjustHeight(55), ScreenWidth, 0.5)];
    [self.view addSubview:seperatorLine3];
    
    
    //布局
    [_minusPriceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(ws.view).with.offset(AdjustWidth(15));
        make.top.equalTo(seperatorLine2).with.offset(AdjustHeight(10.5));
        make.bottom.equalTo(seperatorLine3).with.offset(AdjustHeight(-10.5));
        make.width.equalTo(_minusPriceButton.mas_height);
    }];
    
    [_priceTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(AdjustWidth(181)));
        make.height.equalTo(ws.minusAmountButton.mas_height);
        make.centerY.equalTo(ws.minusPriceButton.mas_centerY);
        make.left.equalTo(ws.stockCodeTextField.mas_left);
    }];
    
    [_plusPriceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.minusPriceButton.mas_centerY);
        make.left.equalTo(ws.priceTextField.mas_right).with.mas_offset(20);
        make.size.equalTo(_minusPriceButton);
    }];
    
    
    //下拉展示框
    _pullDownShowView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _pullDownShowView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _pullDownShowView.layer.borderColor = UIColorFromRGBA(0xc7c7cc, 1.0).CGColor;
    _pullDownShowView.layer.borderWidth = 0.5;
    _pullDownShowView.backgroundColor = [UIColor whiteColor];
    _pullDownShowView.delegate = self;
    _pullDownShowView.dataSource = self;
    _pullDownShowView.rowHeight = AdjustHeight(22);
    _pullDownShowView.delaysContentTouches = NO;

    
    //分割线4
    UIView *seperatorLine4 = [[UIView alloc] initWithFrame:CGRectMake(0, 4*AdjustHeight(55), ScreenWidth, 0.5)];
//    seperatorLine1.backgroundColor = [UIColor redColor];
//    seperatorLine2.backgroundColor = [UIColor redColor];
//    seperatorLine3.backgroundColor = [UIColor redColor];
//    seperatorLine4.backgroundColor = [UIColor redColor];
    [self.view addSubview:seperatorLine4];
    
    UIScrollView *scollView = [[UIScrollView alloc] initWithFrame:CGRectMake(AdjustWidth(15), seperatorLine3.frame.origin.y+((AdjustHeight(55)-AdjustHeight(40))/2)-100, ScreenWidth-(AdjustWidth(15)*2), AdjustHeight(40))];
    scollView.contentSize = CGSizeMake((ScreenWidth-(AdjustWidth(15)*2))*5, AdjustHeight(40));
    scollView.backgroundColor = [UIColor redColor];
    scollView.delegate = self;
    scollView.pagingEnabled = YES;
    scollView.bounces = YES;
    [self.view addSubview:scollView];
    scollView.hidden = YES;

   
    _pc = [[KYAnimatedPageControl alloc] initWithFrame:CGRectMake(AdjustWidth(15), seperatorLine3.frame.origin.y+((AdjustHeight(55)-AdjustHeight(40))/2), ScreenWidth-(AdjustWidth(15)*2), AdjustHeight(40))];
    self.pc.tag = 1001;
    self.pc.pageCount = 5;
    self.pc.unSelectedColor = [UIColor colorWithWhite:0.9 alpha:1];
//    self.pc.selectedColor = self.skinColor;
    self.pc.bindScrollView = scollView;
    self.pc.didSelectIndexBlock = ^(NSInteger index){
        NSLog(@"我%ld",index);
        switch (index) {
            case 1:
                ws.pc.selectedColor = UIColorFromRGBA(0xFF6347, 1.0);
                break;
            case 2:
                ws.pc.selectedColor = UIColorFromRGBA(0xFF6347, 0.8);
                break;
            case 3:
                ws.pc.selectedColor =[UIColor blackColor];
                break;
            case 4:
                ws.pc.selectedColor = UIColorFromRGBA(0xFF6347, 0.2);
                break;
                
            default:
                break;
        }
//        if (index==1) {
//            ws.pc.selectedColor = [UIColor purpleColor];
//        }
   

    };
    self.pc.shouldShowProgressLine = YES;
    self.pc.indicatorStyle = IndicatorStyleGooeyCircle;
    self.pc.indicatorSize = 20;
    self.pc.swipeEnable = YES;
    [self.view addSubview:self.pc];
    
    //一手
    UILabel *oneUnit = [QDTool createLabelWithFrame:CGRectMake(AdjustWidth(15), seperatorLine3.frame.origin.y+AdjustHeight(4), AdjustWidth(20), (AdjustHeight(55)-AdjustHeight(40))/2) fontColor:[UIColor blackColor] fontSize:AdjustFontSize(10) textAligment:NSTextAlignmentLeft];
    oneUnit.text = @"1手";
    [self.view addSubview:oneUnit];
    
    //1/4
    UILabel *quarterUnit = [QDTool createLabelWithFrame:CGRectMake(AdjustWidth(15)+self.pc.frame.size.width/4-AdjustWidth(10), seperatorLine3.frame.origin.y+8, AdjustWidth(20), (AdjustHeight(55)-AdjustHeight(40))/2) fontColor:UIColorFromRGBA(0x676767, 1.0) fontSize:AdjustFontSize(9) textAligment:NSTextAlignmentCenter];
    quarterUnit.text = @"1/4";
    [self.view addSubview:quarterUnit];
    
    //1/3
    UILabel *oneThirdUnit = [QDTool createLabelWithFrame:CGRectMake(AdjustWidth(15)+self.pc.frame.size.width/4*2-AdjustWidth(10), seperatorLine3.frame.origin.y+AdjustHeight(8), AdjustWidth(20), (AdjustHeight(55)-AdjustHeight(40))/2) fontColor:UIColorFromRGBA(0x676767, 1.0) fontSize:AdjustFontSize(9) textAligment:NSTextAlignmentCenter];
    oneThirdUnit.text = @"1/3";
    [self.view addSubview:oneThirdUnit];
    
    //1/2
    UILabel *aHalfUnit = [QDTool createLabelWithFrame:CGRectMake(AdjustWidth(15)+self.pc.frame.size.width/4*3-AdjustWidth(10), seperatorLine3.frame.origin.y+AdjustHeight(8), AdjustWidth(20), (AdjustHeight(55)-AdjustHeight(40))/2) fontColor:UIColorFromRGBA(0x676767, 1.0) fontSize:AdjustFontSize(9) textAligment:NSTextAlignmentCenter];
    aHalfUnit.text = @"1/2";
    [self.view addSubview:aHalfUnit];
    
    //全部
    UILabel *allUnit = [QDTool createLabelWithFrame:CGRectMake(ScreenWidth-AdjustWidth(15)-AdjustWidth(20), seperatorLine3.frame.origin.y+AdjustHeight(8), AdjustWidth(20), (AdjustHeight(55)-AdjustHeight(40))/2) fontColor:UIColorFromRGBA(0x676767, 1.0) fontSize:AdjustFontSize(9) textAligment:NSTextAlignmentLeft];
    allUnit.text = @"全部";
    [self.view addSubview:allUnit];
    
    //限价盘
    _limitOrderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_limitOrderButton setBackgroundImage:[UIImage imageNamed:@"transaction-type_button"] forState:UIControlStateNormal];
    [_limitOrderButton setTitle:@"增强限价盘" forState:UIControlStateNormal];
    _limitOrderButton.titleLabel.font = [UIFont systemFontOfSize:AdjustFontSize(14)];
    [_limitOrderButton setTitleColor:UIColorFromRGBA(0x676767, 1.0) forState:UIControlStateNormal];
    [self.view addSubview:_limitOrderButton];
    
    [_limitOrderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(seperatorLine4).with.offset(AdjustHeight(-5));
        make.left.equalTo(ws.view.mas_left).with.offset(AdjustWidth(15));
        make.height.equalTo(@(AdjustHeight(30)));
        make.width.equalTo(@(AdjustWidth(290)));
    }];
    
    
    QDCompetitionHorizontallyLine *seperator=[[QDCompetitionHorizontallyLine alloc] initWithFrame:CGRectMake(0, seperatorLine4.frame.origin.y+AdjustHeight(34), ScreenWidth, 0.5)  lineColor:UIColorFromRGBA(0xc7c7cc, 1.0)];
    [self.view addSubview:seperator];
    
    UILabel *staticReferAmount = [QDTool createLabelWithFrame:CGRectMake(AdjustWidth(15), seperator.frame.origin.y+AdjustHeight(10), (ScreenWidth-AdjustWidth(15)*2)/2, AdjustHeight(22)) fontColor:[UIColor blackColor] fontSize:AdjustFontSize(12) textAligment:NSTextAlignmentLeft];
    staticReferAmount.text = @"参考金额(含税)";
    [self.view addSubview:staticReferAmount];
    UILabel *staticReferAmountRemark = [QDTool createLabelWithFrame:CGRectMake(AdjustWidth(15), CGRectGetMaxY(staticReferAmount.frame), (ScreenWidth-AdjustWidth(15)*2)/2, AdjustHeight(12)) fontColor:UIColorFromRGBA(0x676767, 1.0) fontSize:AdjustFontSize(9) textAligment:NSTextAlignmentLeft];
    staticReferAmountRemark.text = @"本页信息以港币计价";
    [self.view addSubview:staticReferAmountRemark];
    
    _referenceAmount = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(staticReferAmount.frame), seperator.frame.origin.y+AdjustHeight(5), (ScreenWidth-AdjustWidth(15)*2)/2,  AdjustHeight(28))];
    if(self.currentType == tradeSystem_Buy){
        _referenceAmount.text = [QDTool getAnomalyString:28553.26 integerColor:self.skinColor decimalColor:UIColorFromRGBA(0x676767, 1.0) integerFontSize:AdjustFontSize(25) decimalFontSize:AdjustFontSize(12) haveSufix:0 textAlignment:NSTextAlignmentRight];
    }else{
        _referenceAmount.text = [QDTool getAnomalyString:28553.26 integerColor:self.skinColor decimalColor:UIColorFromRGBA(0x676767, 1.0) integerFontSize:AdjustFontSize(25) decimalFontSize:AdjustFontSize(12) haveSufix:0 textAlignment:NSTextAlignmentRight];
    }
    
    [self.view addSubview:_referenceAmount];
    
    _referenceAmountByChinese = [QDTool createLabelWithFrame:CGRectMake(CGRectGetMaxX(staticReferAmount.frame), CGRectGetMaxY(_referenceAmount.frame), (ScreenWidth-AdjustWidth(15)*2)/2, AdjustHeight(12)) fontColor:UIColorFromRGBA(0x676767, 1.0) fontSize:AdjustFontSize(9) textAligment:NSTextAlignmentRight];
    _referenceAmountByChinese.text = [QDTool convertNumberToChinese:28553.26];
    [self.view addSubview:_referenceAmountByChinese];
    
    _clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_clearButton setBackgroundImage:[UIImage imageNamed:@"transaction_clear_big"] forState:UIControlStateNormal];
    [self.view addSubview:_clearButton];
    
    _actionButon = [UIButton buttonWithType:UIButtonTypeCustom];
    if(self.currentType == tradeSystem_Buy)
        [_actionButon setBackgroundImage:[UIImage imageNamed:@"transaction_buy_big"] forState:UIControlStateNormal];
    else
        [_actionButon setBackgroundImage:[UIImage imageNamed:@"transaction_sale_big"] forState:UIControlStateNormal];
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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"viewwillAppear");
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - textfield notification
- (void)textFieldDidChange:(NSNotification*)notification{
    NSLog(@"%s", __func__);
    [self.pullDownShowView selectRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
}

#pragma mark - textfield delegate

-(void)setcole:(NSInteger)value {
    
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"%s", __func__);
    
    if(textField == self.priceTextField){
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    
    
    if(textField == self.stockCodeTextField){

        self.pullDownShowView.frame = CGRectMake(self.stockCodeTextField.frame.origin.x , CGRectGetMaxY(self.stockCodeTextField.frame)-3.5, self.stockCodeTextField.frame.size.width, 0);
        [self.view addSubview:self.pullDownShowView];
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.pullDownShowView.frame = CGRectMake(self.stockCodeTextField.frame.origin.x, CGRectGetMaxY(self.stockCodeTextField.frame)-AdjustHeight(3.5), self.stockCodeTextField.frame.size.width, AdjustHeight(110));
        }completion:^(BOOL finished) {
            if(finished){
            }
        }];
    }
    

}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"%s", __func__);
    
    if(textField == self.stockCodeTextField){
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.pullDownShowView.frame = CGRectMake(self.stockCodeTextField.frame.origin.x , CGRectGetMaxY(self.stockCodeTextField.frame)-  AdjustHeight(3.5), self.stockCodeTextField.frame.size.width, 0);
        }completion:^(BOOL finished) {
            if(finished){
                [self.pullDownShowView deselectRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0] animated:YES];
                [self.pullDownShowView removeFromSuperview];
            }
        }];
    }
   
    if(textField == self.priceTextField ){
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    }
}

#pragma mark - 键盘遮挡
- (void)keyboardWillShow:(NSNotification*)notification{
    NSDictionary *info = [notification userInfo];
    NSValue *value = [info valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    UIScrollView *superView = (UIScrollView*)[self.view superview];

    
    NSInteger height = CGRectGetMaxY(self.priceTextField.frame) -superView.frame.size.height + keyboardSize.height;
    
    if(height>0)
        [superView setContentOffset:CGPointMake(0, height) animated:YES];
}

- (void)keyboardWillHide:(NSNotification*)notification{
    NSDictionary *info = [notification userInfo];
    NSValue *value = [info valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    UIScrollView *superView = (UIScrollView*)[self.view superview];

    NSInteger height = CGRectGetMaxY(self.priceTextField.frame) -superView.frame.size.height + keyboardSize.height;
    if(height>0)
        [superView setContentOffset:CGPointMake(0, 0) animated:YES];

}

#pragma mark - 隐藏键盘
- (void)hiddenKeyBoard:(UITapGestureRecognizer*)gesture{
    [self.view endEditing:YES];
}


#pragma mark  - tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentifier = @"cellIndentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        UILabel *leftLabel = [QDTool createLabelWithFrame:CGRectMake(5, 0, (self.stockCodeTextField.frame.size.width-10)/2, AdjustHeight(110)/5) fontColor:UIColorFromRGBA(0x676767, 1.0) fontSize:AdjustFontSize(14) textAligment:NSTextAlignmentLeft];
        leftLabel.tag = 10001;
        [cell.contentView addSubview:leftLabel];
        UILabel *rightLabel = [QDTool createLabelWithFrame:CGRectMake(CGRectGetMaxX(leftLabel.frame), 0,(self.stockCodeTextField.frame.size.width-10)/2, AdjustHeight(110)/5) fontColor:UIColorFromRGBA(0x676767, 1.0) fontSize:AdjustFontSize(14) textAligment:NSTextAlignmentRight];
        rightLabel.tag = 10002;
        [cell.contentView addSubview:rightLabel];
    }
    
    UILabel *leftLabel = (UILabel*)[cell viewWithTag:10001];
    UILabel *rightLabel = (UILabel*)[cell viewWithTag:10002];
    leftLabel.text = @"腾讯控股";
    rightLabel.text = @"00700.HK";
    return cell;
}

#pragma mark - tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    [self.view endEditing:YES];
}

#pragma mark -- UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if(![scrollView isEqual: self.pullDownShowView]){
    
        //Indicator动画
        [self.pc.indicator animateIndicatorWithScrollView:scrollView andIndicator:self.pc];
        
        if (scrollView.dragging || scrollView.isDecelerating || scrollView.tracking) {
            //背景线条动画
            [self.pc.pageControlLine animateSelectedLineWithScrollView:scrollView];
        }
    }
    
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if(![scrollView isEqual: self.pullDownShowView]){
        self.pc.indicator.lastContentOffset = scrollView.contentOffset.x;
    }
    
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
    if(![scrollView isEqual: self.pullDownShowView]){
        [self.pc.indicator restoreAnimation:@(1.0/self.pc.pageCount)];
    }
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if(![scrollView isEqual: self.pullDownShowView]){
        self.pc.indicator.lastContentOffset = scrollView.contentOffset.x;
    }
}

- (QDCompetiton_SelectMarket_PickView*)marketPickView{
    if(_marketPickView == nil){
        _marketPickView=[[QDCompetiton_SelectMarket_PickView alloc] initWithParentView:self.view];
        _marketPickView.pickerViewDelegate=self;
        _marketPickView.userInteractionEnabled=YES;
        NSMutableArray *array = [NSMutableArray arrayWithArray:@[MKT_HKG, MKT_USA, MKT_SZA]];
        self.marketPickView.marketArray = array;
        self.marketPickView.curMarket = array[0];
        self.marketPickView.titleLabel.text = NSLocalizedString(@"市场选择", @"");
    }
    return _marketPickView;
}

#pragma mark - button action
///市场
- (void)marketButtonAction:(UIButton*)button{
    [self.marketPickView show];
}

///报价
- (void)quotePriceButtonAction:(UIButton*)button{
    if(self.dianJiBaoJiaPicker==nil)
    {
        self.dianJiBaoJiaPicker=[[QDCompetiton_DianJiBaoJia_PickView alloc] initWithParentView:self.view];
        self.dianJiBaoJiaPicker.pickerViewDelegate=self;
        self.dianJiBaoJiaPicker.userInteractionEnabled=YES;
    }
    
//    self.dianJiBaoJiaPicker.dianJiBaoJiaDictionary=dic;
    [self.dianJiBaoJiaPicker show];
//    self.dianJiBaoJiaPickerHadShow=YES;
//    [self.lodingView stopAni];

}

#pragma mark - pickview delegate

- (void)selectMarketCloseWithPicker:(QDCompetiton_SelectMarket_PickView*)datePicker{
    [datePicker dismiss];
//    UIButton *market = (UIButton*)[self.cashTableViewHeadView viewWithTag:10004];
//    market.enabled = YES;
//    UIButton *account = (UIButton*)[self.cashTableViewHeadView viewWithTag:10005];
//    account.enabled = YES;
    
}

- (void)selectMarketRowWithPicker:(QDCompetiton_SelectMarket_PickView*)dataPicker row:(NSInteger)row{
//    if([dataPicker isEqual:self.marketPickView]){
//        UIImageView *flagImg = (UIImageView*)[self.cashTableViewHeadView viewWithTag:100041];
//        UIButton *market = (UIButton*)[self.cashTableViewHeadView viewWithTag:10004];
//        self.marketPickView.curMarket = self.marketPickView.marketArray[row];
//        flagImg.image = [self getFlagImage];
//        [market setTitle:[self getMarketButtonTitle] forState:UIControlStateNormal];
//    }else{
//        UIButton *account = (UIButton*)[self.cashTableViewHeadView viewWithTag:10005];
//        self.accountPickView.curMarket = self.accountPickView.marketArray[row];
//        [account setTitle:[self getAccountButtonTitle] forState:UIControlStateNormal];
//    }
//    
    [dataPicker dismiss];
//    UIButton *market = (UIButton*)[self.cashTableViewHeadView viewWithTag:10004];
//    market.enabled = YES;
//    UIButton *account = (UIButton*)[self.cashTableViewHeadView viewWithTag:10005];
//    account.enabled = YES;
}



#pragma mark -  QDCompetitonOrder_DianJiBaoJia_PickerViewDelegate
-(void)closeWithPicker:(QDCompetiton_DianJiBaoJia_PickView*)datePicker
{
//    self.dianJiBaoJiaPickerHadShow=NO;
    [self.dianJiBaoJiaPicker dismiss];
}
- (void)refreshWithPicker:(QDCompetiton_DianJiBaoJia_PickView*)datePicker
{
//    NSString * strCode = [QDTradeServerList CodeToStand:self.stockCodeTextField.text market:self.placeData.mMarket];
//    if (!([strCode length] <= 0 )) {
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            NSMutableDictionary *dic= [QDTool checkCodeFromRDSWithCode:strCode market:self.curMarket];
//            if(dic)
//            {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    if(self.dianJiBaoJiaPicker!=nil)
//                    {
//                        self.dianJiBaoJiaPicker.dianJiBaoJiaDictionary=dic;
//                    }
//                });
//            }
//            else
//            {
//                
//            }
//        });
//    }
//    else{
//        [self.view makeToast:NSLocalizedString(@"该代码不存在", @"") duration:1.0 position:@"center"];
//        return;
//    }
}

/**
 *  点击报价的按钮响应返回指定的价格
 *
 *  @param dataPicker 指定的picker
 */
- (void)clickButtonWithPicker:(QDCompetiton_DianJiBaoJia_PickView*)dataPicker price:(NSString*)price type:(emDianJiBaoJiaType)type
{
//    self.priceTextField.textField.text=price;
//    if ([[QDTraderManager currentTrader]is_BLU]||[[QDTraderManager currentTrader]is_GCS]||[[QDTraderManager currentTrader]is_CCI]) {
//        
//        if (self.currentPari.code ==tSTPriceT_auction&&(self.mySubViewType=Competiton_Order_sell)) {
//            self.priceTextField.textField.placeholder =  [@" " stringByAppendingString:@"N/A"];
//            self.priceTextField.textField.text =  [@" " stringByAppendingString:@"N/A"];
//        }
//    }
//    //    else
//    
//    
//    
//    
//    
//    self.dianJiBaoJiaPickerHadShow=NO;
//    
//    //获取该更多价格的名称，如卖1，买1等,然后让其显示在价格的textField框里面
//    NSString* typeName=[QDCompetiton_DianJiBaoJia_PickView getNameOfType:type];
//    self.priceTextField.morePriceLabel.text=typeName;
//    self.priceTextField.morePriceLabel.hidden=NO;
    [self.dianJiBaoJiaPicker dismiss];
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
