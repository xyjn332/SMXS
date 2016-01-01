//
//  QDCompetiton_SelectMarket_PickView.h
//  iQDII_GKS
//
//  Created by hydra on 15-3-19.
//  Copyright (c) 2015年 TSCI. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QDCompetiton_SelectMarket_PickView;
@protocol QDCompetitonOrder_SelectMarket_PickerViewDelegate<NSObject>
@optional
- (void)selectMarketCloseWithPicker:(QDCompetiton_SelectMarket_PickView*)datePicker;
- (void)selectMarketRowWithPicker:(QDCompetiton_SelectMarket_PickView*)dataPicker row:(NSInteger)row;
@end

@interface QDCompetiton_SelectMarket_PickView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSString *curMarket;

/**
 *  标题label
 */
@property (nonatomic,strong)UILabel *titleLabel;

@property (nonatomic,strong)NSMutableArray *marketArray;

@property (nonatomic,weak)id<QDCompetitonOrder_SelectMarket_PickerViewDelegate> pickerViewDelegate;

-(id)initWithParentView:(UIView*)parentView;

#pragma mark - Show and Dismiss

- (void)show;
- (void)dismiss;
@end
