//
//  QDCompetiton_SelectMarket_PickView.m
//  iQDII_GKS
//
//  Created by hydra on 15-3-19.
//  Copyright (c) 2015年 TSCI. All rights reserved.
//

#import "QDCompetiton_SelectMarket_PickView.h"
#import "QDCompetitionHorizontallyLine.h"
static const CGFloat pickerHeight=260.0f;
static const CGFloat buttonWidthAndHeight=44.0f;
static const CGFloat rowHeight=35.0f;

@interface QDCompetiton_SelectMarket_PickView()
/**
 *  左上角取消按钮
 */
@property (nonatomic,strong)UIButton *closeButton;


/**
 *  数据tableview
 */
@property (nonatomic,strong)UITableView *tableView;

/**
 *  父视图
 */
@property (nonatomic,strong)UIView *parentView;

@end

@implementation QDCompetiton_SelectMarket_PickView

-(id)initWithParentView:(UIView*)parentView{
    
    
    self.parentView=parentView;
    self=[super initWithFrame:CGRectMake(0, self.parentView.frame.size.height, self.parentView.frame.size.width, pickerHeight)];
    if(self){
        self.parentView = parentView;
        [self.parentView addSubview:self];
        [self createUI];
    }
    return self;
}

#pragma mark - UI
-(void)createUI
{
    self.backgroundColor=UIColorFromRGBA(0x222222, 1.0);
    [self createHeader];
}

-(void)createHeader
{
    self.closeButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.closeButton.frame=CGRectMake(0, 0, buttonWidthAndHeight, buttonWidthAndHeight);
    [self.closeButton setBackgroundImage:[UIImage imageNamed:@"JYB_Competiton_CancelOrder_Picker_Close_Grow.png"] forState:UIControlStateNormal];
    [self.closeButton setBackgroundImage:[UIImage imageNamed:@"JYB_Competiton_CancelOrder_Picker_Close.png"] forState:UIControlStateHighlighted];
    [self.closeButton addTarget:self action:@selector(closeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.closeButton];
    
    CGFloat titleWidth=80.0f;
    self.titleLabel=[QDTool createLabelWithFrame:CGRectMake((self.frame.size.width-titleWidth)/2, 0.0, titleWidth, buttonWidthAndHeight) fontColor:[UIColor whiteColor] fontSize:18 textAligment:NSTextAlignmentCenter];
    [self addSubview:self.titleLabel];
    
    QDCompetitionHorizontallyLine *line=[[QDCompetitionHorizontallyLine alloc] initWithFrame:CGRectMake(buttonWidthAndHeight, buttonWidthAndHeight-0.5, self.frame.size.width-buttonWidthAndHeight, 0.5) lineColor:UIColorFromRGBA(0xcdcdcd, 1.0)];
    [self addSubview:line];
    
    self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, buttonWidthAndHeight, self.frame.size.width, pickerHeight-buttonWidthAndHeight) style:UITableViewStylePlain];
    self.tableView.backgroundColor=UIColorFromRGBA(0x222222, 1.0);
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tableView];
}

-(void)setMarketArray:(NSMutableArray *)marketArray
{
    _marketArray=marketArray;
    [self.tableView reloadData];
}


#pragma mark - 按钮点击事件
-(void)closeButtonClick
{
    if(self.pickerViewDelegate!=nil && [self.pickerViewDelegate respondsToSelector:@selector(selectMarketCloseWithPicker:)])
    {
        [self.pickerViewDelegate selectMarketCloseWithPicker:self];
    }
}



#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(self.pickerViewDelegate!=nil && [self.pickerViewDelegate respondsToSelector:@selector(selectMarketRowWithPicker: row:)])
    {
          if(self.marketArray.count>indexPath.row)
            {
                self.curMarket =self.marketArray[indexPath.row];
                [self.pickerViewDelegate selectMarketRowWithPicker:self row:indexPath.row];
                
            }
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"cell";
    UITableViewCell *cell=(UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor=[UIColor clearColor];
        cell.selectionStyle=UITableViewCellSelectionStyleGray;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        UIImageView *flagImg = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth/2-40, (rowHeight-12.5)/2, 16, 12.5)];
        flagImg.tag = 10001;
        [cell.contentView addSubview:flagImg];
    }
    UIImageView *flagImg = (UIImageView*)[cell viewWithTag:10001];
//
//    if([[QDTool getCurrentSkin] isEqualToString:QDBLACKSKIP])
//    {
        cell.textLabel.textColor=[UIColor whiteColor];
//     cell.imageView.image = [UIImage imageNamed:@"CN"];
//    }
//    else
//    {
//       cell.textLabel.textColor=[UIColor blackColor];
//    }
    

    
        if(self.marketArray.count>indexPath.row)
        {
            
            NSString *strmarket =[self.marketArray objectAtIndex:indexPath.row];
            cell.textLabel.text= [[QDStockSingletonConfigTools sharedManager] getMarketWithNamed:strmarket];
//            NSString *name = [NSString stringWithFormat:@"%@", ]
            flagImg.image = [UIImage imageNamed:strmarket];

        }
    
    
    

    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return 3;
//    if(self.ismultiCcy)
//    return self.ccyArray.count;
//    else
    return self.marketArray.count;
}


#pragma mark - Show and Dismiss

-(void)show {
    
    if (self.parentView != nil) {
        
        if (self.hidden == YES) {
            self.hidden = NO;
        }
        [self resetSkinColor];
        [UIView beginAnimations:@"FlatDatePickerShow" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.4];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationShowDidFinish)];
        
        self.frame = CGRectMake(self.frame.origin.x, self.parentView.frame.size.height - pickerHeight, self.frame.size.width, self.frame.size.height);
        
        [UIView commitAnimations];
    }
    
    
}

- (void)animationShowDidFinish {
    
}

-(void)dismiss {
    
    if (_parentView != nil) {
        
        [UIView beginAnimations:@"FlatDatePickerShow" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.4];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationDismissDidFinish)];
        
        self.frame = CGRectMake(self.frame.origin.x, self.parentView.frame.size.height, self.frame.size.width, self.frame.size.height);
        
        [UIView commitAnimations];
    }
}

- (void)animationDismissDidFinish {
    
}

#pragma mark - 切换颜色风格
-(void)resetSkinColor
{
//    if([[QDTool getCurrentSkin] isEqualToString:QDBLACKSKIP])
//    {
        self.backgroundColor=UIColorFromRGBA(0x222222, 1.0);
        self.tableView.backgroundColor=UIColorFromRGBA(0x222222, 1.0);
        self.titleLabel.textColor=[UIColor whiteColor];
        [self.closeButton setBackgroundImage:[UIImage imageNamed:@"JYB_Competiton_CancelOrder_Picker_Close.png"] forState:UIControlStateNormal];
//
//    }
//    else
//    {
//        self.backgroundColor=[QDTool hexStringToColor:@"#eef2f6"];
//        self.tableView.backgroundColor=[QDTool hexStringToColor:@"#eef2f6"];
//        self.titleLabel.textColor=[QDTool hexStringToColor:@"#1a90f0"];
//        [self.closeButton setBackgroundImage:[UIImage imageNamed:@"t1_JYB_Competiton_CancelOrder_Picker_Close.png"] forState:UIControlStateNormal];
//    }
}

@end
