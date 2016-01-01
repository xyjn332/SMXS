//
//  QDCapitalDistributeDiagramLayer.m
//  QDBMPloginViewControllerDemo
//
//  Created by Weber on 15/7/3.
//  Copyright (c) 2015年 tsci. All rights reserved.
//

#import "QDCapitalDistributeDiagramLayer.h"
#import <UIKit/UIKit.h>

#define RGB(r,g,b)     [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

static const NSInteger offsetPosition = 0;//偏移位置

@implementation QDCapitalDistributeDiagramLayer

@dynamic totalMarketValue, leftTotal, freezeCapital;

- (id)init{
    if(self = [super init]){
       
    }
    return self;
}

+ (BOOL)needsDisplayForKey:(NSString *)key{
    if([key isEqualToString:@"leftTotal"] || [key isEqualToString:@"freezeCapital"] ||[key isEqualToString:@"totalMarketValue"] )
        return YES;
    else
        return [super needsDisplayForKey:key];
}


- (void)drawInContext:(CGContextRef)context{
    [super drawInContext:context];
    CGFloat radius = self.frame.size.width/2;
    CGPoint center = CGPointMake(offsetPosition+radius, offsetPosition+radius);
    float start=0;
   
    
    CGContextSetAllowsAntialiasing(context, YES);
    
    //背景

    CGContextAddArc(context, center.x, center.y, radius, start,2.0*M_PI, 0);
    CGContextAddLineToPoint(context, center.x, center.y);
    CGContextClosePath(context);
    CGContextSetFillColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextDrawPath(context, kCGPathFill);
//    CGContextFillPath(context);
    
    
    if(self.totalMarketValue != 0){
        //总市值
        CGContextAddArc(context, center.x, center.y, radius, start,self.totalMarketValue/100*2*M_PI, 0);
        CGContextAddLineToPoint(context, center.x, center.y);
        CGContextClosePath(context);
        CGContextSetFillColorWithColor(context,UIColorFromRGBA(0xcb271b, 1.0).CGColor);
        CGContextFillPath(context);
    
    }
    
    if(self.leftTotal!=0){
        //账面结余
        CGContextAddArc(context, center.x, center.y, radius, (self.totalMarketValue)/100*2*M_PI,(self.totalMarketValue+self.leftTotal)/100*2*M_PI, 0);
        CGContextAddLineToPoint(context, center.x, center.y);
        CGContextClosePath(context);
        CGContextSetFillColorWithColor(context, UIColorFromRGBA(0x315c7f, 1.0).CGColor);
        CGContextFillPath(context);
    }
    
    if(self.freezeCapital!=0){
        //冻结资金
        CGContextAddArc(context, center.x, center.y, radius, (self.totalMarketValue+self.leftTotal)/100*2*M_PI,(self.totalMarketValue+self.leftTotal+self.freezeCapital)/100*2*M_PI, 0);
        CGContextAddLineToPoint(context, center.x, center.y);
        CGContextClosePath(context);
        CGContextSetFillColorWithColor(context, UIColorFromRGBA(0x3d76b8, 1.0).CGColor);
        CGContextFillPath(context);
    }
   
    
}


@end
