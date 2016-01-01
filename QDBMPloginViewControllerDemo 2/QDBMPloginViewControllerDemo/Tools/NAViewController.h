//
//  NAViewController.h
//  QDBMPloginViewControllerDemo
//
//  Created by brkt on 15/10/25.
//  Copyright © 2015年 tsci. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  TTTAttributedLabel;

typedef enum{
    CostomerNumber,  //客户编号
    DelegationType,  //委托类型
    SecurityOperate, //证券操作
    DelegationPrice, //委托价格
    SecurityCode,    //证券代码
    DelegationQuantity, //委托数量
    SecurityName,    //证券名称
    TradingAmount,   //交易金额
    
    BrokerageFee,    //经纪佣金
#ifdef _IQDII_CCI_
    TradingFee, //交易费
    TradingSystemUsingFee, //交易系统使用费
    TradingImpost, //交易征费
    StockSettlementFee, //股份结算费用
    StockStampFee, //股票印花税
    InvestorCompensateImpost, //投资者赔偿征费
    ResaleStampFee, //转手印花税
    AssignedOtherFee, //过户费用
    SecurityCombineFee, // 证券组合费用
#else
    TradingImpost, //交易征费
    TradingFee, //交易费
    TradingSystemUsingFee, //交易系统使用费
    StockSettlementFee, //股份结算费用
    StockStampFee, //股票印花税
    InvestorCompensateImpost, //投资者赔偿征费
    ResaleStampFee, //转手印花税
    AssignedOtherFee, //过户费用
    SecurityCombineFee, // 证券组合费用
#endif
    AmountInTotal ,//金额合计
    USBrokerageFee,//美股交易佣金
    ClearFee,//清算费用
    OtherFee,//股息税
    
}BuyStockConfirmType;
@interface NAViewController : UIViewController

@property (nonatomic, strong)TTTAttributedLabel *referenceAmount;//参考金额
@property (nonatomic, strong)UILabel *referenceAmountByChinese;//参考金额中文标示
@property (nonatomic, strong)UIButton *clearButton; //清除
@property (nonatomic, strong)UIButton *actionButon; //动作按钮
@property (nonatomic, strong)NSDictionary *topdict;
@property (nonatomic, strong)NSDictionary *footdict;

- (id)initWithData:(NSDictionary *)dict andFootdict:(NSDictionary *)footdict orderType:(TradeSystemBuyOrSell)type;
@end

@interface TopInfoLabrlCell : UITableViewCell

@property (nonatomic, strong)UILabel *leftTitleLabel;

@property (nonatomic, strong)TTTAttributedLabel *leftContentLabel;

@property (nonatomic, strong)UILabel *rightTitleLabel;

@property (nonatomic, strong)TTTAttributedLabel *rightContentLabel;

- (void)resetcellContent:(NSString *)leftTitle LeftConten:(NSString *)leftContent RightTitle:(NSString *)rightTitle RightContent:(NSString *)rightContent;

@end
