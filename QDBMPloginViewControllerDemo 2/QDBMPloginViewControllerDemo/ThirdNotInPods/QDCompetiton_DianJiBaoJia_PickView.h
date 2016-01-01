//
//  QDCompetiton_DianJiBaoJia_PickView.h
//  iQDII_GKS
//
//  Created by hydra on 15-3-15.
//  Copyright (c) 2015年 TSCI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QDCompetitionHorizontallyLine.h"
@class QDCompetiton_DianJiBaoJia_PickView;

typedef enum{
    DianJiBaoJia_buy1,
    DianJiBaoJia_buy2,
    DianJiBaoJia_buy3,
    DianJiBaoJia_buy4,
    DianJiBaoJia_buy5,
    DianJiBaoJia_buy6,
    DianJiBaoJia_buy7,
    DianJiBaoJia_buy8,
    DianJiBaoJia_buy9,
    DianJiBaoJia_buy10,
    DianJiBaoJia_high,
    DianJiBaoJia_prvClose,
    DianJiBaoJia_Nominal,
    
    DianJiBaoJia_sell1,
    DianJiBaoJia_sell2,
    DianJiBaoJia_sell3,
    DianJiBaoJia_sell4,
    DianJiBaoJia_sell5,
    DianJiBaoJia_sell6,                             
    DianJiBaoJia_sell7,
    DianJiBaoJia_sell8,
    DianJiBaoJia_sell9,
    DianJiBaoJia_sell10,
    DianJiBaoJia_low,
    DianJiBaoJia_open,
    DianJiBaoJia_zhangFu,
}emDianJiBaoJiaType;

@protocol QDCompetitonOrder_DianJiBaoJia_PickerViewDelegate<NSObject>
@optional
- (void)closeWithPicker:(QDCompetiton_DianJiBaoJia_PickView*)datePicker;
- (void)refreshWithPicker:(QDCompetiton_DianJiBaoJia_PickView*)datePicker;
/**
 *  点击报价的按钮响应返回指定的价格
 *
 *  @param dataPicker 指定的picker
 */
- (void)clickButtonWithPicker:(QDCompetiton_DianJiBaoJia_PickView*)dataPicker price:(NSString*)price type:(emDianJiBaoJiaType)type;
@end


//cell里面button的delegate
@class CompetitonDianJiBaoJiaPickerTableViewCell;
@protocol QDDianJiBaoJiaCellDelegate<NSObject>
@optional
- (void)clickButtonWithIsLeft:(BOOL)isLeft cell:(CompetitonDianJiBaoJiaPickerTableViewCell*)cell;
@end

@interface QDCompetiton_DianJiBaoJia_PickView : UIView<UITableViewDataSource,UITableViewDelegate,QDDianJiBaoJiaCellDelegate>
@property (nonatomic,strong)NSString *title;

@property (nonatomic,strong)NSMutableArray *dianJiBaoJiaArray;

@property (nonatomic,strong)NSMutableDictionary *dianJiBaoJiaDictionary;

@property (nonatomic,weak)id<QDCompetitonOrder_DianJiBaoJia_PickerViewDelegate> pickerViewDelegate;

@property (nonatomic,strong)QDCompetitionHorizontallyLine *horLine;

-(id)initWithParentView:(UIView*)parentView;
#pragma mark - Show and Dismiss

- (void)show;
- (void)dismiss;

+(NSString*)getNameOfType:(emDianJiBaoJiaType)type;
+(NSString*)getValOfType:(emDianJiBaoJiaType)type dic:(NSMutableDictionary*)dic;
+(NSString*)getValAndVolOfType:(emDianJiBaoJiaType)type dic:(NSMutableDictionary*)dic;
+(NSString*)getValOfTypeUseforMRS:(emDianJiBaoJiaType)type dic:(NSMutableDictionary*)dic;
@end
