//
//  QDTableAlert.m
//
//  Created by brkt on 15/8/19.
//  Copyright (c) 2015年 brkt. All rights reserved.
//

#import "QDTableAlert.h"
#import "TTTAttributedLabel.h"

#define TableAlertWidth     230.0
#define LateralInset         12.0
#define VerticalInset         8.0
#define MinAlertHeight      400.0
#define CancelButtonHeight   35.0
#define CancelButtonMargin    5.0
#define TitleLabelMargin     12.0
#define PriceMinus            101
#define PricePlus             102
#define AmountMinus           103
#define AmountPlus            104
#define CellRowHight          32

#define UIColorFromRGBA(rgbValue, alphaValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000)>>16))/255.0 \
green:((float)((rgbValue & 0x00FF00)>>8)/255.0) \
blue:((float)((rgbValue & 0x0000FF))/255.0) \
alpha:alphaValue]
#define NUMBERS @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
#define NUMBER2S @"0123456789"
#define RedCole [QDTool hexStringToColor:@"#CC0033"]

@interface QDTableAlert ()<UITextFieldDelegate>
@property (nonatomic, strong) UIView *alertBg;
@property (nonatomic, strong) UIView *alertBg1;
@property (nonatomic, assign) NSInteger AmountStep;
@property (nonatomic, assign) CGFloat   PriceStep;
@property (nonatomic, assign) CGFloat   AfferentPriceStep;
@property (nonatomic, assign) CGFloat   Price;
@property (nonatomic, assign) CGFloat   keyboardShowY;
@property (nonatomic, assign) NSInteger Amount;
@property (nonatomic, assign) BOOL      animate;
@property (nonatomic, assign) BOOL      amountToAdd;
@property (nonatomic, assign) BOOL      cellSelected;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UIButton *minusAmountButton;
@property (nonatomic, strong) UIButton *plusAmountButton;

@property (nonatomic, strong) UIButton *minusPriceButton;
@property (nonatomic, strong) UIButton *plusPriceButton;


@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) ConfirmButtonType confirmButtonType;
@property (nonatomic, assign) SkinType skintype;

@property (nonatomic, strong) NSMutableArray *arry;
@property (nonatomic, strong) NSMutableArray *PredicateArry;
@property (nonatomic, strong) NSMutableArray *PriceAndAmount;


@property (nonatomic, strong) QDTableAlertNumberOfRowsBlock numberOfRows;
@property (nonatomic, strong) OrderChainArryBlock  chainArry;


-(void)createBackgroundView;
-(void)animateshown;
-(void)animatedismissed;
-(void)dismissTableAlert;	
@end



@implementation QDTableAlert

#pragma mark - QDTableAlert Class Method

+(QDTableAlert *)tableAlertWithTitle:(NSString *)title confirmButtonType:(ConfirmButtonType)confirmButtonType skinType:(SkinType)skinType amountStep:(NSInteger)AmountStep  afferentpriceStep:(CGFloat)AfferentPriceStep emMarket:(emMarket)emMarket OrderChainArry:(OrderChainArryBlock)orderchainarry{
    
    return [[self alloc]initWithTitle:title confirmButtonType:confirmButtonType skinType:skinType amountStep:AmountStep
        afferentpriceStep: AfferentPriceStep  emMarket:emMarket OrderChainArry:(OrderChainArryBlock)orderchainarry];
}

-(id)initWithTitle:(NSString *)title confirmButtonType:(ConfirmButtonType)confirmButtonType skinType:(SkinType)skinType amountStep:(NSInteger)AmountStep afferentpriceStep:(CGFloat)AfferentPriceStep emMarket:(emMarket)emMarket OrderChainArry:(OrderChainArryBlock)orderchainarry{
    self.arry = [NSMutableArray array];
    self.isAnimate     = NO;
    self.isAmountToAdd = NO;
    NSDictionary *dic  = [NSMutableArray arrayWithArray:orderchainarry(0)][0];
    if (dic.count>1||dic ==nil) {
    NSException *exception = [NSException exceptionWithName:@"类型错误"reason:@"*** 必须传类似注释的数组字典" userInfo:nil];
        [exception raise];
    }
    
    self = [super init];
    if (self) {
            self.PredicateArry  = [NSMutableArray array];
            self.PriceAndAmount = [NSMutableArray array];
            _chainArry  = orderchainarry;
            _title      = title;
            _skintype   = skinType;
            _AmountStep = AmountStep;
            _height     = MinAlertHeight;
            _wide       = TableAlertWidth;
            _confirmButtonType  = confirmButtonType;
            _AfferentPriceStep  = AfferentPriceStep;
        

    }
    if (confirmButtonType == ConfirmChangOrdelStyle) {
        [self Screenarry];
    }
    return self;
}

- (void)Screenarry{
    
    self.PredicateArry = [[NSMutableArray alloc]initWithArray:self.chainArry(0)];
    NSDictionary *priceinfo  = [[NSDictionary alloc]init];
    NSDictionary *amountinfo = [[NSDictionary  alloc]init];
    for (int i = 0; i<self.PredicateArry.count; i++) {
        NSDictionary *dic = self.PredicateArry[i];
        for (int j = 0; j<[dic allKeys].count; j++) {
            id key = [[dic allKeys] objectAtIndex:j];
            if ([key isEqual:@"委托数量"]) {
                amountinfo = self.PredicateArry[i];
                self.Amount = [[[amountinfo objectForKey:key]copy]integerValue];
            }
            else if ([key isEqual:@"委托价格"]){
                priceinfo  = self.PredicateArry[i];
                self.Price = [[[priceinfo objectForKey:key]copy] doubleValue];
            }
        }
        
    }
    NSMutableArray *PriceAndAmount = [[NSMutableArray alloc]initWithObjects:priceinfo,amountinfo, nil];
    NSMutableArray *OtherData = [[NSMutableArray alloc]initWithArray:[self.PredicateArry filteredArrayUsingPredicate: [NSPredicate predicateWithFormat:@"NOT (SELF IN %@)",PriceAndAmount]]];
    self.PriceAndAmount  = [PriceAndAmount mutableCopy];
    self.PredicateArry   = [OtherData mutableCopy];
}


-(void)show
{
	[self createBackgroundView];
	self.alertBg = [[UIView alloc] initWithFrame:CGRectZero];
	[self addSubview:self.alertBg];
	UIImageView *alertBgImage = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:nil] stretchableImageWithLeftCapWidth:15 topCapHeight:30]];
    if (_skintype == BlackType) {
        [self.alertBg setBackgroundColor:[QDTool hexStringToColor:@"#1d2228"]];
    }
    else{
        [self.alertBg setBackgroundColor:[UIColor colorWithRed:49/255.0 green:92/255.0 blue:127/255.0 alpha:1.0]];
    }
   
    float tebleHigh = 0.0;
	self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	self.titleLabel.backgroundColor = [UIColor clearColor];
	self.titleLabel.textColor = [UIColor whiteColor];
	self.titleLabel.shadowColor = [[UIColor clearColor] colorWithAlphaComponent:0];
	self.titleLabel.shadowOffset = CGSizeMake(0, -1);
	self.titleLabel.font = [UIFont italicSystemFontOfSize:17.0];
	self.titleLabel.frame = CGRectMake(0, 15,self.wide, 10);
	self.titleLabel.text = self.title;
	self.titleLabel.textAlignment = NSTextAlignmentCenter;
	[self.alertBg addSubview:self.titleLabel];
    self.alertBg1 = [[UIView alloc]initWithFrame:CGRectMake(0, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + TitleLabelMargin, self.wide, (self.height - VerticalInset * 2)-self.titleLabel.frame.origin.y - self.titleLabel.frame.size.height)];
    [self.alertBg1 setBackgroundColor:[UIColor colorWithRed:235.0/255 green:235.0/255 blue:241.0/255 alpha:1]];
    [self.alertBg addSubview:self.alertBg1];
    if (_confirmButtonType == ConfirmChangOrdelStyle)tebleHigh = 90;
	self.table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
	self.table.frame = CGRectMake(0, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + TitleLabelMargin, self.wide, (self.height - VerticalInset * 2) - self.titleLabel.frame.origin.y - self.titleLabel.frame.size.height - TitleLabelMargin - CancelButtonMargin - CancelButtonHeight - tebleHigh);
    self.table.backgroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:241.0/255 alpha:1];
	self.table.layer.masksToBounds = YES;
	self.table.delegate = self;
	self.table.dataSource = self;
	self.table.backgroundView = [[UIView alloc] init];
    self.table.showsVerticalScrollIndicator = NO;
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [self.table setTableFooterView:view];
    self.table.separatorColor = [UIColor lightGrayColor];
    [self.table setSeparatorInset:(UIEdgeInsetsMake(0, 15, 0, 15))];
	[self.alertBg addSubview:self.table];
    {
        UIImageView *maskShadow = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"QDTableAlertShadowMask.png"] stretchableImageWithLeftCapWidth:6 topCapHeight:7]];
        maskShadow.userInteractionEnabled = NO;
        maskShadow.layer.masksToBounds = YES;
        maskShadow.frame = self.table.frame;
    
    }
    if (_confirmButtonType == ConfirmChangOrdelStyle) {
        self.minusPriceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.minusPriceButton.tag = PriceMinus;
        [self.minusPriceButton addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
        [self.minusPriceButton setBackgroundImage:[[UIImage imageNamed:@"transaction_buy_minus_small_hover"] stretchableImageWithLeftCapWidth:5 topCapHeight:0] forState:UIControlStateNormal];
        [self.minusPriceButton setBackgroundImage:[UIImage imageNamed:@"transaction_buy_minus_small_no"] forState:UIControlStateHighlighted];
        self.minusPriceButton.frame = CGRectMake(LateralInset+5, self.table.frame.origin.y + self.table.frame.size.height+ CancelButtonMargin+11, 25, 25 );
        [self.alertBg addSubview:self.minusPriceButton];
        
        self.minusAmountButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        self.minusAmountButton.tag = AmountMinus;
        [self.minusAmountButton setBackgroundImage:[[UIImage imageNamed:@"transaction_buy_minus_small_hover"] stretchableImageWithLeftCapWidth:5 topCapHeight:0] forState:UIControlStateNormal];
        [self.minusAmountButton addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
        [self.minusAmountButton setBackgroundImage:[UIImage imageNamed:@"transaction_buy_minus_small_no"] forState:UIControlStateHighlighted];
        
        self.minusAmountButton.frame = CGRectMake(LateralInset+5, self.table.frame.origin.y + self.table.frame.size.height+ CancelButtonMargin+5+CGRectGetHeight(self.minusPriceButton.frame)+15+5, 25, 25 );
        [self.alertBg addSubview:self.minusAmountButton];
        self.priceTextField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.minusPriceButton.frame)+CGRectGetMinX(self.minusPriceButton.frame)+VerticalInset, self.minusPriceButton.frame.origin.y, 130, 25)];
        self.priceTextField .text = [NSString stringWithFormat:@"%.3f",self.Price];
//        self.priceTextField.userInteractionEnabled = NO;
        self.priceTextField.textAlignment = NSTextAlignmentCenter;
        self.priceTextField.font = [UIFont systemFontOfSize:13.0];
        self.priceTextField.borderStyle = UITextBorderStyleRoundedRect;
        self.priceTextField.keyboardType = UIKeyboardTypeDecimalPad;
        self.priceTextField.tag = 101;
        self.priceTextField.delegate = self;
        if (_skintype == BlackType) self.priceTextField.keyboardAppearance=UIKeyboardAppearanceAlert;
        [self.priceTextField addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
        [self.alertBg addSubview:self.priceTextField];
        
        self.amountTextField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.minusAmountButton.frame)+CGRectGetMinX(self.minusAmountButton.frame)+VerticalInset, self.minusAmountButton.frame.origin.y, 130, 25)];
        self.amountTextField.text = [NSString stringWithFormat:@"%d",self.Amount];
//        self.amountTextField.userInteractionEnabled = NO;
        self.amountTextField.borderStyle = UITextBorderStyleRoundedRect;
        self.amountTextField.textAlignment = NSTextAlignmentCenter;
        self.amountTextField.font = [UIFont systemFontOfSize:13.0];
        self.amountTextField.keyboardType = UIKeyboardTypeNumberPad;
        if (_skintype == BlackType) self.amountTextField.keyboardAppearance=UIKeyboardAppearanceAlert;
        self.amountTextField.delegate = self;
        self.amountTextField.tag = 102;
        [self.alertBg addSubview:self.amountTextField];

        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(KeyboardWillShow) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(KeyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
        self.plusPriceButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.plusPriceButton addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
        self.plusPriceButton.tag = PricePlus;
        [self.plusPriceButton setBackgroundImage:[[UIImage imageNamed:@"transaction_buy_plus_small_hover"] stretchableImageWithLeftCapWidth:5 topCapHeight:0] forState:UIControlStateNormal];
        [self.plusPriceButton setBackgroundImage:[UIImage imageNamed:@"transaction_buy_plus_small_no"] forState:UIControlStateHighlighted];
        self.plusPriceButton.frame = CGRectMake(self.priceTextField.frame.origin.x + self.priceTextField.frame.size.width +VerticalInset, self. minusPriceButton.frame.origin.y,25, 25 );
        [self.alertBg addSubview:self.plusPriceButton];
        
        self.plusAmountButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.plusAmountButton.tag = AmountPlus;
        [self.plusAmountButton addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
        [self.plusAmountButton setBackgroundImage:[[UIImage imageNamed:@"transaction_buy_plus_small_hover"] stretchableImageWithLeftCapWidth:5 topCapHeight:0] forState:UIControlStateNormal];
        [self.plusAmountButton setBackgroundImage:[UIImage imageNamed:@"transaction_buy_plus_small_no"] forState:UIControlStateHighlighted];
        self.plusAmountButton.frame =  CGRectMake(self.priceTextField.frame.origin.x + self.amountTextField.frame.size.width +VerticalInset, self. minusAmountButton.frame.origin.y,25, 25 );
        [self.alertBg addSubview:self.plusAmountButton];
    }
    
    
    self.confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    if (_confirmButtonType == ConfirmCancelOrdelStyle) {
        [self.confirmButton setBackgroundImage:[[UIImage imageNamed:@"transaction_cancellation_small_hover.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:0] forState:UIControlStateNormal];
        [self.confirmButton setBackgroundImage:[[UIImage imageNamed:@"transaction_cancellation_small-.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:0] forState:UIControlStateHighlighted];
    }
    else if (_confirmButtonType == ConfirmBuyOrdelStyle){
        [self.confirmButton setBackgroundImage:[[UIImage imageNamed:@"transaction_buy_small_hover.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:0] forState:UIControlStateNormal];
        [self.confirmButton setBackgroundImage:[[UIImage imageNamed:@"transaction_buy_small.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:0] forState:UIControlStateHighlighted];
    
    }
    else if(_confirmButtonType == ConfirmSaleOrdelStyle){
    
        [self.confirmButton setBackgroundImage:[[UIImage imageNamed:@"transaction_sale_small_hover.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:0] forState:UIControlStateNormal];
        [self.confirmButton setBackgroundImage:[[UIImage imageNamed:@"transaction_sale_small.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:0] forState:UIControlStateHighlighted];
    
    
    }
    else if (_confirmButtonType == ConfirmChangOrdelStyle){

        [self.confirmButton setBackgroundImage:[[UIImage imageNamed:@"transaction_change_small_hover.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:0] forState:UIControlStateNormal];
        [self.confirmButton setBackgroundImage:[[UIImage imageNamed:@"transaction_change_small.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:0] forState:UIControlStateHighlighted];
        
    }

    self.confirmButton.frame = CGRectMake(LateralInset+((self.wide - LateralInset * 2)/2)+4, self.table.frame.origin.y + self.table.frame.size.height + CancelButtonMargin+tebleHigh, (self.wide - LateralInset * 2)/2-8, CancelButtonHeight);
    self.confirmButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.confirmButton.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
    self.confirmButton.titleLabel.shadowOffset = CGSizeMake(0, -1);
    self.confirmButton.titleLabel.shadowColor = [[UIColor clearColor] colorWithAlphaComponent:0.75];
    [self.confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.confirmButton setBackgroundColor:[UIColor clearColor]];
          self.confirmButton.opaque = NO;
     self.confirmButton.layer.cornerRadius = 5.0;
    [self.confirmButton addTarget:self action:@selector(confir) forControlEvents:UIControlEventTouchUpInside];
	[self.alertBg addSubview:self.confirmButton];
    
	self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
	self.cancelButton.frame = CGRectMake(LateralInset, self.table.frame.origin.y + self.table.frame.size.height + CancelButtonMargin+tebleHigh, (self.wide - LateralInset * 2)/2-8, CancelButtonHeight);
	self.cancelButton.titleLabel.textAlignment = NSTextAlignmentCenter;
	self.cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
	self.cancelButton.titleLabel.shadowOffset = CGSizeMake(0, -1);
	self.cancelButton.titleLabel.shadowColor = [[UIColor clearColor] colorWithAlphaComponent:0.75];
	[self.cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[self.cancelButton setBackgroundColor:[UIColor clearColor]];
	[self.cancelButton setBackgroundImage:[[UIImage imageNamed:@"transaction_cancel_small_hover.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:0] forState:UIControlStateNormal];
	[self.cancelButton setBackgroundImage:[[UIImage imageNamed:@"transaction_cancel_small.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:0] forState:UIControlStateHighlighted];
	self.cancelButton.opaque = NO;
	self.cancelButton.layer.cornerRadius = 5.0;
	[self.cancelButton addTarget:self action:@selector(dismissTableAlert) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(KeyBoardtouchDown)];
    tap.numberOfTapsRequired = 1;
    [self.alertBg addGestureRecognizer:tap];
    [self addGestureRecognizer:tap];
	[self.alertBg addSubview:self.cancelButton];
	self.alertBg.frame = CGRectMake((self.frame.size.width - self.wide) / 2, (self.frame.size.height - self.height) / 2, self.wide, self.height - VerticalInset * 2);
	alertBgImage.frame = CGRectMake(0.0, 0.0, self.wide, self.height);
	[self becomeFirstResponder];
    
	[self animateshown];
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSCharacterSet *cs;
    BOOL isHaveDian = YES;
    if (textField.tag == 100) {
        cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS]invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""];
        
        BOOL canChange = [string isEqualToString:filtered];
        
        return canChange;
    }else if (textField.tag == 101){
        
        int nPos = 3;
        
        if ([textField.text rangeOfString:@"."].location == NSNotFound) {
            isHaveDian=NO;
        }
        if ([string length]>0)
        {
            unichar single=[string characterAtIndex:0];//当前输入的字符
            if ((single >='0' && single<='9') || single=='.')//数据格式正确
            {
                //首字母不能为0和小数点
                if([textField.text length]==0){
                    if(single == '.'){
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }
                if (single=='.')
                {
                    if(!isHaveDian)//text中还没有小数点
                    {
                        isHaveDian=YES;
                        return YES;
                    }else
                    {
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }
                else
                {
                    if (isHaveDian)//存在小数点
                    {
                        //判断小数点的位数
                        NSRange ran=[textField.text rangeOfString:@"."];
                        int tt=range.location-ran.location;
                        if (tt <= nPos){
                            return YES;
                        }else{
                            return NO;
                        }
                    }
                    else
                    {
                        return YES;
                    }
                }
            }else{//输入的数据格式不正确
                [textField.text stringByReplacingCharactersInRange:range withString:@""];
                return NO;
            }
        }
        else
        {
            return YES;
        }
    }else if (textField.tag == 102){
        if ([textField.text rangeOfString:@"."].location==NSNotFound) {
            isHaveDian=NO;
        }
        if ([string length]>0)
        {
            unichar single=[string characterAtIndex:0];//当前输入的字符
            if ((single >='0' && single<='9') || single=='.')//数据格式正确
            {
                //首字母不能为0和小数点
                if([textField.text length]==0){
                    if(single == '.'){
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                    if (single == '0') {
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }
                if (single=='.')
                {
                    return NO;
                }
            }else{//输入的数据格式不正确
                [textField.text stringByReplacingCharactersInRange:range withString:@""];
                return NO;
            }
        }
    }
    return YES;
}
- (void)KeyBoardtouchDown{

    [self.priceTextField resignFirstResponder];
    [self.amountTextField resignFirstResponder];;
}
- (void)KeyboardWillShow{

    [UIView animateWithDuration:0.3 animations:^{
        self.alertBg.frame = CGRectMake((self.frame.size.width - self.wide) / 2, (self.frame.size.height - self.height) / 2-80, self.wide, self.height - VerticalInset * 2);
    } completion:^(BOOL finished) {
        self.keyboardShowY = self.alertBg.frame.origin.y;
        
    }];

}
- (void)KeyboardWillHide{
  
    [UIView animateWithDuration:0.5 animations:^{
        self.alertBg.frame = CGRectMake((self.frame.size.width - self.wide) / 2,self.keyboardShowY+80, self.wide, self.height - VerticalInset * 2);
    } completion:^(BOOL finished) {
       
    }];

}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqual:@"text"]&&object == self.priceTextField) {
        if ([self.priceTextField.text doubleValue]>self.Price) {
             self.priceTextField.textColor = RedCole;
        }
        else if ([self.priceTextField.text doubleValue]<self.Price){
            self.priceTextField.textColor = [QDTool hexStringToColor:@"#009966"];
        }
        else{
            self.priceTextField.textColor = [UIColor blackColor];
        }
       
    }


}
-(void)btnclick:(id)send{
    UIButton *btn = send;
    if (btn.tag == PriceMinus) {
        CGFloat price = [self.priceTextField.text doubleValue];
        self.PriceStep = [self NextSpread_Down:mkt_HKG Price:price];
        if (_AfferentPriceStep >0)
        self.PriceStep = _AfferentPriceStep;
        price  = price - self.PriceStep;
        /***
        CGFloat  step = [self NextSpread_Down:mkt_HKG Price:price];
        if (self.PriceStep != step) {
            price = price + self.PriceStep - step;
        }*/
        if (price <= 0&& _AfferentPriceStep>0) price = 0;
        self.priceTextField.text = [NSString stringWithFormat:@"%.3lf",price];
    }
    else if (btn.tag == PricePlus){
        CGFloat price = [self.priceTextField.text doubleValue];
        self.PriceStep = [self NextSpread_Down:mkt_HKG Price:price];
        if (_AfferentPriceStep>0)
        self.PriceStep = _AfferentPriceStep;
        if ([self.priceTextField.text isEqual:@"0.010"]) self.PriceStep = 0.001;
        price  = price + self.PriceStep;
        if (_AfferentPriceStep<=0){
            CGFloat step = [self NextSpread_Down:mkt_HKG Price:price];
            if (self.PriceStep != step ) {
                price = price - self.PriceStep + step;
            }
        }

        self.priceTextField.text = [NSString stringWithFormat:@"%.3lf",price];

    }
    else if (btn.tag == AmountMinus){
        NSInteger amount = [self.amountTextField.text integerValue];
        amount = amount - self.AmountStep;
        if (amount <= 0) amount = 0;
        self.amountTextField.text = [NSString stringWithFormat:@"%d",amount];
    
    }
    else if (btn.tag == AmountPlus){
            NSInteger amount = [self.amountTextField.text integerValue];
        if (_isAmountToAdd) {
            amount = amount + self.AmountStep;
            self.amountTextField.text = [NSString stringWithFormat:@"%d",amount];
        }
        else{
            if (self.Amount != amount ) {
            amount = amount + self.AmountStep;
            self.amountTextField.text = [NSString stringWithFormat:@"%d",amount];
            }
        }
        
    }
    
}

-(void)dismissTableAlert
{
	[self animatedismissed];
	if (self.CancelBlock != nil)
		if (!self.cellSelected)
			self.CancelBlock();
}

-(BOOL)canBecomeFirstResponder
{
	return YES;
}

-(void)setHeight:(CGFloat)height
{
	if (height > MinAlertHeight)
		_height = height;
	else
		_height = MinAlertHeight;
}

-(void)setWide:(CGFloat)wide{
    
    if (wide < TableAlertWidth) {
        _wide = wide;
    }
    else{
        _wide = TableAlertWidth;
    }

}
-(void)setIsAnimate:(BOOL)isAnimate{
    if (isAnimate == YES) {
        _isAnimate = isAnimate;
    }
    else{
        _isAnimate = NO;
    }
}
-(void)setIsAmountToAdd:(BOOL)isAmountToAdd{

    if (isAmountToAdd == YES) {
        _isAmountToAdd = isAmountToAdd;
    }
    else{
        _isAmountToAdd = NO;
    }
}
#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_confirmButtonType == ConfirmChangOrdelStyle)
        return  self.PredicateArry.count;
        return  self.chainArry(section).count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ID";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if (cell == nil) {
        cell = [[TableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
        cell.chaindic = self.chainArry(indexPath.row)[indexPath.row];
        if (_confirmButtonType == ConfirmChangOrdelStyle){
            cell.chaindic = self.PredicateArry[indexPath.row];
        }
    return cell;
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CellRowHight;
}
- (void)confir{
    
    [self animatedismissed];
    for (NSMutableDictionary *dic in self.PriceAndAmount) {
        if ([[[dic allKeys]firstObject]isEqual:@"委托价格"]) {
            NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithObject:self.priceTextField.text forKey:@"委托价格"];

            [dic1 setValue:self.priceTextField.text forKey:@"委托数量"];
            [self.PredicateArry addObject:dic1];
        }
        if ([[[dic allKeys]firstObject]isEqual:@"委托数量"]) {
            NSMutableDictionary *dic2 = [NSMutableDictionary dictionaryWithObject:self.amountTextField.text forKey:[[dic allKeys]firstObject]];
            [self.PredicateArry addObject:dic2];
        }
    }
    NSLog(@"%@",self.PredicateArry);
    if (self.confirBlock != nil)
        if (!self.cellSelected)
            self.confirBlock(self.PredicateArry);

}

-(void)ConfirmBlock:(QDTableAlertConfirBlock)confirmBlock andCancelBlock:(QDTableAlertCancelBlock)cancelBlock
{
    self.confirBlock  = confirmBlock;
    self.CancelBlock  = cancelBlock;
}
-(void)createBackgroundView
{
    self.cellSelected = NO;
    self.frame = [[UIScreen mainScreen] bounds];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    self.opaque = NO;//减少开销
    UIWindow *appWindow = [[UIApplication sharedApplication] keyWindow];
    [appWindow addSubview:self];

    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.25];
    }];
}

-(void)animateshown
{
    if (self.isAnimate) {
        self.alertBg.transform = CGAffineTransformMakeScale(0.6, 0.6);
        [UIView animateWithDuration:0.2 animations:^{
            self.alertBg.transform = CGAffineTransformMakeScale(1.1, 1.1);
        } completion:^(BOOL finished){
            [UIView animateWithDuration:1.0/15.0 animations:^{
                self.alertBg.transform = CGAffineTransformMakeScale(0.9, 0.9);
            } completion:^(BOOL finished){
                [UIView animateWithDuration:1.0/7.5 animations:^{
                    self.alertBg.transform = CGAffineTransformIdentity;
                }];
            }];
        }];
    }
    else{
        self.alertBg.transform = CGAffineTransformIdentity;
    }
    
}

-(void)animatedismissed
{
    if (self.isAnimate) {
        [UIView animateWithDuration:1.0/7.5 animations:^{
            self.alertBg.transform = CGAffineTransformMakeScale(1.1, 1.1);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1.0/15.0 animations:^{
                self.alertBg.transform = CGAffineTransformMakeScale(1.1, 1.1);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.4 animations:^{
                    self.alertBg.transform = CGAffineTransformMakeScale(1.1, 1.1);
                    self.alpha = 0.1;
                } completion:^(BOOL finished){
                    [self removeFromSuperview];
                }];
            }];
        }];
    }
    else{
        [self removeFromSuperview];

    }

}
- (CGFloat)NextSpread_Down:(emMarket)mkt Price:(double)price{
    
    if (mkt == mkt_HKG || mkt == mkt_unknown) {
        
        // 保留四位小数精度.
        price = ( (long long)(price*10000+0.5) )/10000.0 ;
        
        // bill说: 港股的最低买卖价是 0.01
        if( price<=0.01 )
            return 0.0 ;
        
        if( price>0.01 && price<=0.25 )
            return 0.001;
        else if (price>0.25 && price<=0.50 )
            return 0.005;
        else if(price>0.50 && price<=10.00 )
            return 0.010;
        else if( price>10.00 && price<=20.00 )
            return 0.020;
        else if( price>20.00 && price<=100.00 )
            return 0.050;
        else if( price>100.00 && price<=200.00 )
            return 0.100;
        else if( price>200.00 && price<=500.00 )
            return 0.200;
        else if( price>500.00 && price<=1000.00 )
            return 0.500;
        else if( price>1000.00 && price<=2000.00 )
            return 1.000;
        else if( price>2000.00 && price<=5000.00 )
            return 2.000;
        else if( price>=5000.00 && price<9995.00 )
            return 5.000 ;
    }
    if (mkt == mkt_SHB) {
        return 0.001;
    }
    
    return 0.01;
}
- (void)dealloc{
    [self.priceTextField removeObserver:self forKeyPath:@"text" context:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

@interface TableViewCell()

@property (nonatomic,strong) UILabel * TextLabel;
@property (nonatomic,copy) NSString *leftText;
@property (nonatomic,copy) NSString *righText;

@end

@implementation TableViewCell

- (void)awakeFromNib {
    
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UILabel *TextLabel = [[UILabel alloc]init];
        TextLabel.textColor = [UIColor grayColor];
    
        [TextLabel setFont:[UIFont fontWithName:@"Arial" size:13.0]];
 
        [TextLabel setTextColor:UIColorFromRGBA(0x676767, 1.0)];
        TextLabel.textAlignment = NSTextAlignmentLeft;
        TextLabel.adjustsFontSizeToFitWidth = YES;
        TextLabel.shadowColor = UIColor.clearColor;
        TextLabel.shadowOffset = CGSizeMake(.0, .0);
        [self.contentView addSubview:TextLabel];
        self.TextLabel = TextLabel;

        TTTAttributedLabel *TttRighLabel = [[TTTAttributedLabel alloc]init];
        TttRighLabel.textAlignment = NSTextAlignmentRight;
        TttRighLabel.adjustsFontSizeToFitWidth = YES;
        TttRighLabel.font = [UIFont systemFontOfSize:13.0];
        [self.contentView addSubview:TttRighLabel];
         self.TttRighLabel = TttRighLabel;
        
    }
    
    return self;
}
-(void)setChaindic:(NSDictionary *)chaindic{
    
    _chaindic = chaindic;
    [self setdata];
    [self setfram];
    
}
- (void)setdata{

    if ([_chaindic allValues].count||[_chaindic allKeys].count) {
        _leftText  = [[_chaindic allKeys]firstObject];
        _righText  = [[_chaindic allValues]firstObject];
    }
    self.TextLabel.text = _leftText;
    self.TttRighLabel.text = _righText;
    self.TttRighLabel.textColor = [UIColor blackColor];
   if   ([_leftText isEqual:@"证券操作"]||[_leftText isEqual:@"证券代码"]) {
       
       self.TttRighLabel.textColor = RedCole;
       self.TttRighLabel.text = _righText;
       return;
    }
    else if ([_leftText isEqual:@"委托价格"]){
         double righText = [_righText doubleValue];
        self.TttRighLabel.text = [QDTool getAnomalyString:righText integerColor:RedCole decimalColor:RedCole integerFontSize:AdjustFontSize(13) decimalFontSize:AdjustFontSize(13) haveSufix:0 textAlignment:NSTextAlignmentRight];
        return;
    }
    else if ([_leftText isEqual:@"委托类型"]){
       self.TttRighLabel.textColor = RedCole;
       self.TttRighLabel.text = _righText;
        return;
    }
    else if ([_leftText isEqual:@"委托金额"]){
        double righText = [_righText doubleValue];
    self.TttRighLabel.text =[QDTool getAnomalyString:righText integerColor:[UIColor blackColor] decimalColor:UIColorFromRGBA(0x676767, 1.0) integerFontSize:AdjustFontSize(13) decimalFontSize:AdjustFontSize(9) haveSufix:0 textAlignment:NSTextAlignmentRight];
        return;

    }
    else{
       self.TttRighLabel.textColor = [UIColor blackColor];
       self.TttRighLabel.text = _righText;
    }
    
    
}
- (void)setfram{
    self.TextLabel.frame =  CGRectMake(15, 0, 60, CellRowHight);
    self.TttRighLabel.frame = CGRectMake(80, 0,135, CellRowHight);
}


@end

