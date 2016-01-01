//
//  QDCapitalDistibuteDiagramView.h
//  QDBMPloginViewControllerDemo
//
//  Created by Weber on 15/7/3.
//  Copyright (c) 2015年 tsci. All rights reserved.
//  资金分布图 + cell

#import <UIKit/UIKit.h>

@interface QDCapitalDistibuteDiagramView : UIView

@property (nonatomic) CGFloat leftTotal; //账面结余
@property (nonatomic) CGFloat freezeCapital; //冻结资金
@property (nonatomic) CGFloat totalMarketValue; //总市值
@property (nonatomic,strong)NSMutableArray *sepLineArr;//分割线
@property (nonatomic, strong)NSMutableArray *textArr; //显示比例
@property (nonatomic) CGFloat radius;
@property (nonatomic) CGFloat fontSize;


- (id)initWithLeftTotal:(CGFloat)lt freezeCapital:(CGFloat)fc totalMarketValue:(CGFloat)tm;
- (void)resetLeftTotal:(CGFloat)lt freezeCapital:(CGFloat)fc totalMarketValue:(CGFloat)tm;
- (void)begainAnimations;
@end


@interface QDCapitalDistibuteDiagramCell : UITableViewCell

@property (nonatomic, strong) QDCapitalDistibuteDiagramView *sector;//扇形图
@property (nonatomic, strong) NSMutableArray *dataSource; //数据源
@property (nonatomic)CGFloat radius;//扇形半径

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withRadius:(CGFloat)radius;

- (void)resetLeftTotal:(CGFloat)lt freezeCapital:(CGFloat)fc totalMarketValue:(CGFloat)tm;

@end
