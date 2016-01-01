//
//  DTTableAlert.h
//
//  Created by brkt on 15/8/19.
//  Copyright (c) 2015年 brkt. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef NS_ENUM(NSInteger, ConfirmButtonType) {

    ConfirmChangOrdelStyle, ///<改单
    ConfirmCancelOrdelStyle,///<撤单
    ConfirmBuyOrdelStyle,   ///<买入
    ConfirmSaleOrdelStyle,  ///<卖出
};

typedef NS_ENUM(NSInteger, SkinType) {
    BlueType,
    BlackType,
};
typedef enum tagEmMarket{
    
    mkt_unknown,
    
    mkt_HKG,
    mkt_SZA,
    mkt_SZB,
    mkt_SHA,
    mkt_SHB,
    mkt_USA,
    mkt_TWN,
    mkt_JPN,
    mkt_CAN,
    mkt_UKG,
    mkt_SIN,
    mkt_AUS,
    mkt_BON,
    mkt_FUN,
    mkt_KOR,
    mkt_MAL,
    mkt_HS,
    mkt_HGT,
    mkt_unknownReal = 100,
    
} emMarket;
@class QDTableAlert;

typedef NSInteger (^QDTableAlertNumberOfRowsBlock)(NSInteger section);

typedef NSArray * (^OrderChainArryBlock) (NSInteger section);

typedef void (^QDTableAlertCancelBlock)(void);

typedef void(^QDTableAlertConfirBlock)(NSMutableArray *arry);



@interface QDTableAlert : UIView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *table;

@property (nonatomic, strong) UITextField *priceTextField;

@property (nonatomic, strong) UITextField *amountTextField;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat wide;

@property (nonatomic, assign) BOOL isAnimate;

@property (nonatomic, assign) BOOL isAmountToAdd;///<是否允许数量增加 

@property (nonatomic, strong) QDTableAlertCancelBlock CancelBlock;

@property (nonatomic, strong) QDTableAlertConfirBlock confirBlock;


/**
     创建订单确认框
 @param title 顶部标题
 @param confirmButtonType  撤单 改单 买 卖
 @param skinType 皮肤  BlueType or BlackType
 @param amountStep 每手数量
 @param emMarket 此单的市场类型
 @param afferentPriceStep 特定情况需要传入的价差 一般情况是 0
 @param orderchainarry  传入订单列表信息 必须是数组字典的数组  dic1 = [setObject:@"100.0" forKey:@"委托价格" ] arry = {dic1 ,dic2,dic3,}
 
 */
+(QDTableAlert *)tableAlertWithTitle:(NSString *)title confirmButtonType:(ConfirmButtonType)confirmButtonType skinType:(SkinType)skinType amountStep:(NSInteger)AmountStep  afferentpriceStep:(CGFloat)AfferentPriceStep  emMarket:(emMarket)emMarket OrderChainArry:(OrderChainArryBlock)orderchainarry;

-(id)initWithTitle:(NSString *)title confirmButtonType:(ConfirmButtonType)confirmButtonType skinType:(SkinType)skinType amountStep:(NSInteger)AmountStep afferentpriceStep:(CGFloat)AfferentPriceStep  emMarket:(emMarket)emMarket OrderChainArry:(OrderChainArryBlock)orderchainarry;


/**
 *  第一个block是下单操作的点击事件回调
 *  第二个block是取消按钮回调 暂时没用说不定以后有用
 */

-(void)ConfirmBlock:(QDTableAlertConfirBlock)confirmBlock andCancelBlock:(QDTableAlertCancelBlock)cancelBlock;

/**
 * 显示 alvew
 */
-(void)show;

@end
@class TTTAttributedLabel;
@interface TableViewCell : UITableViewCell

@property (nonatomic,strong)NSDictionary *chaindic;
@property (nonatomic, strong)TTTAttributedLabel *TttRighLabel;
@end
