//
//  QDTradeMoreCollectionViewCell.m
//  QDBMPloginViewControllerDemo
//
//  Created by Weber on 15/8/17.
//  Copyright (c) 2015年 tsci. All rights reserved.
//

#import "QDTradeMoreCollectionViewCell.h"
#import "Masonry.h"

@implementation QDTradeMoreCollectionViewCell
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if(self != nil){
        _logoImgButton = [UIImageView new];//[UIButton buttonWithType:UIButtonTypeCustom];
        _logoImgButton.frame = CGRectMake((self.frame.size.width-AdjustHeight(34))/2, 0, AdjustHeight(34), AdjustHeight(34));
        [self addSubview:_logoImgButton];
        _titleLabel = [UILabel new];
        _titleLabel.frame = CGRectMake(0, CGRectGetMaxY(_logoImgButton.frame)+AdjustHeight(13), self.frame.size.width, self.frame.size.height-CGRectGetMaxY(_logoImgButton.frame)-AdjustHeight(13));
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:AdjustFontSize(16)];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_titleLabel];
//        WS(ws);
        
        
        
//        [_logoImgButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(ws.mas_centerY);
//            make.top.equalTo(ws.mas_top);
//            make.bottom.equalTo(ws.mas_bottom)
//            make.size.mas_equalTo(CGSizeMake(34, 34));
//            
////            make.edges.equalTo(ws).with.insets(UIEdgeInsetsMake(0, 0, 28, 0));
//        }];
//        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(ws).with.insets(UIEdgeInsetsMake(56, 0, 0, 0));
//        }];
    }
    return self;
}
@end
