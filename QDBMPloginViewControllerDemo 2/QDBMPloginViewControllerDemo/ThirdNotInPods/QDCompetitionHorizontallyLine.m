//
//  QDCompetitionHorizontallyLine.m
//  IQDII
//
//  Created by hydra on 15-2-8.
//  Copyright (c) 2015年 konson. All rights reserved.
//

#import "QDCompetitionHorizontallyLine.h"

@implementation QDCompetitionHorizontallyLine

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame lineColor:(UIColor*)lineColor
{
    self=[super initWithFrame:frame];
    if(self){
        self.lineColor=lineColor;
    }
    return self;
    
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
    CGContextSetLineWidth(context, 1);
    CGContextMoveToPoint(context, rect.origin.x, rect.origin.y);
    CGContextAddLineToPoint(context, rect.origin.x+rect.size.width, rect.origin.y);
    CGContextStrokePath(context);
}



@end
