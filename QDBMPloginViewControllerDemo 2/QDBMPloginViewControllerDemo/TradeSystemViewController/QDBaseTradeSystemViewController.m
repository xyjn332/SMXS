//
//  QDHodingViewController.m
//  QDBMPloginViewControllerDemo
//
//  Created by Weber on 15/7/7.
//  Copyright (c) 2015年 tsci. All rights reserved.
//

#import "QDBaseTradeSystemViewController.h"
#import "QDTool.h"
#import "Masonry.h"
#import "QDCompetitionHorizontallyLine.h"
#import "QDFatherTradeSystemViewController.h"
#import "QDTradeSystemBuyViewController.h"
#import "QDTraderSystemSellViewController.h"


@interface QDBaseTradeSystemViewController()
@property (nonatomic, strong)QDFatherTradeSystemViewController *buyViewController;
@property (nonatomic, strong)QDFatherTradeSystemViewController *sellViewController;

@property (nonatomic, strong)UIButton *buyButton;//买入
@property (nonatomic, strong)UIButton *sellButton;//卖出
@property (nonatomic, strong)UIScrollView *containerView;
@property (nonatomic, strong)NSArray *viewControllers;
@property (nonatomic, weak)UIViewController *currentViewController;


@end


@implementation QDBaseTradeSystemViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self initializeData];
    [self createUI];
}

#pragma mark - create UI

- (void)createUI{
    self.view.backgroundColor = UIColorFromRGBA(0xeef2f6, 1.0);
    
    
    UIImageView *background = [UIImageView new];
    background.image = [UIImage imageNamed:@"button_bg"];
    [self.view addSubview:background];

    
    _buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buyButton setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateSelected];
    [_buyButton setTitleColor:UIColorFromRGBA(0xcb271b, 1.0) forState:UIControlStateSelected];
    [_buyButton setTitleColor:UIColorFromRGBA(0xacacac, 1.0) forState:UIControlStateNormal];
    _buyButton.selected = YES;
    [_buyButton setTitle:@"买入" forState:UIControlStateNormal];
    _buyButton.titleLabel.font = [UIFont systemFontOfSize:AdjustFontSize(14)];
    [self.buyButton addTarget:self action:@selector(buyButtonAction:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_buyButton];
    
    _sellButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_sellButton setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateSelected];
    [_sellButton setTitleColor:UIColorFromRGBA(0x1a90f0,1.0) forState:UIControlStateSelected];
    [_sellButton setTitleColor:UIColorFromRGBA(0xacacac, 1.0) forState:UIControlStateNormal];
    _sellButton.selected = NO;
    [_sellButton setTitle:@"卖出" forState:UIControlStateNormal];
    _sellButton.titleLabel.font = [UIFont systemFontOfSize:AdjustFontSize(14)];
    [self.sellButton addTarget:self action:@selector(sellButtonAction:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_sellButton];
    
    
    QDCompetitionHorizontallyLine *seperator=[[QDCompetitionHorizontallyLine alloc] initWithFrame:CGRectMake(0, AdjustHeight(43.5), ScreenWidth, 0.5)  lineColor:UIColorFromRGBA(0xc7c7cc, 1.0)];
    [self.view addSubview:seperator];
    
    WS(ws);
    
    [background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.view).with.offset(AdjustWidth(15));
        make.right.equalTo(ws.view).with.offset(AdjustWidth(-15));
        make.top.equalTo(ws.view).with.offset(AdjustWidth(7));
        make.bottom.equalTo(seperator).with.offset(AdjustHeight(-7));

    }];
    
    [self.buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.view).with.offset(AdjustWidth(15));
        make.top.equalTo(ws.view).with.offset(AdjustWidth(7));
        make.bottom.equalTo(seperator).with.offset(AdjustHeight(-7));
        make.width.equalTo(ws.sellButton.mas_width);
    }];
    
    [self.sellButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.buyButton.mas_right);
        make.right.equalTo(ws.view).with.offset(AdjustWidth(-15));
        make.bottom.equalTo(ws.buyButton.mas_bottom);
        make.top.equalTo(ws.buyButton.mas_top);
    }];
    
    
    _containerView = [UIScrollView new];
    _containerView.backgroundColor = UIColorFromRGBA(0xeef2f6, 1.0);
    _containerView.scrollEnabled = NO;
    _containerView.contentSize = _containerView.frame.size;
    [self.view addSubview:_containerView];
    
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(seperator).with.offset(0.5);
        make.bottom.equalTo(ws.view.mas_bottom);
        make.left.equalTo(ws.view.mas_left);
        make.right.equalTo(ws.view.mas_right);
    }];
    
    
    _buyViewController = [[QDTradeSystemBuyViewController alloc] initWithType:tradeSystem_Buy];
    _buyViewController.view.frame = CGRectMake(0, 0, self.containerView.frame.size.width, self.containerView.frame.size.height);
    
    
    _sellViewController = [[QDTraderSystemSellViewController alloc] initWithType:tradeSystem_Sell];
    _sellViewController.view.frame = CGRectMake(0, 0, self.containerView.frame.size.width, self.containerView.frame.size.height);
   
    
    [self addChildViewController:_buyViewController];
    [self didMoveToParentViewController:self];
    [self addChildViewController:_sellViewController];
    [self didMoveToParentViewController:self];
    _viewControllers =  [[NSArray alloc] initWithObjects:_buyViewController, _sellViewController, nil];
    
    [self.containerView addSubview:_buyViewController.view];
    self.currentViewController = _buyViewController;
}


#pragma mark - initialize data
- (void)initializeData{
    
}


- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
//    KYAnimatedPageControl *pc = (KYAnimatedPageControl*)[self.view viewWithTag:1001];
//    pc.frame = CGRectMake(20, 200, 280, 50);
}


#pragma mark - button action
//买入button
- (void)buyButtonAction:(UIButton*)button{
    button.selected = YES;
    self.sellButton.selected = NO;
    
   
    if(self.currentViewController != self.viewControllers[0]){
        
        [self customerTransationFromVC:self.viewControllers[1] toVC:self.viewControllers[0] animated:NO];
        self.currentViewController = self.viewControllers[0];
    }
    
}
//卖出button
- (void)sellButtonAction:(UIButton*)button{
    button.selected = YES;
    self.buyButton.selected = NO;
   
    if(self.currentViewController != self.viewControllers[1]){

        [self customerTransationFromVC:self.viewControllers[0] toVC:self.viewControllers[1] animated:NO];
        self.currentViewController = self.viewControllers[1];
    }
}


- (void)customerTransationFromVC:(UIViewController*)fvc toVC:(UIViewController*)tvc animated:(BOOL)animated{
    if(tvc == nil){
        [fvc.view removeFromSuperview];
    }else if(fvc == nil){
        CGRect frame = self.containerView.bounds;
        tvc.view.frame = frame;
        [self.containerView addSubview:tvc.view];
    }else if(animated){
//        CGRect rect = self.containerView.bounds;
        
    }else{
        [fvc.view removeFromSuperview];
        [self.containerView addSubview:tvc.view];
        tvc.view.frame = self.containerView.bounds;
    }
}

////切换动画核心
//-(void)setSelectedIndex:(NSInteger)newSelectedIndex animated:(BOOL)animated{
//
//        
//        if(toViewController == nil){
//            [fromViewController.view removeFromSuperview];
//        }else if(fromViewController == nil){
//            CGRect frame = self.contentViewContainer.bounds;
//            frame  = self.contentViewContainer.bounds;
//            toViewController.view.frame = self.contentViewContainer.bounds;
//            [self.contentViewContainer addSubview:toViewController.view];
//        }else if(animated){
//            CGRect rect = self.contentViewContainer.bounds;
//            if(oldSelectIndex < newSelectedIndex){
//                rect.origin.x = rect.size.width;
//            }else{
//                rect.origin.x = -rect.size.width;
//            }
//            toViewController.view.frame = rect;
//            self.tabBarContainer.userInteractionEnabled = NO;
//            
//            [self transitionFromViewController:fromViewController toViewController:toViewController duration:0.3 options:UIViewAnimationOptionLayoutSubviews|UIViewAnimationOptionCurveEaseInOut animations:^{
//                CGRect rect = fromViewController.view.frame;
//                if(oldSelectIndex < newSelectedIndex){
//                    rect.origin.x = -rect.size.width;
//                }else{
//                    rect.origin.x = rect.size.width;
//                }
//                
//                fromViewController.view.frame = rect;
//                toViewController.view.frame = self.contentViewContainer.bounds;
//            }completion:^(BOOL finished){
//                self.tabBarContainer.userInteractionEnabled = YES;
//            }];
//        }else{
//            [fromViewController.view removeFromSuperview];
//            toViewController.view.frame = self.contentViewContainer.bounds;
//        }
//    }
//}
//



@end
