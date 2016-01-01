//
//  QDFatherTradeSystemViewController.h
//  QDBMPloginViewControllerDemo
//
//  Created by Weber on 15/8/8.
//  Copyright (c) 2015年 tsci. All rights reserved.
//  买卖父界面

#import <UIKit/UIKit.h>
@class TTTAttributedLabel;
@class QDCompetiton_DianJiBaoJia_PickView;
@protocol QDCompetitonOrder_DianJiBaoJia_PickerViewDelegate;
@class QDCompetiton_SelectMarket_PickView;
@protocol QDCompetitonOrder_SelectMarket_PickerViewDelegate;

@interface QDFatherTradeSystemViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,QDCompetitonOrder_DianJiBaoJia_PickerViewDelegate,QDCompetitonOrder_SelectMarket_PickerViewDelegate>

@property (nonatomic, strong)UIButton *marketButton;// 市场
@property (nonatomic, strong)UITextField *stockCodeTextField;//市场代码
@property (nonatomic, strong)UIButton *quotePriceButton; //报价
@property (nonatomic, strong)UILabel *stockName; //股票名称
@property (nonatomic, strong)UIButton *minusAmountButton; //减数量
@property (nonatomic, strong)UIButton *plusAmountButton; //加数量
@property (nonatomic, strong)UITextField *amountTextField; //数量
@property (nonatomic, strong)UILabel *avgStockNumber; //每手股数
@property (nonatomic, strong)UILabel *avaliableStockNumber; //可买股数
@property (nonatomic, strong)UIButton *minusPriceButton; //减价格
@property (nonatomic, strong)UIButton *plusPriceButton;//加价格
@property (nonatomic, strong)UITextField *priceTextField; //价格
//滑块
@property (nonatomic, strong)UIButton *limitOrderButton;//限价盘
@property (nonatomic, strong)TTTAttributedLabel *referenceAmount;//参考金额
@property (nonatomic, strong)UILabel *referenceAmountByChinese;//参考金额中文标示
@property (nonatomic, strong)UIButton *clearButton; //清除
@property (nonatomic, strong)UIButton *actionButon; //动作按钮

@property (nonatomic, strong)UITableView *pullDownShowView; //下拉展示框
@property (nonatomic, strong)NSMutableArray *dataSource;
@property (nonatomic,strong)QDCompetiton_DianJiBaoJia_PickView *dianJiBaoJiaPicker;         //点击报价pickerview
@property (nonatomic, strong)QDCompetiton_SelectMarket_PickView *marketPickView;      //市场选择

- (id)initWithType:(TradeSystemBuyOrSell)type;

@end
