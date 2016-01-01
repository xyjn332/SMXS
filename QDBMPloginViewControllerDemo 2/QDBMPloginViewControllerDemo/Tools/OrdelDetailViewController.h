//
//  OrdelDetailViewController.h
//  QDBMPloginViewControllerDemo
//
//  Created by brkt on 15/8/30.
//  Copyright (c) 2015年 tsci. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrdelDetailViewController : UIViewController

@property (nonatomic,strong)NSMutableArray *arry;
@property (nonatomic,strong)NSDictionary   *dic;

@end


@interface TopTableviewCell : UITableViewCell

@property (nonatomic,strong) UILabel *leftTitleLabel;

@property (nonatomic,strong) UILabel *leftContentLabel;

@property (nonatomic,strong) UILabel *rightTitleLabel;

@property (nonatomic,strong) UILabel *rightContentLabel;


- (void)resetcellContent:(NSString *)leftTitle LeftConten:(NSString *)leftContent RightTitle:(NSString *)rightTitle RightContent:(NSString *)rightContent;

@end
