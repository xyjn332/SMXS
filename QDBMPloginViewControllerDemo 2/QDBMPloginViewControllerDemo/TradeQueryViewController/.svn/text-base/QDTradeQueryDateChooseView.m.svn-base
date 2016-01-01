//
//  QDTradeQueryDateChooseView.m
//  QDBMPloginViewControllerDemo
//
//  Created by Weber on 15/8/15.
//  Copyright (c) 2015年 tsci. All rights reserved.
//

#import "QDTradeQueryDateChooseView.h"




@interface QDTradeQueryDateChooseView()<FlatDatePickerDelegate>

@property (nonatomic, strong)UILabel *startLabel;
@property (nonatomic, strong)UILabel *endLabel;
@property (nonatomic)NSInteger currentSelectButtonIndex;//区别点击的是start还是end

@end

@implementation QDTradeQueryDateChooseView


- (id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self initializeData];
       
        [self createUI];
        
    }
    return self;
}

#pragma mark - initilalize

- (void)initializeData{
    self.hasShowFlatDatePicker = NO;
    self.endDate = [NSDate date];
    _startDate = [[NSDate alloc] initWithTimeInterval:-604800 sinceDate:self.endDate];
    NSLog(@"");
}


#pragma mark - createUI

- (void)createUI{
    
    self.backgroundColor = UIColorFromRGBA(0x1d2228, 1.0);
    
    CGSize size = [QDTool getStringSizeWithString:@"2015-06-12" font:[UIFont systemFontOfSize:AdjustFontSize(16)] lableHeight:1000 width:1000];
    CGSize staticLablesize = [QDTool getStringSizeWithString:@"起始日期" font:[UIFont systemFontOfSize:AdjustFontSize(12)] lableHeight:1000 width:1000];
    
    CGFloat offset = (ScreenWidth - size.width*2 - AdjustWidth(31))/4;
    UIControl *backgroundLeft = [[UIControl alloc] initWithFrame:CGRectMake(offset, (self.frame.size.height-(size.height+staticLablesize.height+AdjustHeight(5)))/2, size.width, size.height+staticLablesize.height+AdjustHeight(5))];
    [backgroundLeft addTarget:self action:@selector(startDateAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backgroundLeft];
    
    CGFloat staticLabelOffset = (size.width-(staticLablesize.width+AdjustWidth(5)+AdjustHeight(10)))/2;
    
    UILabel *staticStartLabel = [QDTool createLabelWithFrame:CGRectMake(staticLabelOffset, 0, staticLablesize.width, AdjustHeight(10)) fontColor:UIColorFromRGBA(0x676767, 1.0) fontSize:AdjustFontSize(12) textAligment:NSTextAlignmentCenter];
    staticStartLabel.text = @"起始日期";
    [backgroundLeft addSubview:staticStartLabel];
    UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(staticStartLabel.frame)+AdjustWidth(5), staticStartLabel.frame.origin.y, AdjustHeight(10), AdjustHeight(10))];
    arrow.image = [UIImage imageNamed:@"black_begin"];
    [backgroundLeft addSubview:arrow];
    _startLabel = [QDTool createLabelWithFrame:CGRectMake(0, backgroundLeft.frame.size.height-size.height, size.width, size.height) fontColor:[UIColor whiteColor] fontSize:AdjustFontSize(16) textAligment:NSTextAlignmentCenter];
    
    _startLabel.text = [QDTool dateWithFormat:self.startDate];
    [backgroundLeft addSubview:_startLabel];
    
    
    UIImageView *arrowRightImg = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(backgroundLeft.frame)+offset, (self.frame.size.height-AdjustHeight(31))/2, AdjustHeight(31), AdjustHeight(31))];
    arrowRightImg.image = [UIImage imageNamed:@"black_direction"];
    [self addSubview:arrowRightImg];
    
    UIControl *backgroundRight = [[UIControl alloc] initWithFrame:CGRectMake(CGRectGetMaxX(arrowRightImg.frame)+offset, backgroundLeft.frame.origin.y, size.width, backgroundLeft.frame.size.height)];
    [backgroundRight addTarget:self action:@selector(endDateAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backgroundRight];
    
    UILabel *staticEndLabel = [QDTool createLabelWithFrame:CGRectMake(staticLabelOffset, 0, staticLablesize.width, AdjustHeight(10)) fontColor:UIColorFromRGBA(0x676767, 1.0) fontSize:AdjustFontSize(12) textAligment:NSTextAlignmentCenter];
    staticEndLabel.text = @"结束日期";
    [backgroundRight addSubview:staticEndLabel];
    UIImageView *arrowEnd = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(staticEndLabel.frame)+AdjustWidth(5), staticEndLabel.frame.origin.y, AdjustHeight(10), AdjustHeight(10))];
    arrowEnd.image = [UIImage imageNamed:@"black_end"];
    [backgroundRight addSubview:arrowEnd];
    _endLabel = [QDTool createLabelWithFrame:CGRectMake(0, backgroundRight.frame.size.height-size.height, size.width, size.height) fontColor:[UIColor whiteColor] fontSize:AdjustFontSize(16) textAligment:NSTextAlignmentCenter];
    _endLabel.text = [QDTool dateWithFormat:self.endDate];
    [backgroundRight addSubview:_endLabel];
}

#pragma  mark -- 时间选择器
-(void)createPickViewController
{
    _flatDatePicker = [[FlatDatePicker alloc] initWithParentView:[[[UIApplication sharedApplication] delegate] window]];
    self.flatDatePicker.delegate = self;
    self.flatDatePicker.title = NSLocalizedString(@"请选择日期:",@"");
    self.flatDatePicker.datePickerMode = FlatDatePickerModeTime;
    [self.flatDatePicker setDatePickerMode:FlatDatePickerModeDate];
}

- (FlatDatePicker*)flatDatePicker{
    if(_flatDatePicker == nil){
        _flatDatePicker = [[FlatDatePicker alloc] initWithParentView:[[[UIApplication sharedApplication] delegate] window]];
        _flatDatePicker.delegate = self;
        _flatDatePicker.title = NSLocalizedString(@"请选择日期:",@"");
        _flatDatePicker.datePickerMode = FlatDatePickerModeTime;
        [_flatDatePicker setDatePickerMode:FlatDatePickerModeDate];
    }
    return _flatDatePicker;
}

#pragma  mark -- 关闭picker
- (void)flatDatePicker:(FlatDatePicker*)datePicker didCancel:(UIButton*)sender {
    
    [self.flatDatePicker dismiss];
    self.hasShowFlatDatePicker = NO;
}

#pragma  mark -- datePicker didValid
- (void)flatDatePicker:(FlatDatePicker*)datePicker didValid:(UIButton*)sender date:(NSDate*)date {
    
    [[DateWithFormat sharedManager] setLocale:[NSLocale currentLocale]];
    
    if (datePicker.datePickerMode == FlatDatePickerModeDate) {
        [[DateWithFormat sharedManager] setDateFormat:@"yyyy-MM-dd"];
    } else if (datePicker.datePickerMode == FlatDatePickerModeTime) {
        [[DateWithFormat sharedManager] setDateFormat:@"HH:mm:ss"];
    } else {
        [[DateWithFormat sharedManager] setDateFormat:@"dd MMMM yyyy HH:mm:ss"];
    }
    
    NSString *value = [[DateWithFormat sharedManager] stringFromDate:date];
    if(self.currentSelectButtonIndex==0)
    {
        self.startDate = [[DateWithFormat sharedManager] dateFromString:value];
        self.startLabel.text = value;
    }
    else
    {
        self.endDate = [[DateWithFormat sharedManager] dateFromString:value];
        self.endLabel.text = value;
    }

    NSTimeInterval  datetime =0;

    datetime = [self.endDate timeIntervalSinceNow] -  [self.startDate timeIntervalSinceNow] ;

    datetime= datetime/(24*3600);
    
    if (datetime<0) {
        [[[[UIApplication sharedApplication] delegate] window] makeToast:@"开始日期不能大于结束日期" duration:3 position:@"center"];
        [self resetDate];
        return;
    }
    
    if (datetime>90) {
        [[[[UIApplication sharedApplication] delegate] window] makeToast:@"开始日期与结束日期间隔不得超过90天" duration:3 position:@"center"];
        [self resetDate];
        return;
    }
    
    
    [self.flatDatePicker dismiss];
    self.hasShowFlatDatePicker = NO;
    
}


#pragma mark 复位日期
- (void)resetDate{
    self.endDate = [NSDate date];
    self.startDate = [[NSDate alloc] initWithTimeInterval:-604800 sinceDate:self.endDate];
    self.startLabel.text = [QDTool dateWithFormat:self.startDate];
    self.endLabel.text = [QDTool dateWithFormat:self.endDate];
}

#pragma mark - button action
- (void)startDateAction:(UIControl*)control{
    self.currentSelectButtonIndex = 0;
    [self.flatDatePicker show];
    self.hasShowFlatDatePicker = YES;
}

- (void)endDateAction:(UIControl*)control{
    self.currentSelectButtonIndex = 1;
    [self.flatDatePicker show];
    self.hasShowFlatDatePicker = YES;
}

//- (void)layoutSubviews{
//    
//}

@end
