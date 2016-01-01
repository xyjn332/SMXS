//
//  QDTool.h
//  QDBMPloginViewControllerDemo
//
//  Created by Weber on 15/6/24.
//  Copyright (c) 2015年 tsci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "QDTradeSystemConstDefination.h"
#import "Toast+UIView.h"

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define ScreenHeight  [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define AdjustFontSize(f)   (f/320.0*ScreenWidth)
#define AdjustWidth(w)      (w/320.0*ScreenWidth)
#define AdjustHeight(h)     (h/568.0*ScreenHeight)

#define UIColorFromRGBA(rgbValue, alphaValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000)>>16))/255.0 \
green:((float)((rgbValue & 0x00FF00)>>8)/255.0) \
blue:((float)((rgbValue & 0x0000FF))/255.0) \
alpha:alphaValue]

@interface QDTool : NSObject

/**
 * 16进制颜色转换为UIColor
 * @param stringToConvert 16进制颜色数值
 * @note   尽量不要在tableview中使用此函数，取而代之宏（UIColorFromRGBA）。
 */
+(UIColor *) hexStringToColor: (NSString *) stringToConvert;

+(CGSize)getStringSizeWithString:(NSString*)evalContent font:(UIFont*)fontSize lableHeight:(CGFloat)height width:(CGFloat)width;
//测试合适字体
+ (CGFloat)sizeWithFontForGivingString:(NSString *)string fontsize:(NSInteger)size width:(CGFloat)wid;
//给数字加“,”分割符  (待优化)
+ (NSString *)trimStringAmount:(NSString *)amount;
//判断是否越狱
+ (BOOL)isPrisonBreak;
//调整view高度
+(void)adjustIOS7NavigationController:(UIViewController*)vc;

/************************************************************************************************
 *此函数的功能是获得数字和小数点颜色和字体不一致的情况.返回值不适用于UILabel控件，取而代之是TTTAttributedLabel
 * @param       value 传入要显示的值(double型)
 * @param       ic   整数部分的颜色（integer color）
 * @param       dc   小数部分颜色（decimal color）
 * @param       ifz  整数部分字体大小（integer font size）
 * @param       dfz  小数部分字体大小（decimal font size）
 * @param       hf   是否有前缀  0: 无  1: “+”  2: "-"
 *  @return     转换后要显示的值
 *  @note       fontsize 传得是字体大小值（NSInteger），而不是object
 *              color    传得是object
 *  @author     weber
 *  @time       2015/07/29
 *************************************************************************************************
 */
+ (NSMutableAttributedString *)getAnomalyString:(double)value integerColor:(UIColor*)ic decimalColor:(UIColor*)dc  integerFontSize:(NSInteger)ifz decimalFontSize:(NSInteger)dfz haveSufix:(short)hf textAlignment:(NSTextAlignment)alignment;

+(UILabel*)createLabelWithFrame:(CGRect)rect fontColor:(UIColor*)fontColor fontSize:(CGFloat)fontSize textAligment:(NSTextAlignment)textAligment;

+ (NSString*)convertNumberToChinese:(double)value;


/**
 *  此函数用来创建那种带指示标题的titleView
 *  @param  titleArray  标题数组
 *  @param  height     父view高度
 *  @param  position   x点位置
 *  @param  isFirst    指示器是否在第一个数字上，
 *  @param  index     标题数组的index
 *  @param  fontsize  字体大小（不是UIFont对象）
 *  @author weber
 */
+ (UIControl*)createTitleNameWithTitleArray:(NSMutableArray*)titleArray height:(CGFloat)TableViewSectionHeight position:(CGFloat)distance isFist:(BOOL)isFirst index:(NSInteger)index fontSize:(CGFloat)fontSize;

+ (NSString*)dateWithFormat:(NSDate*)format;
@end

@interface DateWithFormat : NSObject
+(NSDateFormatter*)sharedManager;

@end
