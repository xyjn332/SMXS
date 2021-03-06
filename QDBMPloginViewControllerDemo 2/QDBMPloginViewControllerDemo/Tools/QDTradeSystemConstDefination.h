//
//  QDTradeSystemConstDefination.h
//  QDBMPloginViewControllerDemo
//
//  Created by Weber on 15/7/7.
//  Copyright (c) 2015年 tsci. All rights reserved.
//

#ifndef QDBMPloginViewControllerDemo_QDTradeSystemConstDefination_h
#define QDBMPloginViewControllerDemo_QDTradeSystemConstDefination_h



#define MKT_HS	@"HS"	///< 沪深A股
#define MKT_HKG	@"HKG"	///< 港股
#define MKT_SZA	@"SZA"	///< 深圳A股
#define MKT_SHA	@"SHA"	///< 上海A股
#define MKT_SZB	@"SZB"	///< 深圳B股
#define MKT_SHB	@"SHB"	///< 上海B股
#define MKT_USA	@"USA"	///< 美股
#define MKT_TWN	@"TWN"	///< 台股
#define MKT_JPN	@"JPN"	///< 日股
#define MKT_CAN	@"CAN"	///< 加拿大股
#define MKT_UKG	@"UKG"	///< 英股
#define MKT_SIN	@"SIN"	///< 新加坡股
#define MKT_AUS	@"AUS"	///< 澳股
#define MKT_BON @"BON"	///< 债券
#define MKT_FUN @"FUN"	///< 基金
#define MKT_KOR @"KOR"	///< 韩国
#define MKT_MAL @"MAL"	///< 马来西亚
#define MKT_HGT	@"CNY"	///< 沪股通
#define MKT_GER @"GER"  ///< 德国

#define CURR_HKD	@"HKD"	///< 港币
#define CURR_USD	@"USD"	///< 美元
#define CURR_YEN	@"YEN"	///< 日元
#define CURR_SGD	@"SGD"	///< 新加坡元
#define CURR_CAD	@"CAD"	///< 加拿大元
#define CURR_RMB	@"CNY"	///< 人民币
#define CURR_CAN	@"CAN"	///< 加拿大元
#define CURR_AUD	@"AUD"	///< 澳元
#define CURR_EUR	@"EUR"	///< 欧元
#define CURR_GBP	@"GBP"	///< 英镑
#define CURR_KRW	@"KRW"	///< 韩元
#define CURR_TWD	@"TWD"	///< 台币

//资金
typedef enum tagEmTCashMember{
    
    
    tCashM_remark,      ///< 备注
    tCashM_avai,        ///< 购买力
    tCashM_total,       ///< 总资产
    tCashM_freeze,      ///< 冻结资金 || 委托冻结资金
    tCashM_stockV,      ///< 持仓货值 || 股票总市值
    tCashM_yield,       ///< 盈亏
    tCashM_left,        ///< 可用资金||账面结余
    tCashM_yieldP,      ///< 盈亏比例
    
    
    
    // for pas
    //tCashM_mort,
    tCashM_credit,     ///< 信贷限额
    tCashM_t1Left,
    tCashM_t2Left,
    //tCashM_maxExplosure,
    
    // for ecg
    tCashM_ecgTotal,
    tCashM_dayTrade,
    tCashM_interest,   ///<利息
    tCashM_unsettled,
    
    // for tfs
    tCashM_thisMaxBuyMoney,
    tCashM_maxBuyQtyLimit,
    tCashM_cashLeft,
    tCashM_cashSettledLeft,
    tCashM_stockEVal,
    tCashM_t1Settled,
    tCashM_t2Settled,
    tCashM_tNSettled,
    tCashM_check1,
    tCashM_check2,
    
    // for USA tfs
    tCashM_tfscashLeft,
    tCashM_tfscashLimit,
    tCashM_tfscashTotalLeft,
    tCashM_tfscashTotalLimit,
    tCashM_tfscashTodaySell,
    tCashM_tfscashTodayBuy,
    tCashM_tfscashToday,
    
    
    
    // for gtj
    tCashM_currency,        ///< 币种
    tCashM_margLimit,       ///< 马战限额
    tCashM_margAvai,        ///< 可用马战
    
    // for css
    //tCashM_transiting,
    tCashM_positionRatio,
    
    // for hs
    tCashM_canFetch,
    tCashM_canTransfer,
    tCashM_userID,
    
    // for gtc
    tCashM_t1BuyBalance,
    tCashM_t1SellBalance,
    
    // for yxs
    tCashM_usedBalance,     ///< 已用购买力
    // for indl
    tCashM_holdAmount,      ///< 交易冻结资金
    tCashM_tradingLimit,     ///< 交易额度
    tCashM_T1Balance,        ///< T+1交收
    tCashM_Interest,         ///< 利息
    tCashM_m_dbPurchasingPower,///<可买卖资金
    tCashM_PaperSurplus,      ///<可用结余
    tCashM_dbTodayChange,    ///< 既日买卖
    tCashM_dbGeneralAssets,    ///< 总资产
    
    tCashM_mort,
    tCashM_maxExplosure,
    
    tCashM_Information,
    
    tCashM_none,
    
} emTCashMember;


//持仓
typedef enum tagEmTHoldingMember{
    tHoldingM_Name,             //名称
    tHoldingM_MarketValue,      //市值
    tHoldingM_Cost,             //成本
    tHoldingM_CurrentPrice,     //现价
    tHoldingM_Available,        //可用
    tHoldingM_Holding,          //持仓
    tHoldingM_ProfitLoss,       //浮动盈亏
} emTHoldingMember;


typedef enum tradeSystemBuyOrSell{
    tradeSystem_Buy, //买入
    tradeSystem_Sell,//卖出
    tradeSystem_Buy_describe, //买入详情
    tradeSystem_Sell_describe,//卖出详情
}TradeSystemBuyOrSell;


//今日成交
typedef enum tagEmTTodayOderMember{
    tTodayOderM_Name,             //证券名称
    tTodayOderM_Price,            //价格
    tTodayOderM_Action,           //操作
    tTodayOderM_HBCJSL,           //成交数量
    tTodayOderM_DealTime,        //成交时间
} emTTodayOderMember;

//今日委托
typedef enum tagEmTTodayDelegateMember{
    tTodayDelegateM_Name,             //名称
    tTodayDelegateM_Price,            //委托价
    tTodayDelegateM_Action,           //操作
    tTodayDelegateM_Delegate,         //委托
    tTodayDelegateM_HBCJSL,           //成交量
    tTodayDelegaterM_DealTime,        //时间
    tTodayDelegaterM_Status,          //状态
} emTTodayDelegateMember;

#endif
