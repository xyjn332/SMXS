//
//  QDTradeSettingViewController.m
//  QDBMPloginViewControllerDemo
//
//  Created by Weber on 15/7/22.
//  Copyright (c) 2015年 tsci. All rights reserved.
//

#import "QDTradeSettingViewController.h"
#import "TTTAttributedLabel.h"




static const NSInteger MinDistance = 40;

@interface QDTradeSettingViewController ()
@property (nonatomic)CGPoint oldLocation;

@end

@implementation QDTradeSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initialize];
    [self createUI];
}
#pragma mark - createUI
- (void)createUI{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, self.view.bounds.size.width*3/4-40, 88)];
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont systemFontOfSize:17];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.text = @"看看就行了\n\t\t\t--by weber";
    [self.view addSubview:label];
    
    
    //title
//    TTTAttributedLabel *titleLable = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(30, 200, 200, 44)];
//    titleLable.adjustsFontSizeToFitWidth = YES;
//   
//
//    [titleLable setText:[QDTool getAnomalyString:+399999000.00 integerColor:[UIColor redColor] decimalColor:[UIColor lightGrayColor] integerFontSize:32 decimalFontSize:16 haveSufix:0]];
//    
//    TTTAttributedLabel *titleLable2 = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(30, 400, 200, 44)];
//    titleLable.adjustsFontSizeToFitWidth = YES;
//    
//    
//    [titleLable2 setText:[QDTool getAnomalyString:-3400 integerColor:[UIColor redColor] decimalColor:[UIColor lightGrayColor] integerFontSize:20 decimalFontSize:12 haveSufix:0]];
//    
//    [self.view addSubview:titleLable2];
//    
//    [self.view addSubview:titleLable];   
   
}

#pragma mark - 初始化数据
- (void)initialize{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(panGestureNotificationAction:) name:@"PANGESTURE" object:nil];
}


#pragma mark - panGestrue Action
- (void)panToAnyway:(UIPanGestureRecognizer*)recognizer{
    CGPoint translation = [recognizer translationInView:self.view];
    if(translation.x != 0)
        self.oldLocation = translation;
    
    if(self.view.frame.origin.x<=0){
        //x为0时就不能再移动了
        if(self.view.frame.origin.x+translation.x >= 0)
            return;
        
        //不知道为什么，无缘无故第一次时，frame会跑偏，所以校正一次
        CGRect ret  =  self.view.frame;
        if(self.view.frame.origin.x <-240){
            ret.origin.x = -240;
            self.view.frame = ret;
        }
        
        self.view.center = CGPointMake(self.view.center.x + translation.x,
                                             self.view.center.y);
        [recognizer setTranslation:CGPointZero inView:self.view];
     
        CGFloat rate = fabs(self.view.frame.origin.x)/self.view.bounds.size.width*0.7+0.2;
        NSLog(@"rate = %f", rate);
        if(self.delegate != nil &&  [(NSObject*)self.delegate respondsToSelector:@selector(panGestureWillEnd:byRate:)])
            [self.delegate panGestureWillEnd:YES byRate:rate];
    }
  
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        //刚刚拖动
        if(CGRectGetMaxX(self.view.frame)>MinDistance && self.oldLocation.x > 0){
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width*3/4, [UIScreen mainScreen].bounds.size.height);
                if(self.delegate != nil &&  [(NSObject*)self.delegate respondsToSelector:@selector(panGestureWillEnd:byRate:)])
                    [self.delegate panGestureWillEnd:NO byRate:0];
            }completion:^(BOOL finished){
                if(self.delegate != nil &&  [(NSObject*)self.delegate respondsToSelector:@selector(panGestureDidEnd:)])
                    [self.delegate panGestureDidEnd:NO];
            }];

            return;
        }
        //这是往回缩时的动画效果
        if(self.view.frame.origin.x+self.view.frame.size.width > [UIScreen mainScreen].bounds.size.width-[UIScreen mainScreen].bounds.size.width*1/4-MinDistance){
            NSLog(@"less than mindistance");
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width*3/4, [UIScreen mainScreen].bounds.size.height);
               if(self.delegate != nil &&  [(NSObject*)self.delegate respondsToSelector:@selector(panGestureWillEnd:byRate:)])
                   [self.delegate panGestureWillEnd:NO byRate:0];
            }completion:^(BOOL finished){
                if(self.delegate != nil &&  [(NSObject*)self.delegate respondsToSelector:@selector(panGestureDidEnd:)])
                [self.delegate panGestureDidEnd:NO];
            }];
        }else{
            NSLog(@"beyong mindistance");
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                self.view.frame = CGRectMake(-[UIScreen mainScreen].bounds.size.width*3/4, 0, [UIScreen mainScreen].bounds.size.width*3/4, [UIScreen mainScreen].bounds.size.height);
                if(self.delegate != nil &&  [(NSObject*)self.delegate respondsToSelector:@selector(panGestureWillEnd:byRate:)])
                    [self.delegate panGestureWillEnd:YES byRate:0];
            }completion:^(BOOL finished){
                if(self.delegate != nil &&  [(NSObject*)self.delegate respondsToSelector:@selector(panGestureDidEnd:)])
                    [self.delegate panGestureDidEnd:YES];
            }];
        }
        
    }
    
}
- (void)panGestureNotificationAction:(NSNotification *)notification{
    UIPanGestureRecognizer *panGesture = notification.object;
    [self panToAnyway:panGesture];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
