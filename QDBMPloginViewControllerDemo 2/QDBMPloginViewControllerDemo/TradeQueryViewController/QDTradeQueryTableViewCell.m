//
//  QDTradeQueryTableViewCell.m
//  QDBMPloginViewControllerDemo
//
//  Created by Weber on 15/8/13.
//  Copyright (c) 2015年 tsci. All rights reserved.
//

#import "QDTradeQueryTableViewCell.h"
#import "Masonry.h"
#import "QDCompetitionHorizontallyLine.h"

@interface QDTradeQueryTableViewCell()



@end

@implementation QDTradeQueryTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    _leftImageView = [UIImageView new];
    [self.contentView addSubview:_leftImageView];
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.leftImageView.frame = CGRectMake(AdjustWidth(10), AdjustHeight(9), AdjustHeight(18), AdjustHeight(18));

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
