//
//  OrdelDetailViewController.m
//  QDBMPloginViewControllerDemo
//
//  Created by brkt on 15/8/30.
//  Copyright (c) 2015年 tsci. All rights reserved.
//

#import "OrdelDetailViewController.h"
#import "TTTAttributedLabel.h"


#define TopInfoTableRowHight 28
#define FootInfoTableRowHight 34
#define LateralInset        5
#define gationBarHight  [UIScreen mainScreen ].applicationFrame.origin.y+self.navigationController.navigationBar.frame.size.height

@interface OrdelDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *TopInfoTable;
@property (nonatomic,strong)UITableView *FootInfoTable;
@property (nonatomic,strong)NSMutableArray *TitleArry;
@property (nonatomic,strong)NSMutableArray *ContentArry;
@property (nonatomic,strong)NSMutableArray *FootDataArry;
@end

@implementation OrdelDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setCellDate];
    [self creatTable1];
    [self creatTable2];

}
- (void)setCellDate{
    self.TitleArry    = [NSMutableArray array];
    self.ContentArry  = [NSMutableArray array];
    self.FootDataArry = [NSMutableArray array];
    NSArray *sortedArray = [[self.dic allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    for (NSMutableString *Key in sortedArray) {
        
        if (![Key isEqual:sortedArray.lastObject]) {
            NSString *Title = [Key  substringFromIndex:[Key rangeOfString:@"_"].location+1];
            NSString *Content = [self.dic objectForKey:Key];
            [self.TitleArry addObject:Title];
            [self.ContentArry addObject:Content];
        }
        else{
            if ([[self.dic objectForKey:sortedArray.lastObject] isKindOfClass: [NSMutableArray class]]) {
                self.FootDataArry =  [self.dic objectForKey:sortedArray.lastObject];
            }
            
        }
        
    }
}
- (void)creatTable1{
    self.TopInfoTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,ScreenHeight*0.28) style:UITableViewStylePlain];
    self.TopInfoTable.backgroundColor = [QDTool hexStringToColor:@"#1d2228"];
    self.TopInfoTable.delegate = self;
    self.TopInfoTable.dataSource = self;
    self.TopInfoTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.TopInfoTable];

}
- (void)creatTable2{
    self.FootInfoTable = [[UITableView alloc]initWithFrame:CGRectMake(0, self.TopInfoTable.frame.size.height, ScreenWidth,ScreenHeight-(self.TopInfoTable.frame.size.height+self.TopInfoTable.frame.origin.y)-([UIScreen mainScreen ].applicationFrame.origin.y+self.navigationController.navigationBar.frame.size.height)) style:UITableViewStylePlain];
    self.FootInfoTable.backgroundColor =[UIColor whiteColor];
    self.FootInfoTable.delegate = self;
    self.FootInfoTable.dataSource = self;
    [self.view addSubview:self.FootInfoTable];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView ==self.TopInfoTable)
        return TopInfoTableRowHight;
        return FootInfoTableRowHight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.TopInfoTable) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
 

}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, TopInfoTableRowHight)];
    headerview.backgroundColor =  UIColorFromRGBA(0xeef2f6, 1.0);
    NSArray *Title = @[@"时间",@"成交价",@"数量"];
    CGFloat X = 0;
    for (NSString *title in Title) {
        
        UILabel *TitleLable = [[UILabel alloc]initWithFrame:CGRectMake(X, 0, 40, 30)];
        TitleLable.text = title;
        TitleLable.textAlignment = NSTextAlignmentCenter;
        TitleLable.textColor = [UIColor grayColor];
        TitleLable.shadowColor = [UIColor clearColor];
        TitleLable.font = [UIFont systemFontOfSize:11];
        [headerview addSubview:TitleLable];
        X = X+((ScreenWidth-CGRectGetWidth(TitleLable.frame))/((Title.count)-1));
    }
    return headerview;

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView ==self.FootInfoTable)
    return TopInfoTableRowHight;
    return 0;
}
#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     NSInteger row=indexPath.row;
    if (tableView == self.TopInfoTable) {
        static NSString *CellIdentifier = @"TopCellIdentifier";
        TopTableviewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        if (self.TitleArry.count>row*2+1) {
            NSString *lefttitle    = [self.TitleArry   objectAtIndex:row*2];
            NSString *leftContent  = [self.ContentArry objectAtIndex:row*2];
            NSString *rightContent = [self.ContentArry objectAtIndex:row*2+1];
            NSString *righttitle   = [self.TitleArry   objectAtIndex:row*2+1];
            if (cell == nil) {
                cell = [[TopTableviewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
                
                [cell resetcellContent:lefttitle LeftConten:leftContent RightTitle:righttitle RightContent:rightContent];
            }
        }
        else{
            NSString *lefttitle    = [self.TitleArry   objectAtIndex:row*2];
            NSString *leftContent  = [self.ContentArry objectAtIndex:row*2];
            if (cell == nil) {
                cell = [[TopTableviewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
                [cell resetcellContent:lefttitle LeftConten:leftContent RightTitle:@"" RightContent:@""];
            }
        }
        return cell;
    }
    else{
        UITableViewCell *CELL = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        return CELL;
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.TopInfoTable) {
        return (self.TitleArry.count+1)/2;
    }
    else{
        return 20;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
@interface TopTableviewCell()
@property (nonatomic,copy)NSString *leftText;
@property (nonatomic,copy)NSString *leftcontent;
@property (nonatomic,copy)NSString *rightText;
@property (nonatomic,copy)NSString *rightContent;
@end

@implementation TopTableviewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
   self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [QDTool hexStringToColor:@"#1d2228"];
        UILabel *LeftTitleLabel = [[UILabel alloc]init];
       
        [LeftTitleLabel setFont:[UIFont fontWithName:@"Arial" size:16.0]];
        [LeftTitleLabel setTextColor:UIColorFromRGBA(0x676767, 1.0)];
        LeftTitleLabel.textAlignment = NSTextAlignmentLeft;
        LeftTitleLabel.adjustsFontSizeToFitWidth = YES;
        LeftTitleLabel.shadowColor = UIColor.clearColor;
        LeftTitleLabel.shadowOffset = CGSizeMake(.0, .0);
        [self.contentView addSubview:LeftTitleLabel];
        self.leftTitleLabel = LeftTitleLabel;
        
        UILabel *RightTitleLabel = [[UILabel alloc]init];
        RightTitleLabel.textColor = [UIColor redColor];
        [RightTitleLabel setFont:[UIFont fontWithName:@"Arial" size:16.0]];
        [RightTitleLabel setTextColor:UIColorFromRGBA(0x676767, 1.0)];
        RightTitleLabel.textAlignment = NSTextAlignmentLeft;
        RightTitleLabel.adjustsFontSizeToFitWidth = YES;
        RightTitleLabel.shadowColor = UIColor.clearColor;
        RightTitleLabel.shadowOffset = CGSizeMake(.0, .0);
        [self.contentView addSubview:RightTitleLabel];
        self.rightTitleLabel = RightTitleLabel;
        
        UILabel *LeftContentLabel = [[UILabel alloc]init];
        LeftContentLabel.textAlignment = NSTextAlignmentRight;
        LeftContentLabel.adjustsFontSizeToFitWidth = YES;
        LeftContentLabel.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:LeftContentLabel];
        self.leftContentLabel = LeftContentLabel;
        
        UILabel *RightContentLabel = [[UILabel alloc]init];
        RightContentLabel.textAlignment = NSTextAlignmentRight;
        RightContentLabel.adjustsFontSizeToFitWidth = YES;
        RightContentLabel.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:RightContentLabel];
         self.rightContentLabel = RightContentLabel;
    }

    return self;
}

- (void)resetcellContent:(NSString *)leftTitle LeftConten:(NSString *)leftContent RightTitle:(NSString *)rightTitle RightContent:(NSString *)rightContent{
    _leftText = leftTitle;  _leftcontent = leftContent;_rightText = rightTitle; _rightContent = rightContent;
    self.leftContentLabel.text  = leftContent;
    self.rightContentLabel.text = rightContent;
    self.leftTitleLabel.text    = leftTitle;
    self.rightTitleLabel.text   = rightTitle;

    if ([_leftText isEqual:@"证券操作"]) {
        if ([leftContent isEqual:@"买入"])
        self.leftContentLabel.textColor = [UIColor redColor];
        else
        self.leftContentLabel.textColor = [UIColor greenColor];
    }
    else if ([_rightText isEqual:@"证券操作"]){
        if ([rightContent isEqual:@"买入"])
        self.rightContentLabel.textColor = [UIColor redColor];
        else
        self.rightContentLabel.textColor = [UIColor greenColor];
    }
    else if ([_leftText isEqual:@"委托价格"]||[_leftText isEqual:@"成交均价"]) {
        double price =  [_leftcontent doubleValue];
        self.leftContentLabel.text = [QDTool trimStringAmount:[NSString stringWithFormat:@"%.2f", price]];
    }
    else if ([_rightText isEqual:@"委托价格"]||[_rightText isEqual:@"成交均价"]){
        double price =  [_rightContent doubleValue];
        self.rightContentLabel.text = [QDTool trimStringAmount:[NSString stringWithFormat:@"%.2f", price]];
    }
    else if ([_leftText isEqual:@"委托数量"]||[_leftText isEqual:@"成交数量"]) {
        NSInteger amount =  [_leftcontent integerValue];
        self.leftContentLabel.text = [QDTool trimStringAmount:[NSString stringWithFormat:@"%ld", amount]];
    }
    else if ([_rightText isEqual:@"委托数量"]||[_rightText isEqual:@"成交数量"]){
        NSInteger amount =  [_rightContent integerValue];
        self.rightContentLabel.text = [QDTool trimStringAmount:[NSString stringWithFormat:@"%ld", amount]];
    }
    [self setTopCellFram];
}

- (void)setTopCellFram{
    self.leftTitleLabel.frame = CGRectMake(LateralInset, 0, 45, 30);
    NSLog(@"%f",self.center.x);
    self.leftContentLabel.frame = CGRectMake(LateralInset+self.leftTitleLabel.frame.size.width, 0, ScreenWidth/2-self.leftTitleLabel.frame.size.width-2*LateralInset, 30);
    self.rightTitleLabel.frame = CGRectMake(ScreenWidth/2+LateralInset, 0, 45, 30);
    self.rightContentLabel.frame = CGRectMake(LateralInset+self.rightTitleLabel.frame.size.width+ScreenWidth/2, 0, self.leftContentLabel.frame.size.width, 30);
}
-(void)layoutSubviews{


}
@end
