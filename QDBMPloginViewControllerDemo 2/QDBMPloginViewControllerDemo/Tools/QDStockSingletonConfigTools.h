//
//  QDStockSingletonConfigTools.h
//  QDBMPloginViewControllerDemo
//
//  Created by Weber on 15/8/4.
//  Copyright (c) 2015年 tsci. All rights reserved.
//

/**
 券商版本要分开，这个文件中存放券商自己的配置属性
 分项目时，要随券商一起拷贝
 */
#import <Foundation/Foundation.h>

@interface QDStockSingletonConfigTools : NSObject


+(instancetype)sharedManager;
/**
 获取资金静态label名
 */
- (NSString*) getMemberName:(emTCashMember)t;
/**
 获取持仓静态label名
 */
- (NSString*) getHoldingMemberName:(emTHoldingMember)t;
/**
 持仓排序
 */
- (void)holdingSortByWitchOne:(NSString*)name orderby:(BOOL)isAscending;
/**
 持仓填充数据
 */
- (void)holdingVCResetCellDataSourceWithCell:(UITableViewCell*)cell;

/**
 市场国旗
 */
- (UIImage*)getFlagImageWithNamed:(NSString*)imgname;

/**
 市场名称
 */
- (NSString*)getMarketWithNamed:(NSString*)marname;
@end
