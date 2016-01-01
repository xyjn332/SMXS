//
//  QDOrdelNavigationController.h
//  iQDII_CIC
//
//  Created by brkt on 15/10/18.
//  Copyright © 2015年 TSCI. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  TTTAttributedLabel;

@interface QDOrdelNavigationController : UINavigationController

@property (nonatomic, strong)TTTAttributedLabel *referenceAmount;//参考金额
@property (nonatomic, strong)UILabel *referenceAmountByChinese;//参考金额中文标示
@property (nonatomic, strong)UIButton *clearButton; //清除
@property (nonatomic, strong)UIButton *actionButon; //动作按钮
@end
