//
//  QDCompetiton_DianJiBaoJia_PickView.m
//  iQDII_GKS
//
//  Created by hydra on 15-3-15.
//  Copyright (c) 2015年 TSCI. All rights reserved.
//

#import "QDCompetiton_DianJiBaoJia_PickView.h"

static const CGFloat pickerHeight=260.0f;
static const CGFloat buttonWidthAndHeight=44.0f;
static const CGFloat rowHeight=44.0f;
static const CGFloat labelHeight=30.0f;

#pragma mark - tableViewCell


@interface CompetitonDianJiBaoJiaPickerTableViewCell : UITableViewCell

/**
 *  左边标题label
 */
@property (nonatomic,strong)UILabel *leftTitle;

/**
 *  右边标题label
 */
@property (nonatomic,strong)UILabel *rightTitle;

/**
 *  左边Value
 */
@property (nonatomic,strong)UILabel *leftValue;

/**
 *  右边Value
 */
@property (nonatomic,strong)UILabel *rightValue;

/**
 *  左边的button放在label下面以作为点击相应
 */
@property (nonatomic,strong)UIButton *leftButton;

/**
 *  右边的button放在label下面以作为点击相应
 */
@property (nonatomic,strong)UIButton *rightButton;

@property (nonatomic,weak)id<QDDianJiBaoJiaCellDelegate> cellDelegate;

@end

@implementation CompetitonDianJiBaoJiaPickerTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat leftOffset=10.0f;
        CGFloat titleLabelWidth=40.0f;
        CGFloat middleOffset=20.0f;
        CGFloat fontSize=AdjustFontSize(12.0);
        CGFloat oringX=leftOffset;
        CGFloat oringY=(rowHeight-labelHeight)/2;
        CGFloat numberLabelWidth=(self.frame.size.width-2*leftOffset-titleLabelWidth*2-middleOffset)/2;
        
        self.leftTitle=[QDTool createLabelWithFrame:CGRectMake(oringX, oringY, titleLabelWidth, labelHeight) fontColor:[UIColor whiteColor] fontSize:fontSize textAligment:NSTextAlignmentLeft];
        [self addSubview:self.leftTitle];
        
        oringX+=titleLabelWidth;
        self.leftValue=[QDTool createLabelWithFrame:CGRectMake(oringX, oringY, numberLabelWidth, labelHeight) fontColor:[UIColor whiteColor] fontSize:fontSize textAligment:NSTextAlignmentRight];
        [self addSubview:self.leftValue];
        
        oringX+=numberLabelWidth+middleOffset;
        self.rightTitle=[QDTool createLabelWithFrame:CGRectMake(oringX, oringY, titleLabelWidth, labelHeight) fontColor:[UIColor whiteColor] fontSize:fontSize textAligment:NSTextAlignmentLeft];
        [self addSubview:self.rightTitle];
        
        oringX+=titleLabelWidth;
        self.rightValue=[QDTool createLabelWithFrame:CGRectMake(oringX, oringY, numberLabelWidth, labelHeight) fontColor:[UIColor whiteColor] fontSize:fontSize textAligment:NSTextAlignmentRight];
        [self addSubview:self.rightValue];
        
        self.leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
        self.leftButton.frame=CGRectMake(self.leftTitle.frame.origin.x, oringY, self.leftTitle.frame.origin.x+titleLabelWidth+numberLabelWidth, labelHeight);
        self.leftButton.backgroundColor=[UIColor clearColor];
        [self addSubview:self.leftButton];
        
        
        self.rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
        self.rightButton.frame=CGRectMake(self.rightTitle.frame.origin.x, oringY, self.rightTitle.frame.origin.x+titleLabelWidth+numberLabelWidth, labelHeight);
        self.rightButton.backgroundColor=[UIColor clearColor];
        [self addSubview:self.rightButton];
        
        [self.leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

-(void)resetLeftTitle:(NSString*)leftTitle rightTitle:(NSString*)rightTitle
{
    self.leftTitle.text=leftTitle;
    self.rightTitle.text=rightTitle;
}

-(void)resetLeftValue:(NSString*)LeftValue rightValue:(NSString*)rightValue
{
    if(LeftValue.length==0 || LeftValue==nil)
    {
        LeftValue=@"--";
    }
    
    if(rightValue.length==0 || rightValue==nil)
    {
        rightValue=@"--";
    }
    self.leftValue.text=LeftValue;
    self.rightValue.text=rightValue;
}

#pragma mark - cell中点击报价按钮响应事件
-(void)leftButtonClick:(UIButton*)button
{
    if(self.cellDelegate!=nil && [self.cellDelegate respondsToSelector:@selector(clickButtonWithIsLeft:cell:)])
    {
        [self.cellDelegate clickButtonWithIsLeft:YES cell:self];
    }
}

-(void)rightButtonClick:(UIButton*)button
{
    if(self.cellDelegate!=nil && [self.cellDelegate respondsToSelector:@selector(clickButtonWithIsLeft:cell:)])
    {
        [self.cellDelegate clickButtonWithIsLeft:NO cell:self];
    }
}

#pragma mark - 切换颜色风格
-(void)resetSkinColor
{
//    if([[QDTool getCurrentSkin] isEqualToString:QDBLACKSKIP])
//    {
//        self.leftTitle.textColor=[UIColor whiteColor];
//        self.rightTitle.textColor=[UIColor whiteColor];
//        self.leftValue.textColor=[UIColor whiteColor];
//        self.rightValue.textColor=[UIColor whiteColor];
//    }
//    else
//    {
//        self.leftTitle.textColor=[UIColor blackColor];
//        self.rightTitle.textColor=[UIColor blackColor];
//        self.leftValue.textColor=[UIColor blackColor];
//        self.rightValue.textColor=[UIColor blackColor];
//    }
}

@end

@interface QDCompetiton_DianJiBaoJia_PickView()

/**
 *  左上角取消按钮
 */
@property (nonatomic,strong)UIButton *closeButton;

/**
 *  右上角刷新按钮
 */
@property (nonatomic,strong)UIButton *refreshButton;

/**
 *  标题label
 */
@property (nonatomic,strong)UILabel *titleLabel;

/**
 *  数据tableview
 */
@property (nonatomic,strong)UITableView *tableView;

/**
 *  父视图
 */
@property (nonatomic,strong)UIView *parentView;

@end

@implementation QDCompetiton_DianJiBaoJia_PickView

-(id)initWithParentView:(UIView*)parentView{
    
    
    self.parentView=parentView;
    self=[super initWithFrame:CGRectMake(0, self.parentView.frame.size.height, self.parentView.frame.size.width, pickerHeight)];
    if(self){
        self.dianJiBaoJiaArray=[[NSMutableArray alloc] init];
        

//        [self.dianJiBaoJiaArray addObject:[NSArray arrayWithInts:
//                                           DianJiBaoJia_buy1,
//                                           DianJiBaoJia_sell1,
//                                           DianJiBaoJia_buy2,
//                                           DianJiBaoJia_sell2,
//                                           DianJiBaoJia_buy3,
//                                           DianJiBaoJia_sell3,
//                                           DianJiBaoJia_buy4,
//                                           DianJiBaoJia_sell4,
//                                           DianJiBaoJia_buy5,
//                                           DianJiBaoJia_sell5,
////                                           DianJiBaoJia_buy6,
////                                           DianJiBaoJia_sell6,
////                                           DianJiBaoJia_buy7,
////                                           DianJiBaoJia_sell7,
////                                           DianJiBaoJia_buy8,
////                                           DianJiBaoJia_sell8,
////                                           DianJiBaoJia_buy9,
////                                           DianJiBaoJia_sell9,
////                                           DianJiBaoJia_buy10,
////                                           DianJiBaoJia_sell10,
////                                           DianJiBaoJia_high,
////                                           DianJiBaoJia_low,
////                                           DianJiBaoJia_prvClose,
////                                           DianJiBaoJia_open,
////                                           DianJiBaoJia_Nominal,
////                                           DianJiBaoJia_zhangFu,
//                                    NSIntegerMax]];
        
        [self.dianJiBaoJiaArray addObject:[NSArray arrayWithObjects:
                                           [NSNumber numberWithInt:DianJiBaoJia_buy1],
                                           [NSNumber numberWithInt:DianJiBaoJia_sell1],
                                           [NSNumber numberWithInt:DianJiBaoJia_buy2],
                                           [NSNumber numberWithInt:DianJiBaoJia_sell2],
                                           [NSNumber numberWithInt:DianJiBaoJia_buy3],
                                           [NSNumber numberWithInt:DianJiBaoJia_sell3],
                                           [NSNumber numberWithInt:DianJiBaoJia_buy4],
                                           [NSNumber numberWithInt:DianJiBaoJia_sell4],
                                           [NSNumber numberWithInt:DianJiBaoJia_buy5],
                                           [NSNumber numberWithInt:DianJiBaoJia_sell5],
                                           nil]];
                                           //                                           DianJiBaoJia_buy6,
                                           //                                           DianJiBaoJia_sell6,
                                           //                                           DianJiBaoJia_buy7,
                                           //                                           DianJiBaoJia_sell7,
                                           //                                           DianJiBaoJia_buy8,
                                           //                                           DianJiBaoJia_sell8,
                                           //                                           DianJiBaoJia_buy9,
                                           //                                           DianJiBaoJia_sell9,
                                           //                                           DianJiBaoJia_buy10,
                                           //                                           DianJiBaoJia_sell10,
                                           //                                           DianJiBaoJia_high,
                                           //                                           DianJiBaoJia_low,
                                           //                                           DianJiBaoJia_prvClose,
                                           //                                           DianJiBaoJia_open,
                                           //                                           DianJiBaoJia_Nominal,
                                           //                                           DianJiBaoJia_zhangFu,
//                                           NSIntegerMax]];

        
        self.parentView = parentView;
        [self.parentView addSubview:self];
        [self createUI];
    }
    return self;
}

+(NSString*)getNameOfType:(emDianJiBaoJiaType)type
{
    
    NSString *result=@"";
    switch (type) {
        case DianJiBaoJia_buy1:
            return NSLocalizedString(@"买①", @"");
            break;
        case DianJiBaoJia_buy2:
            return NSLocalizedString(@"买②", @"");
            break;
        case DianJiBaoJia_buy3:
            return NSLocalizedString(@"买③", @"");
            break;
        case DianJiBaoJia_buy4:
            return NSLocalizedString(@"买④", @"");
            break;
        case DianJiBaoJia_buy5:
            return NSLocalizedString(@"买⑤", @"");
            break;
        case DianJiBaoJia_buy6:
            return NSLocalizedString(@"买⑥", @"");
            break;
        case DianJiBaoJia_buy7:
            return NSLocalizedString(@"买⑦", @"");
            break;
        case DianJiBaoJia_buy8:
            return NSLocalizedString(@"买⑧", @"");
            break;
        case DianJiBaoJia_buy9:
            return NSLocalizedString(@"买⑨", @"");
            break;
        case DianJiBaoJia_buy10:
            return NSLocalizedString(@"买⑩", @"");
            break;
        case DianJiBaoJia_sell1:
            return NSLocalizedString(@"卖①", @"");
            break;
        case DianJiBaoJia_sell2:
            return NSLocalizedString(@"卖②", @"");
            break;
        case DianJiBaoJia_sell3:
            return NSLocalizedString(@"卖③", @"");
            break;
        case DianJiBaoJia_sell4:
            return NSLocalizedString(@"卖④", @"");
            break;
        case DianJiBaoJia_sell5:
            return NSLocalizedString(@"卖⑤", @"");
            break;
        case DianJiBaoJia_sell6:
            return NSLocalizedString(@"卖⑥", @"");
            break;
        case DianJiBaoJia_sell7:
            return NSLocalizedString(@"卖⑦", @"");
            break;
        case DianJiBaoJia_sell8:
            return NSLocalizedString(@"卖⑧", @"");
            break;
        case DianJiBaoJia_sell9:
            return NSLocalizedString(@"卖⑨", @"");
            break;
        case DianJiBaoJia_sell10:
            return NSLocalizedString(@"卖⑩", @"");
            break;
        case DianJiBaoJia_high:
            return NSLocalizedString(@"最高", @"");
            break;
        case DianJiBaoJia_low:
            return NSLocalizedString(@"最低", @"");
            break;
        case DianJiBaoJia_prvClose:
            return NSLocalizedString(@"昨收", @"");
            break;
        case DianJiBaoJia_open:
            return NSLocalizedString(@"今开", @"");
            break;
        case DianJiBaoJia_Nominal:
            return NSLocalizedString(@"现价", @"");
            break;
        case DianJiBaoJia_zhangFu:
            return NSLocalizedString(@"涨幅", @"");
            break;
        default:
            return result;
            break;
    }
    return result;
}




+(NSString*)getValOfType:(emDianJiBaoJiaType)type dic:(NSMutableDictionary*)dic
{
    NSString *result=@"";
    
    switch (type) {
        case DianJiBaoJia_buy1:
            return [dic objectForKey:@"BP0"];
            break;
        case DianJiBaoJia_buy2:
            return [dic objectForKey:@"BP1"];
            break;
        case DianJiBaoJia_buy3:
            return [dic objectForKey:@"BP2"];
            break;
        case DianJiBaoJia_buy4:
            return [dic objectForKey:@"BP3"];
            break;
        case DianJiBaoJia_buy5:
            return [dic objectForKey:@"BP4"];
            break;
        case DianJiBaoJia_buy6:
            return [dic objectForKey:@"BP5"];
            break;
        case DianJiBaoJia_buy7:
            return [dic objectForKey:@"BP6"];
            break;
        case DianJiBaoJia_buy8:
            return [dic objectForKey:@"BP7"];
            break;
        case DianJiBaoJia_buy9:
            return [dic objectForKey:@"BP8"] ;
            break;
        case DianJiBaoJia_buy10:
            return [dic objectForKey:@"BP9"];
            break;
        case DianJiBaoJia_sell1:
            return [dic objectForKey:@"SP0"];
            break;
        case DianJiBaoJia_sell2:
            return [dic objectForKey:@"SP1"];
            break;
        case DianJiBaoJia_sell3:
            return [dic objectForKey:@"SP2"] ;
            break;
        case DianJiBaoJia_sell4:
            return [dic objectForKey:@"SP3"];
            break;
        case DianJiBaoJia_sell5:
            return [dic objectForKey:@"SP4"];
            break;
        case DianJiBaoJia_sell6:
            return [dic objectForKey:@"SP5"];
            break;
        case DianJiBaoJia_sell7:
            return [dic objectForKey:@"SP6"];
            break;
        case DianJiBaoJia_sell8:
            return [dic objectForKey:@"SP7"];
            break;
        case DianJiBaoJia_sell9:
            return [dic objectForKey:@"SP8"];
            break;
        case DianJiBaoJia_sell10:
            return [dic objectForKey:@"SP9"];
            break;
        case DianJiBaoJia_high:
            return [dic objectForKey:@"High"];
            break;
        case DianJiBaoJia_low:
            return [dic objectForKey:@"Low"];
            break;
        case DianJiBaoJia_prvClose:
            return [dic objectForKey:@"PrvClose"];
            break;
        case DianJiBaoJia_open:
            return [dic objectForKey:@"Open"];
            break;
        case DianJiBaoJia_Nominal:
            return [dic objectForKey:@"Nominal"];
            break;
        case DianJiBaoJia_zhangFu:
            return [dic objectForKey:@"zhangfu"];
            break;
            
        default:
            return result;
            break;
    }
    return result;
}

+(NSString*)getValAndVolOfType:(emDianJiBaoJiaType)type dic:(NSMutableDictionary*)dic
{
    NSString *result=@"";
    
    switch (type) {
        case DianJiBaoJia_buy1:
        {
            NSString *temp=[dic objectForKey:@"BV0"];
            if(temp.length==0)
            {
                temp=@"--";
            }
            return [NSString stringWithFormat:@"%@/%@",[dic objectForKey:@"BP0"],temp] ;
        }
            break;
        case DianJiBaoJia_buy2:
        {
            NSString *temp=[dic objectForKey:@"BV1"];
            if(temp.length==0)
            {
                temp=@"--";
            }
            return [NSString stringWithFormat:@"%@/%@",[dic objectForKey:@"BP1"],temp] ;
        }
            break;
        case DianJiBaoJia_buy3:
        {
            NSString *temp=[dic objectForKey:@"BV2"];
            if(temp.length==0)
            {
                temp=@"--";
            }
            return [NSString stringWithFormat:@"%@/%@",[dic objectForKey:@"BP2"],temp] ;
        }
            break;
        case DianJiBaoJia_buy4:
        {
            NSString *temp=[dic objectForKey:@"BV3"];
            if(temp.length==0)
            {
                temp=@"--";
            }
            return [NSString stringWithFormat:@"%@/%@",[dic objectForKey:@"BP3"],temp] ;
        }
            break;
        case DianJiBaoJia_buy5:
        {
            NSString *temp=[dic objectForKey:@"BV4"];
            if(temp.length==0)
            {
                temp=@"--";
            }
            return [NSString stringWithFormat:@"%@/%@",[dic objectForKey:@"BP4"],temp] ;
        }
            break;
        case DianJiBaoJia_buy6:
        {
            NSString *temp=[dic objectForKey:@"BV5"];
            if(temp.length==0)
            {
                temp=@"--";
            }
            return [NSString stringWithFormat:@"%@/%@",[dic objectForKey:@"BP5"],temp] ;
        }
            break;
        case DianJiBaoJia_buy7:
        {
            NSString *temp=[dic objectForKey:@"BV6"];
            if(temp.length==0)
            {
                temp=@"--";
            }
            return [NSString stringWithFormat:@"%@/%@",[dic objectForKey:@"BP6"],temp] ;
        }
            break;
        case DianJiBaoJia_buy8:
        {
            NSString *temp=[dic objectForKey:@"BV7"];
            if(temp.length==0)
            {
                temp=@"--";
            }
            return [NSString stringWithFormat:@"%@/%@",[dic objectForKey:@"BP7"],temp] ;
        }
            break;
        case DianJiBaoJia_buy9:
        {
            NSString *temp=[dic objectForKey:@"BV8"];
            if(temp.length==0)
            {
                temp=@"--";
            }
            return [NSString stringWithFormat:@"%@/%@",[dic objectForKey:@"BP8"],temp] ;
        }
            break;
        case DianJiBaoJia_buy10:
        {
            NSString *temp=[dic objectForKey:@"BV9"];
            if(temp.length==0)
            {
                temp=@"--";
            }
            return [NSString stringWithFormat:@"%@/%@",[dic objectForKey:@"BP9"],temp] ;
        }
            break;
        case DianJiBaoJia_sell1:
        {
            NSString *temp=[dic objectForKey:@"SV0"];
            if(temp.length==0)
            {
                temp=@"--";
            }
            return [NSString stringWithFormat:@"%@/%@",[dic objectForKey:@"SP0"],temp] ;
        }
            break;
        case DianJiBaoJia_sell2:
        {
            NSString *temp=[dic objectForKey:@"SV1"];
            if(temp.length==0)
            {
                temp=@"--";
            }
            return [NSString stringWithFormat:@"%@/%@",[dic objectForKey:@"SP1"],temp] ;
        }
            break;
        case DianJiBaoJia_sell3:
        {
            NSString *temp=[dic objectForKey:@"SV2"];
            if(temp.length==0)
            {
                temp=@"--";
            }
            return [NSString stringWithFormat:@"%@/%@",[dic objectForKey:@"SP2"],temp] ;
        }
            break;
        case DianJiBaoJia_sell4:
        {
            NSString *temp=[dic objectForKey:@"SV3"];
            if(temp.length==0)
            {
                temp=@"--";
            }
            return [NSString stringWithFormat:@"%@/%@",[dic objectForKey:@"SP3"],temp] ;
        }
            break;
        case DianJiBaoJia_sell5:
        {
            NSString *temp=[dic objectForKey:@"SV4"];
            if(temp.length==0)
            {
                temp=@"--";
            }
            return [NSString stringWithFormat:@"%@/%@",[dic objectForKey:@"SP4"],temp] ;
        }
            break;
        case DianJiBaoJia_sell6:
        {
            NSString *temp=[dic objectForKey:@"SV5"];
            if(temp.length==0)
            {
                temp=@"--";
            }
            return [NSString stringWithFormat:@"%@/%@",[dic objectForKey:@"SP5"],temp] ;
        }
            break;
        case DianJiBaoJia_sell7:
        {
            NSString *temp=[dic objectForKey:@"SV6"];
            if(temp.length==0)
            {
                temp=@"--";
            }
            return [NSString stringWithFormat:@"%@/%@",[dic objectForKey:@"SP6"],temp] ;
        }
            break;
        case DianJiBaoJia_sell8:
        {
            NSString *temp=[dic objectForKey:@"SV7"];
            if(temp.length==0)
            {
                temp=@"--";
            }
            return [NSString stringWithFormat:@"%@/%@",[dic objectForKey:@"SP7"],temp] ;
        }
            break;
        case DianJiBaoJia_sell9:
        {
            NSString *temp=[dic objectForKey:@"SV8"];
            if(temp.length==0)
            {
                temp=@"--";
            }
            return [NSString stringWithFormat:@"%@/%@",[dic objectForKey:@"SP8"],temp] ;
        }
            break;
        case DianJiBaoJia_sell10:
        {
            NSString *temp=[dic objectForKey:@"SV9"];
            if(temp.length==0)
            {
                temp=@"--";
            }
            return [NSString stringWithFormat:@"%@/%@",[dic objectForKey:@"SP9"],temp] ;
        }
            break;
        case DianJiBaoJia_high:
            return [dic objectForKey:@"High"];
            break;
        case DianJiBaoJia_low:
            return [dic objectForKey:@"Low"];
            break;
        case DianJiBaoJia_prvClose:
            return [dic objectForKey:@"PrvClose"];
            break;
        case DianJiBaoJia_open:
            return [dic objectForKey:@"Open"];
            break;
        case DianJiBaoJia_Nominal:
            return [dic objectForKey:@"Nominal"];
            break;
        case DianJiBaoJia_zhangFu:
            return [dic objectForKey:@"zhangfu"];
            break;
            
        default:
            return result;
            break;
    }
    return result;
}

#pragma mark - 万银点击报价显示
+(NSString*)getValOfTypeUseforMRS:(emDianJiBaoJiaType)type dic:(NSMutableDictionary*)dic
{
    NSString *result=@"";
    
    switch (type) {
        case DianJiBaoJia_buy1:
        {
            return [NSString stringWithFormat:@"%@",[dic objectForKey:@"BP0"]] ;
        }
            break;
        case DianJiBaoJia_buy2:
        {
            return [NSString stringWithFormat:@"%@",[dic objectForKey:@"BP1"]] ;
        }
            break;
        case DianJiBaoJia_buy3:
        {
            return [NSString stringWithFormat:@"%@",[dic objectForKey:@"BP2"]] ;
        }
            break;
        case DianJiBaoJia_buy4:
        {
           
            return [NSString stringWithFormat:@"%@",[dic objectForKey:@"BP3"]] ;
        }
            break;
        case DianJiBaoJia_buy5:
        {
           
            return [NSString stringWithFormat:@"%@",[dic objectForKey:@"BP4"]] ;
        }
            break;
        case DianJiBaoJia_buy6:
        {
      
            return [NSString stringWithFormat:@"%@",[dic objectForKey:@"BP5"]] ;
        }
            break;
        case DianJiBaoJia_buy7:
        {
  
            return [NSString stringWithFormat:@"%@",[dic objectForKey:@"BP6"]] ;
        }
            break;
        case DianJiBaoJia_buy8:
        {
 
            return [NSString stringWithFormat:@"%@",[dic objectForKey:@"BP7"]] ;
        }
            break;
        case DianJiBaoJia_buy9:
        {

            return [NSString stringWithFormat:@"%@",[dic objectForKey:@"BP8"]] ;
        }
            break;
        case DianJiBaoJia_buy10:
        {
    
            return [NSString stringWithFormat:@"%@",[dic objectForKey:@"BP9"]] ;
        }
            break;
        case DianJiBaoJia_sell1:
        {

            return [NSString stringWithFormat:@"%@",[dic objectForKey:@"SP0"]] ;
        }
            break;
        case DianJiBaoJia_sell2:
        {

            return [NSString stringWithFormat:@"%@",[dic objectForKey:@"SP1"]] ;
        }
            break;
        case DianJiBaoJia_sell3:
        {

            return [NSString stringWithFormat:@"%@",[dic objectForKey:@"SP2"]] ;
        }
            break;
        case DianJiBaoJia_sell4:
        {

            return [NSString stringWithFormat:@"%@",[dic objectForKey:@"SP3"]] ;
        }
            break;
        case DianJiBaoJia_sell5:
        {
   
            return [NSString stringWithFormat:@"%@",[dic objectForKey:@"SP4"]] ;
        }
            break;
        case DianJiBaoJia_sell6:
        {

            return [NSString stringWithFormat:@"%@",[dic objectForKey:@"SP5"]] ;
        }
            break;
        case DianJiBaoJia_sell7:
        {

            return [NSString stringWithFormat:@"%@",[dic objectForKey:@"SP6"]] ;
        }
            break;
        case DianJiBaoJia_sell8:
        {

            return [NSString stringWithFormat:@"%@",[dic objectForKey:@"SP7"]] ;
        }
            break;
        case DianJiBaoJia_sell9:
        {
  
            return [NSString stringWithFormat:@"%@",[dic objectForKey:@"SP8"]] ;
        }
            break;
        case DianJiBaoJia_sell10:
        {
  
            return [NSString stringWithFormat:@"%@",[dic objectForKey:@"SP9"]] ;
        }
            break;
        case DianJiBaoJia_high:
            return [dic objectForKey:@"High"];
            break;
        case DianJiBaoJia_low:
            return [dic objectForKey:@"Low"];
            break;
        case DianJiBaoJia_prvClose:
            return [dic objectForKey:@"PrvClose"];
            break;
        case DianJiBaoJia_open:
            return [dic objectForKey:@"Open"];
            break;
        case DianJiBaoJia_Nominal:
            return [dic objectForKey:@"Nominal"];
            break;
        case DianJiBaoJia_zhangFu:
            return [dic objectForKey:@"zhangfu"];
            break;
            
        default:
            return result;
            break;
    }
    return result;
}


#pragma mark - UI
-(void)createUI
{
    self.backgroundColor=[QDTool hexStringToColor:@"#222222"];
    [self createHeader];
}

-(void)createHeader
{
    self.closeButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.closeButton.frame=CGRectMake(0, 0, buttonWidthAndHeight, buttonWidthAndHeight);
    [self.closeButton setBackgroundImage:[UIImage imageNamed:@"JYB_Competiton_CancelOrder_Picker_Close.png"] forState:UIControlStateNormal];
    [self.closeButton addTarget:self action:@selector(closeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.closeButton];
    
    self.refreshButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.refreshButton.frame=CGRectMake(self.frame.size.width-buttonWidthAndHeight, 0, buttonWidthAndHeight, buttonWidthAndHeight);
    [self.refreshButton setBackgroundImage:[UIImage imageNamed:@"JYB_Competiton_CancelOrder_Picker_Refresh_Grow.png"] forState:UIControlStateNormal];
//    [self.refreshButton setBackgroundImage:[UIImage imageNamed:@"JYB_Competiton_CancelOrder_Picker_Refresh.png"] forState:UIControlStateHighlighted];
    [self.refreshButton addTarget:self action:@selector(refreshButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.refreshButton];
    
    
    self.titleLabel=[QDTool createLabelWithFrame:CGRectMake(buttonWidthAndHeight, 0.0, self.frame.size.width - (buttonWidthAndHeight * 2), buttonWidthAndHeight) fontColor:UIColorFromRGBA(0x1a90f0, 1.0) fontSize:AdjustFontSize(18) textAligment:NSTextAlignmentCenter];
    self.titleLabel.text=self.title;
    self.titleLabel.text=NSLocalizedString(@"报价", @"");
    [self addSubview:self.titleLabel];
    
    QDCompetitionHorizontallyLine *line=[[QDCompetitionHorizontallyLine alloc] initWithFrame:CGRectMake(buttonWidthAndHeight, buttonWidthAndHeight-0.5, self.frame.size.width-2*buttonWidthAndHeight, 0.5) lineColor:[QDTool hexStringToColor:@"#cdcdcd"]];
    self.horLine=line;
    [self addSubview:line];
    
    self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, buttonWidthAndHeight, self.frame.size.width, pickerHeight-buttonWidthAndHeight) style:UITableViewStylePlain];
    self.tableView.backgroundColor=UIColorFromRGBA(0x222222,1.0);
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tableView];
}

-(void)setDianJiBaoJiaDictionary:(NSMutableDictionary *)dianJiBaoJiaDictionary
{
    _dianJiBaoJiaDictionary=dianJiBaoJiaDictionary;
    [self.tableView reloadData];
}

#pragma mark - 根据用户属性决定是否展示刷新键，实时用户不展示，后台默认刷新；点击报价用户，显示刷新按钮，让其点击刷新 要多天才才能想出这么一个主意，手动挡变成自动挡了！

-(void)resetRefreshButtonStatus
{
    
//#ifndef _iQDII_
//    emGKSUserProperty property=[iQDIIGKSAction shareGKSAction].GKSUserProperty;
//    //点击报价用户
//    if (property==GKSUser_dianJiBaoJia || property==GKSUser_delay)
//    {
        self.refreshButton.hidden=NO;
        self.horLine.frame=CGRectMake(buttonWidthAndHeight, buttonWidthAndHeight-0.5, self.frame.size.width-2*buttonWidthAndHeight, 0.5);
//    }
//    //实时用户
//    else if (property==GKSUser_realTime)
//    {
//        self.refreshButton.hidden=YES;
//        self.horLine.frame=CGRectMake(buttonWidthAndHeight, buttonWidthAndHeight-0.5, self.frame.size.width-buttonWidthAndHeight, 0.5);
//    }
//#endif
}

#pragma mark - 按钮点击事件
-(void)closeButtonClick
{
    if(self.pickerViewDelegate!=nil && [self.pickerViewDelegate respondsToSelector:@selector(closeWithPicker:)])
    {
        [self.pickerViewDelegate closeWithPicker:self];
    }
}

-(void)refreshButtonClick
{
    if(self.pickerViewDelegate!=nil && [self.pickerViewDelegate respondsToSelector:@selector(refreshWithPicker:)])
    {
        [self.pickerViewDelegate refreshWithPicker:self];
    }
}

#pragma mark - UITableViewDelegate


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

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
    CompetitonDianJiBaoJiaPickerTableViewCell *cell=(CompetitonDianJiBaoJiaPickerTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil)
    {
        cell=[[CompetitonDianJiBaoJiaPickerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.cellDelegate=self;
        cell.backgroundColor=[UIColor clearColor];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    [cell resetSkinColor];
    [self resetTitleNameWithIndexPath:indexPath cell:cell];
    [self resetValueWithIndexPath:indexPath cell:cell];
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sectonArr=[self.dianJiBaoJiaArray objectAtIndex:section];
    NSInteger row=0;
    row=ceil(1/2);
    if(sectonArr.count%2==0)
    {
        row=ceil((sectonArr.count/2));
    }
    else
    {
        row=floor((sectonArr.count/2))+1;
    }
    
    return row;
}

#pragma mark - cell设值
-(void)resetTitleNameWithIndexPath:(NSIndexPath*)indexPath cell:(CompetitonDianJiBaoJiaPickerTableViewCell*)cell
{
    NSInteger row=indexPath.row;
    if(self.dianJiBaoJiaArray.count>indexPath.section)
    {
        NSArray *sectionArr=[self.dianJiBaoJiaArray objectAtIndex:indexPath.section];
        if(sectionArr.count>(row*2+1))
        {
            emDianJiBaoJiaType type0=(emDianJiBaoJiaType)[[sectionArr objectAtIndex:row*2] integerValue];
            emDianJiBaoJiaType type1=(emDianJiBaoJiaType)[[sectionArr objectAtIndex:row*2+1] integerValue];
            [cell resetLeftTitle:[QDCompetiton_DianJiBaoJia_PickView getNameOfType:type0] rightTitle:[QDCompetiton_DianJiBaoJia_PickView getNameOfType:type1]];
        }
    }
    
    
    
}

-(void)resetValueWithIndexPath:(NSIndexPath*)indexPath cell:(CompetitonDianJiBaoJiaPickerTableViewCell*)cell
{
    
    NSInteger row=indexPath.row;
    if(self.dianJiBaoJiaArray.count>indexPath.section)
    {
        NSArray *sectionArr=[self.dianJiBaoJiaArray objectAtIndex:indexPath.section];
        if(sectionArr.count>(row*2+1))
        {
            emDianJiBaoJiaType type0=(emDianJiBaoJiaType)[[sectionArr objectAtIndex:row*2] integerValue];
            emDianJiBaoJiaType type1=(emDianJiBaoJiaType)[[sectionArr objectAtIndex:row*2+1] integerValue];
            
#ifdef _SMX_FOR_MRS
            [cell resetLeftValue:[QDCompetiton_DianJiBaoJia_PickView getValOfTypeUseforMRS:type0 dic:self.dianJiBaoJiaDictionary] rightValue:[QDCompetiton_DianJiBaoJia_PickView getValOfTypeUseforMRS:type1 dic:self.dianJiBaoJiaDictionary]];
#else
            [cell resetLeftValue:[QDCompetiton_DianJiBaoJia_PickView getValAndVolOfType:type0 dic:self.dianJiBaoJiaDictionary] rightValue:[QDCompetiton_DianJiBaoJia_PickView getValAndVolOfType:type1 dic:self.dianJiBaoJiaDictionary]];
#endif
            
            
            //昨收
            NSString *preClose=[self.dianJiBaoJiaDictionary objectForKey:@"PrvClose"];
//            UIColor *leftFontColor=[QDTool decideFiveRangePriceLabelColorWithZuoShou:preClose currentPrice:[QDCompetiton_DianJiBaoJia_PickView getValOfType:type0 dic:self.dianJiBaoJiaDictionary]];
//            UIColor *rightFontColor=[QDTool decideFiveRangePriceLabelColorWithZuoShou:preClose currentPrice:[QDCompetiton_DianJiBaoJia_PickView getValOfType:type1 dic:self.dianJiBaoJiaDictionary]];
            cell.leftValue.textColor=  [UIColor redColor];//leftFontColor;
            cell.rightValue.textColor= [UIColor cyanColor];///rightFontColor;
        }
    }
}

#pragma mark - Show and Dismiss

-(void)show {
    
    if (self.parentView != nil) {
        
        if (self.hidden == YES) {
            self.hidden = NO;
        }
        [self resetSkinColor];
        [self resetRefreshButtonStatus];
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

#pragma mark - QDDianJiBaoJiaCellDelegate
- (void)clickButtonWithIsLeft:(BOOL)isLeft cell:(CompetitonDianJiBaoJiaPickerTableViewCell*)cell
{
    NSIndexPath *indexPath=[self.tableView indexPathForCell:cell];
    NSInteger row=indexPath.row;
    if(self.dianJiBaoJiaArray.count>indexPath.section)
    {
        NSArray *sectionArr=[self.dianJiBaoJiaArray objectAtIndex:indexPath.section];
        if(sectionArr.count>(row*2+1))
        {
            emDianJiBaoJiaType type0=(emDianJiBaoJiaType)[[sectionArr objectAtIndex:row*2] integerValue];
            emDianJiBaoJiaType type1=(emDianJiBaoJiaType)[[sectionArr objectAtIndex:row*2+1] integerValue];
            if(self.pickerViewDelegate!=nil && [self.pickerViewDelegate respondsToSelector:@selector(clickButtonWithPicker:price:type:)])
            {
                if(isLeft)
                {  
                    [self.pickerViewDelegate clickButtonWithPicker:self price:[QDCompetiton_DianJiBaoJia_PickView getValOfType:type0 dic:self.dianJiBaoJiaDictionary] type:type0];
                }
                else
                {
                    [self.pickerViewDelegate clickButtonWithPicker:self price:[QDCompetiton_DianJiBaoJia_PickView getValOfType:type1 dic:self.dianJiBaoJiaDictionary] type:type1];
                }
            }
            
        }
    }
}

#pragma mark - 切换颜色风格
-(void)resetSkinColor
{
//    if([[QDTool getCurrentSkin] isEqualToString:QDBLACKSKIP])
//    {
//        self.backgroundColor=[QDTool hexStringToColor:@"#222222"];
//        self.tableView.backgroundColor=[QDTool hexStringToColor:@"#222222"];
//        self.titleLabel.textColor=[UIColor whiteColor];
//        [self.closeButton setBackgroundImage:[UIImage imageNamed:@"JYB_Competiton_CancelOrder_Picker_Close.png"] forState:UIControlStateNormal];
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
