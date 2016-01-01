//
//  QDCapitalDistibuteDiagramView.m
//  QDBMPloginViewControllerDemo
//
//  Created by Weber on 15/7/3.
//  Copyright (c) 2015年 tsci. All rights reserved.
//

#import "QDCapitalDistibuteDiagramView.h"
#import "QDCapitalDistributeDiagramLayer.h"
#import "QDTool.h"
#define RGB(r,g,b)     [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

static const NSInteger offsetDistance = 8; //百分号标题的偏移位置
static const NSInteger offsetPosition = 7.5;//偏移位置

@interface QDCapitalDistibuteDiagramView()

@end


@implementation QDCapitalDistibuteDiagramView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)init{
    self.radius = 0;
    self.fontSize = 10.0;
    return [self initWithLeftTotal:0.0 freezeCapital:0.0 totalMarketValue:0.0];
}

- (id)initWithLeftTotal:(CGFloat)lt freezeCapital:(CGFloat)fc totalMarketValue:(CGFloat)tm{
    if(self = [super init]){
        _leftTotal = lt;
        _freezeCapital = fc;
        _totalMarketValue = tm;
    }
    return self;
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    [super drawLayer:layer inContext:ctx];
}

- (void)drawRect:(CGRect)rect{
    
}

- (void)setText{
    if(self.textArr.count!=0)
       [self.textArr removeAllObjects];
    CGPoint center = CGPointMake(self.radius, self.radius);
    _textArr = [[NSMutableArray alloc] init];
    for(int i =0; i<3; i++){
        UILabel *textLayer = [[UILabel alloc] init];
        NSString *str;
        CGFloat titleWidth = 0.0;
        CGFloat titleHeight = 0.0;
        
        if(i==0){
            CGFloat x = self.radius/2*cosf(_freezeCapital/100.0*M_PI);        //30*M_PI/180);
            CGFloat y = self.radius/2*sinf(_freezeCapital/100.0*M_PI);    //30*M_PI/180);
            str = [NSString stringWithFormat:@"%.2f%%", _freezeCapital];
            CGSize size = [QDTool getStringSizeWithString:str font:[UIFont systemFontOfSize:self.fontSize] lableHeight:1000 width:1000];
            titleWidth = size.width;
            titleHeight = size.height;
            if(x>0){
                if(y>0)//1象限
                    textLayer.frame = CGRectMake(center.x+fabs(x)-titleWidth/2.0+offsetDistance, center.y-fabs(y)-titleHeight/2, titleWidth, titleHeight);
                else//4象限
                    textLayer.frame = CGRectMake(center.x+fabs(x)-titleWidth/2.0+offsetDistance, center.y+fabs(y)-titleHeight/2, titleWidth, titleHeight);
            }else{
                if(y>0)//是2象限
                    textLayer.frame = CGRectMake(center.x-fabs(x)-titleWidth/2.0, center.y-fabs(y)-titleHeight/2, titleWidth, titleHeight);
                else//3象限
                    textLayer.frame = CGRectMake(center.x-fabs(x)-titleWidth/2.0, center.y+fabs(y)-titleHeight/2, titleWidth, titleHeight);
            }

        }else if(i == 1){
            str = [NSString stringWithFormat:@"%.2f%%", _leftTotal];
            CGSize size = [QDTool getStringSizeWithString:str font:[UIFont systemFontOfSize:self.fontSize] lableHeight:1000 width:1000];
            titleWidth = size.width;
            titleHeight = size.height;
            CGFloat x = self.radius/2*cosf(_freezeCapital/100.0*2.0*M_PI+_leftTotal/100.0*M_PI);        //30*M_PI/180);
            CGFloat y = self.radius/2*sinf(_freezeCapital/100.0*2.0*M_PI+_leftTotal/100.0*M_PI);    //30*M_PI/180);
            
            if(x>0){
                if(y>0)//1象限
                    textLayer.frame = CGRectMake(center.x+fabs(x)-titleWidth/2.0+offsetDistance, center.y-fabs(y)-titleHeight/2, titleWidth, titleHeight);
                else//4象限
                    textLayer.frame = CGRectMake(center.x+fabs(x)-titleWidth/2.0+offsetDistance, center.y+fabs(y)-titleHeight/2, titleWidth, titleHeight);
            }else{
                if(y>0)//是2象限
                    textLayer.frame = CGRectMake(center.x-fabs(x)-titleWidth/2.0, center.y-fabs(y)-titleHeight/2, titleWidth, titleHeight);
                else//3象限
                    textLayer.frame = CGRectMake(center.x-fabs(x)-titleWidth/2.0, center.y+fabs(y)-titleHeight/2, titleWidth, titleHeight);
            }

        }else if(i==2){
            CGFloat x = self.radius/2*cosf((_leftTotal+_freezeCapital)/100.0*2.0*M_PI+_totalMarketValue/100.0*M_PI);        //30*M_PI/180);
            CGFloat y = self.radius/2*sinf((_leftTotal+_freezeCapital)/100.0*2.0*M_PI+_totalMarketValue/100.0*M_PI);    //30*M_PI/180);
            str = [NSString stringWithFormat:@"%.2f%%", _totalMarketValue];
            CGSize size = [QDTool getStringSizeWithString:str font:[UIFont systemFontOfSize:self.fontSize] lableHeight:1000 width:1000];
            titleWidth = size.width;
            titleHeight = size.height;
            if(x>0){
                if(y>0)//1象限
                    textLayer.frame = CGRectMake(center.x+fabs(x)-titleWidth/2.0+offsetDistance, center.y-fabs(y)-titleHeight/2, titleWidth, titleHeight);
                else//4象限
                    textLayer.frame = CGRectMake(center.x+fabs(x)-titleWidth/2.0+offsetDistance, center.y+fabs(y)-titleHeight/2, titleWidth, titleHeight);
            }else{
                if(y>0)//是2象限
                    textLayer.frame = CGRectMake(center.x-fabs(x)-titleWidth/2.0, center.y-fabs(y)-titleHeight/2, titleWidth, titleHeight);
                else//3象限
                    textLayer.frame = CGRectMake(center.x-fabs(x)-titleWidth/2.0, center.y+fabs(y)-titleHeight/2, titleWidth, titleHeight);
            }


        }
        textLayer.adjustsFontSizeToFitWidth = YES;
        textLayer.font =  [UIFont systemFontOfSize:self.fontSize];
        textLayer.textColor = [UIColor whiteColor];
        textLayer.text = str;
        [self.textArr addObject:textLayer];
    }
}

- (void)setSepLine{
    if(self.sepLineArr.count!=0)
        [self.sepLineArr removeAllObjects];
    CGPoint center = CGPointMake(self.radius, self.radius);
    _sepLineArr=[[NSMutableArray alloc] init];
    for(int i=0;i<3;i++)
    {

        UILabel *tempLine = [[UILabel alloc] initWithFrame:CGRectMake(center.x-self.radius/2, center.y-1, self.radius, 2)];
        tempLine.layer.backgroundColor = [UIColor whiteColor].CGColor;
        tempLine.layer.anchorPoint=CGPointMake(0, 0.5);
        if(i==0)
        {
           
            tempLine.layer.transform= CATransform3DMakeRotation(_totalMarketValue/100* 2.0 * M_PI, 0, 0, 1);
        }
        else if(i==1)
        {
            
            tempLine.layer.transform= CATransform3DMakeRotation((_totalMarketValue+_leftTotal)/100* 2.0 * M_PI, 0, 0, 1);
        }
        else if(i==2)
        {
            
            tempLine.layer.transform= CATransform3DMakeRotation((_totalMarketValue+_leftTotal+_freezeCapital)/100* 2.0 * M_PI, 0, 0, 1);
        }
        
        [self.sepLineArr addObject:tempLine.layer];
    }
    
  

}


//加上标题
-(void)addTextLayer:(int)index
{
    if(self.textArr.count>index)
    {
        CALayer *lay=((UILabel*)[self.textArr objectAtIndex:index]).layer;
        
        
        CABasicAnimation *textLayer = [CABasicAnimation animationWithKeyPath:@"opacity"];
        textLayer.duration = 1.5;
        textLayer.fromValue = [NSNumber numberWithFloat:0];
        textLayer.toValue = [NSNumber numberWithFloat:1.0];
        [lay addAnimation:textLayer forKey:nil];
        
        [self.layer insertSublayer:lay atIndex:1];
    }
}


//清除标题
-(void)removeAllTextLayer
{
    for (int i=0; i<self.textArr.count; i++) {
        CALayer *lay=((UILabel*)[self.textArr objectAtIndex:i]).layer;
        if(lay.superlayer)
        {
            [lay removeFromSuperlayer];
        }
    }
}


//加上分割线
-(void)addSepLayer:(int)index
{
    if(self.sepLineArr.count>index)
    {
        CALayer *lay=[self.sepLineArr objectAtIndex:index];
        [self.layer insertSublayer:lay atIndex:1];
    }
}


//清除所有分割线
-(void)removeAllSepLayer
{
    for (int i=0; i<self.sepLineArr.count; i++) {
        CALayer *lay=[self.sepLineArr objectAtIndex:i];
        if(lay.superlayer)
        {
            [lay removeFromSuperlayer];
        }
    }
}

- (void)resetLeftTotal:(CGFloat)lt freezeCapital:(CGFloat)fc totalMarketValue:(CGFloat)tm{
    _leftTotal = lt;
    _freezeCapital = fc;
    _totalMarketValue = tm;
    [self setSepLine];
    [self setText];
}



+ (Class)layerClass{
    return [QDCapitalDistributeDiagramLayer class];
}

- (void)begainAnimations{
    QDCapitalDistributeDiagramLayer *layer = (QDCapitalDistributeDiagramLayer*)self.layer;
    
    [self removeAllSepLayer];
    [self removeAllTextLayer];
    [layer setNeedsDisplay];
    
    
    if(_totalMarketValue != 0){
        self.totalMarketValue = _totalMarketValue;
    }else{
        if(_leftTotal!= 0){
            self.leftTotal = _leftTotal;
        }else{
            if(_freezeCapital != 0){
                self.freezeCapital = _freezeCapital;
            }
        }
    }
    [self addTextLayer:2];

}

- (void)setTotalMarketValue:(CGFloat)totalMarketValue{
    CABasicAnimation *ba = [CABasicAnimation animationWithKeyPath:@"totalMarketValue"];
    ba.duration =  1.0-(totalMarketValue/100)*1.0;
    ba.delegate = self;
    ba.fromValue = [NSNumber numberWithFloat:0];
    ba.toValue = [NSNumber numberWithFloat:totalMarketValue];
    [self.layer addAnimation:ba forKey:@"totalMarketValue"];
    ((QDCapitalDistributeDiagramLayer*)self.layer).totalMarketValue = totalMarketValue;
}

- (void)setLeftTotal:(CGFloat)leftTotal{
    CABasicAnimation *ba = [CABasicAnimation animationWithKeyPath:@"leftTotal"];
    ba.duration = 1.0-(leftTotal/100)*1.0;
    ba.delegate = self;
    ba.fromValue = [NSNumber numberWithFloat:0];
    ba.toValue = [NSNumber numberWithFloat:leftTotal];
    [self.layer addAnimation:ba forKey:@"leftTotal"];
    ((QDCapitalDistributeDiagramLayer*)self.layer).leftTotal = leftTotal;
}
-(void)setFreezeCapital:(CGFloat)freezeCapital{
    CABasicAnimation *ba = [CABasicAnimation animationWithKeyPath:@"freezeCapital"];
    ba.duration = 1.0-(freezeCapital/100)*1.0;
    ba.delegate = self;
    ba.fromValue = [NSNumber numberWithFloat:0];
    ba.toValue = [NSNumber numberWithFloat:freezeCapital];
    [self.layer addAnimation:ba forKey:@"freezeCapital"];
    ((QDCapitalDistributeDiagramLayer*)self.layer).freezeCapital = freezeCapital;

}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if([((CAPropertyAnimation*)anim).keyPath isEqualToString:@"totalMarketValue"])
    {
        [self addTextLayer:1];
        [self addSepLayer:0];
        if(_leftTotal!=0)
        {
            self.leftTotal=_leftTotal;
        }
        else
        {
            if(_freezeCapital!=0)
            {
                self.freezeCapital=_freezeCapital;
            }
        }
        
    }
    else if ([((CAPropertyAnimation*)anim).keyPath isEqualToString:@"leftTotal"])
    {
        [self addTextLayer:0];
        [self addSepLayer:1];
        if(_freezeCapital!=0)
        {
            self.freezeCapital=_freezeCapital;
        }
    }else if ([((CAPropertyAnimation*)anim).keyPath isEqualToString:@"freezeCapital"]){
        [self addSepLayer:2];
        NSLog(@"动画完毕");
    }
    
}

@end

#import "TTTAttributedLabel.h"

@interface QDCapitalDistibuteDiagramCell()
@property (nonatomic, strong) TTTAttributedLabel*leftValueLab;
@property (nonatomic, strong) TTTAttributedLabel *freezeValueLab;
@property (nonatomic, strong) TTTAttributedLabel  *totalValueLab;
@property (nonatomic, strong)UILabel *leftStaticLab;
@property (nonatomic, strong)UILabel *freezeStaticLab;
@property (nonatomic, strong)UILabel *totalStaticLab;
@property (nonatomic, strong)UILabel *circleTitle1; //账面结余原点
@property (nonatomic, strong)UILabel *circleTitle2; //委托冻结资金
@property (nonatomic, strong)UILabel *circleTitle3; //股票总市值

@end

@implementation QDCapitalDistibuteDiagramCell

static const NSInteger labelWidth = 60;
static const NSInteger labelHight = 10;
static const NSInteger labelValueHight = 15;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withRadius:(CGFloat)radius{
    self.radius = radius;
    return [self initWithStyle:style reuseIdentifier:reuseIdentifier];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _dataSource = [[NSMutableArray alloc] init];
        _circleTitle1 = [[UILabel alloc] init];
        _circleTitle1.backgroundColor = UIColorFromRGBA(0x315c7f, 1.0);
        _circleTitle1.layer.cornerRadius = AdjustHeight(5);
        _circleTitle1.layer.masksToBounds = YES;
        
        [self addSubview:_circleTitle1];
        
        _circleTitle2 = [[UILabel alloc] init];
        _circleTitle2.backgroundColor = UIColorFromRGBA(0x62a0ee, 1.0);
        _circleTitle2.layer.cornerRadius = AdjustHeight(5);
        _circleTitle2.layer.masksToBounds = YES;
        [self addSubview:_circleTitle2];

        _circleTitle3 = [[UILabel alloc] init];
        _circleTitle3.backgroundColor = UIColorFromRGBA(0xcb271b, 1.0);
        _circleTitle3.layer.cornerRadius = AdjustHeight(5);
        _circleTitle3.layer.masksToBounds = YES;
        [self addSubview:_circleTitle3];

        
        
        //标题
        _leftStaticLab = [[UILabel alloc] init];
        _leftStaticLab.textColor =  UIColorFromRGBA(0x676767, 1.0);
        _leftStaticLab.textAlignment = NSTextAlignmentLeft;
        _leftStaticLab.font = [UIFont systemFontOfSize:AdjustFontSize(10)];
        _leftStaticLab.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_leftStaticLab];
        //值
        _leftValueLab = [[TTTAttributedLabel alloc] init];
        _leftValueLab.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_leftValueLab];
        //标题
        _freezeStaticLab = [[UILabel alloc] init ];
        _freezeStaticLab.textColor = UIColorFromRGBA(0x676767, 1.0);
        _freezeStaticLab.textAlignment = NSTextAlignmentLeft;
        _freezeStaticLab.font = [UIFont systemFontOfSize:AdjustFontSize(10)];
        _freezeStaticLab.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_freezeStaticLab];
        //值
        _freezeValueLab = [[TTTAttributedLabel alloc] init];
        _freezeValueLab.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_freezeValueLab];
        //标题
        _totalStaticLab = [[UILabel alloc] init];
        _totalStaticLab.textColor = UIColorFromRGBA(0x676767, 1.0);
        _totalStaticLab.textAlignment = NSTextAlignmentLeft;
        _totalStaticLab.font = [UIFont systemFontOfSize:AdjustFontSize(10)];
        _totalStaticLab.adjustsFontSizeToFitWidth= YES;
        [self addSubview:_totalStaticLab];
        //值
        _totalValueLab = [[TTTAttributedLabel alloc] init];
        _totalValueLab.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_totalValueLab];

        //扇形图
        _sector = [[QDCapitalDistibuteDiagramView alloc] init];
        _sector.radius = self.radius;
        _sector.backgroundColor = [UIColor clearColor];
        _sector.fontSize = AdjustFontSize(10.0);
        [self addSubview:_sector];

       }
    return self;
}

- (void)getTitleName{
    if(self.dataSource != nil && self.dataSource.count>=3){
        _leftStaticLab.text = [[QDStockSingletonConfigTools sharedManager] getMemberName:[self.dataSource[0] intValue]];//NSLocalizedString(@"账面结余", @"");
        _freezeStaticLab.text = [[QDStockSingletonConfigTools sharedManager] getMemberName:[self.dataSource[1] intValue]];//NSLocalizedString(@"委托冻结资金", @"");
        _totalStaticLab.text = [[QDStockSingletonConfigTools sharedManager] getMemberName:[self.dataSource[2] intValue]];//NSLocalizedString(@"股票总市值", @"");
    }
}


- (void)layoutSubviews{
    //账面结余
    self.circleTitle1.frame = CGRectMake(AdjustWidth(11), (self.bounds.size.height-AdjustHeight(labelHight)*3)/4, AdjustHeight(labelHight), AdjustHeight(labelHight));
    self.leftStaticLab.frame = CGRectMake(CGRectGetMaxX(self.circleTitle1.frame)+AdjustWidth(1), (self.bounds.size.height-(AdjustHeight(labelHight)*3))/4, AdjustWidth(labelWidth), AdjustHeight(labelHight));
    self.leftValueLab.frame = CGRectMake(CGRectGetMaxX(_leftStaticLab.frame)+AdjustWidth(4), (self.bounds.size.height-(AdjustHeight(labelValueHight)*3))/4, ScreenWidth-AdjustWidth(self.radius*2)-AdjustWidth(15)*2-AdjustWidth(labelWidth)-AdjustWidth(4), AdjustHeight(labelValueHight));
    //委托资金
    self.circleTitle2.frame = CGRectMake(AdjustWidth(11), (self.bounds.size.height-AdjustHeight(labelHight)*3)/4+CGRectGetMaxY(self.circleTitle1.frame), AdjustHeight(10), AdjustHeight(labelHight));
    self.freezeStaticLab.frame = CGRectMake(CGRectGetMaxX(self.circleTitle2.frame)+AdjustWidth(1), (self.bounds.size.height-(AdjustHeight(labelHight)*3))/4+CGRectGetMaxY(self.leftStaticLab.frame), AdjustWidth(labelWidth), AdjustHeight(labelHight));
    self.freezeValueLab.frame = CGRectMake(CGRectGetMaxX(self.freezeStaticLab.frame)+AdjustWidth(4), (self.bounds.size.height-(AdjustHeight(labelValueHight)*3))/4+CGRectGetMaxY(self.leftValueLab.frame), ScreenWidth-AdjustWidth(self.radius*2)-AdjustWidth(15)*2-AdjustWidth(labelWidth)-AdjustWidth(4), AdjustHeight(labelValueHight));
    
    //总资产
     self.circleTitle3.frame = CGRectMake(AdjustWidth(11), (self.bounds.size.height-AdjustHeight(labelHight)*3)/4+CGRectGetMaxY(self.circleTitle2.frame), AdjustHeight(labelHight), AdjustHeight(labelHight));
    self.totalStaticLab.frame = CGRectMake(CGRectGetMaxX(self.circleTitle3.frame)+AdjustWidth(1), (self.bounds.size.height-(AdjustHeight(labelHight)*3))/4+CGRectGetMaxY(self.freezeStaticLab.frame), AdjustWidth(labelWidth), AdjustHeight(labelHight));
    self.totalValueLab.frame = CGRectMake(CGRectGetMaxX(self.totalStaticLab.frame)+AdjustWidth(4), (self.bounds.size.height-(AdjustHeight(labelValueHight)*3))/4+CGRectGetMaxY(self.freezeValueLab.frame), ScreenWidth-AdjustWidth(self.radius*2)-AdjustWidth(15)*2-AdjustWidth(labelWidth)-AdjustWidth(4), AdjustHeight(labelValueHight));
   
    
    self.sector.frame = CGRectMake(ScreenWidth-AdjustWidth(self.radius*2)-AdjustWidth(15), (self.frame.size.height-self.radius*2)/2, self.radius*2, self.radius*2);
    [super layoutSubviews];
    [self getTitleName];
}


- (void)resetLeftTotal:(CGFloat)lt freezeCapital:(CGFloat)fc totalMarketValue:(CGFloat)tm{
    CGFloat sum = lt + fc + tm;
    CGFloat leftValue = lt/sum*100;
    CGFloat freezeValue = fc/sum*100;
    CGFloat totalValue = tm/sum*100;
    self.leftValueLab.text =   [QDTool getAnomalyString:lt integerColor:[UIColor blackColor] decimalColor: UIColorFromRGBA(0x676767, 1.0) integerFontSize:AdjustFontSize(16) decimalFontSize:AdjustFontSize(10) haveSufix:0 textAlignment:NSTextAlignmentLeft];  // [QDTool trimStringAmount: [NSString stringWithFormat:@"%.2f", lt]];
    self.freezeValueLab.text = [QDTool getAnomalyString:fc integerColor:[UIColor blackColor] decimalColor:UIColorFromRGBA(0x676767, 1.0)integerFontSize:AdjustFontSize(16) decimalFontSize:AdjustFontSize(10) haveSufix:0 textAlignment:NSTextAlignmentLeft];//[QDTool trimStringAmount:[NSString stringWithFormat:@"%.2f", fc]];
    self.totalValueLab.text = [QDTool getAnomalyString:tm integerColor:[UIColor blackColor] decimalColor:UIColorFromRGBA(0x676767, 1.0) integerFontSize:AdjustFontSize(16) decimalFontSize:AdjustFontSize(10) haveSufix:0 textAlignment:NSTextAlignmentLeft];//[QDTool trimStringAmount: [NSString stringWithFormat:@"%.2f", tm]];
    
    
    [self.sector resetLeftTotal:leftValue freezeCapital:freezeValue totalMarketValue:totalValue];
    [self.sector begainAnimations];
}

@end
