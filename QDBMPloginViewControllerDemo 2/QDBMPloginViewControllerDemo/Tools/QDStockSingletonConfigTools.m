//
//  QDStockSingletonConfigTools.m
//  QDBMPloginViewControllerDemo
//
//  Created by Weber on 15/8/4.
//  Copyright (c) 2015年 tsci. All rights reserved.
//

#import "QDStockSingletonConfigTools.h"
#import "TTTAttributedLabel.h"
#import "QDTool.h"

@implementation QDStockSingletonConfigTools

+(instancetype)sharedManager{
    
    static QDStockSingletonConfigTools *animManager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        animManager = [[QDStockSingletonConfigTools alloc]init];
    });
    return animManager;
}

- (NSString*) getMemberName:(emTCashMember)t{
    
    switch (t) {
        case tCashM_userID:
            return NSLocalizedString(@"用户", @"");
        case tCashM_remark:
            return NSLocalizedString(@"账户信息", @"");
        case tCashM_avai:
            return NSLocalizedString(@"可用资金", @"");
        case tCashM_total:
            return NSLocalizedString(@"总资产(港币)", @"");
        case tCashM_freeze:
            return NSLocalizedString(@"委托冻结金额", @"");
        case tCashM_stockV:
            return NSLocalizedString(@"股票总市值", @"");
        case tCashM_yield:
            return NSLocalizedString(@"浮动盈亏", @"");
        case tCashM_left:
            return NSLocalizedString(@"账面结余", @"");
        case tCashM_yieldP:
            return NSLocalizedString(@"总收益率", @"");
        case tCashM_t1Left:
            return NSLocalizedString(@"T1结余", @"");
        case tCashM_t2Left:
            return NSLocalizedString(@"T2结余", @"");
        case tCashM_mort:
            return NSLocalizedString(@"按揭价值", @"");
        case tCashM_credit:
            return NSLocalizedString(@"信用额度", @"");
        case tCashM_maxExplosure:
            return NSLocalizedString(@"按揭上限", @"");
        case tCashM_currency:
            return NSLocalizedString(@"币种", @"");
        case tCashM_margLimit:
            return NSLocalizedString(@"贷款限额", @"");
        case tCashM_margAvai:
            return NSLocalizedString(@"按揭价值", @"");
        case tCashM_check1:
            return NSLocalizedString(@"支票存入", @"");
        case tCashM_canTransfer:
            return NSLocalizedString(@"可转账金额", @"");
        case tCashM_canFetch:
            return NSLocalizedString(@"可取金额", @"");
        case tCashM_dayTrade:
            return NSLocalizedString(@"买卖约价", @"");
        case tCashM_interest:
            return NSLocalizedString(@"应计利息", @"");
        case tCashM_unsettled:
            return NSLocalizedString(@"未交收", @"");
        case tCashM_ecgTotal:
            return NSLocalizedString(@"总金额", @"");
        default:
            return @"";;
    }
    
    
}
- (NSString*) getHoldingMemberName:(emTHoldingMember)t{
     switch (t) {
         case tHoldingM_Name:
             return NSLocalizedString(@"名称", @"");
         case tHoldingM_MarketValue:
             return NSLocalizedString(@"市值", @"");
         case tHoldingM_Cost:
             return NSLocalizedString(@"成本", @"");
         case tHoldingM_CurrentPrice:
             return NSLocalizedString(@"现价", @"");
         case tHoldingM_Available:
             return NSLocalizedString(@"可用", @"");
         case tHoldingM_Holding:
             return NSLocalizedString(@"持仓", @"");
         case tHoldingM_ProfitLoss:
             return NSLocalizedString(@"浮盈(%)", @"");
         default:
             return @"";
     }
}

- (emTHoldingMember) getHoldingMemberCode:(NSString*)name{
    if([name isEqualToString:NSLocalizedString(@"市值", @"")]){
        return tHoldingM_MarketValue;
    }
    if([name isEqualToString:NSLocalizedString(@"现价", @"")]){
        return tHoldingM_CurrentPrice;
    }
    if([name isEqualToString:NSLocalizedString(@"持仓", @"")]){
        return tHoldingM_Holding;
    }
    if([name isEqualToString:NSLocalizedString(@"浮盈(%)", @"")]){
        return tHoldingM_ProfitLoss;
    }
    if([name isEqualToString:NSLocalizedString(@"成本", @"")]){
        return tHoldingM_CurrentPrice;
    }
    if([name isEqualToString:NSLocalizedString(@"可用", @"")]){
        return tHoldingM_Available;
    }
    if([name isEqualToString:NSLocalizedString(@"名称", @"")]){
        return tHoldingM_Name;
    }
    return tHoldingM_MarketValue;
}




- (void)holdingVCResetCellDataSourceWithCell:(UITableViewCell*)cell{
    UILabel *name = (UILabel*)[cell.contentView viewWithTag:10001];
    UIImageView *flagImg = (UIImageView*)[cell.contentView viewWithTag:10002];
    UILabel *stockCode = (UILabel*)[cell.contentView viewWithTag:10003];
    TTTAttributedLabel *marketValue = (TTTAttributedLabel*)[cell.contentView viewWithTag:10004];
    UILabel *currentPrice = (UILabel*)[cell.contentView viewWithTag:20001];
    UILabel *cost = (UILabel*)[cell.contentView viewWithTag:20002];
    UILabel *holding = (UILabel*)[cell.contentView viewWithTag:30001];
    UILabel *avilible = (UILabel*)[cell.contentView viewWithTag:30002];
    TTTAttributedLabel *profitLoss = (TTTAttributedLabel*)[cell.contentView viewWithTag:40001];
    UILabel *profitLossRate = (UILabel*)[cell.contentView viewWithTag:40002];
    
    name.text = @"腾讯控股";
    flagImg.image = [UIImage imageNamed:@"comm_market_type_hk"];
    stockCode.text = @"00017";
    marketValue.text = @"2,558,000.00";
    currentPrice.text = @"121.80";
    cost.text = @"155.80";
    holding.text = @"1,000";
    avilible.text = @"1,000";
    profitLoss.text = @"+345,000.00";
    profitLossRate.text = @"+27.91%";
}

- (void)holdingSortByWitchOne:(NSString*)name orderby:(BOOL)isAscending{
    NSLog(@"sort by %@ : %d", name, isAscending);
    
    
    
}


- (UIImage*)getFlagImageWithNamed:(NSString*)imgname{
    if([imgname isEqualToString: MKT_HKG])
        return [UIImage imageNamed:@"market_HK"];
    if([imgname isEqualToString: MKT_USA])
        return [UIImage imageNamed:@"market_market"];
    if([imgname isEqualToString: MKT_SZA])
        return [UIImage imageNamed:@"market_CN"];
    
    return nil;
}


- (NSString*)getMarketWithNamed:(NSString*)marname{
    if([marname isEqualToString: MKT_HKG])
        return NSLocalizedString(@"港股", @"");
    if([marname isEqualToString: MKT_USA])
        return NSLocalizedString(@"美股", @"");
    if([marname isEqualToString: MKT_SZA])
        return NSLocalizedString(@"A股", @"");
    
    
    return marname;
}



@end
