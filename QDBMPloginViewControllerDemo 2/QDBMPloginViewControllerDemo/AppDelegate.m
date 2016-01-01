//
//  AppDelegate.m
//  QDBMPloginViewControllerDemo
//
//  Created by Weber on 15/6/24.
//  Copyright (c) 2015年 tsci. All rights reserved.
//

#import "AppDelegate.h"
#import "QDTradeCashViewController.h"
#import "QDBaseTradeSystemViewController.h"
#import "QDOrderBaseViewController.h"
#import "SCNavTabBarController.h"
#import "QDTradeQueryBaseViewController.h"

#import "QDCustomTabViewController.h"

#import "QDTradeHodingViewController.h"


@interface AppDelegate () <UIGestureRecognizerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    QDBMPLoginViewController *vc = [[QDBMPLoginViewController alloc] init];
//    self.window.rootViewController = vc;
//    vc.view.backgroundColor = [UIColor whiteColor];
    
//    QDOrderBaseViewController *vc = [[QDOrderBaseViewController alloc] init];
//    ViewController *vc2 = [[ViewController alloc] init];
    
//    SCNavTabBarController *root = [[SCNavTabBarController alloc] init];
//    root.subViewControllers = @[vc0, vc1, vc2];
//    root.showArrowButton = NO;
//    [root addParentController:nil];
//    MainViewController *vc = [[MainViewController alloc] init];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
//    self.window.rootViewController = vc;//nav;
//    [QDTool convertNumberToChinese:100100100];
    
    QDTradeCashViewController *vc1 = [[QDTradeCashViewController alloc] init];
    vc1.title = @"持仓";
    
    QDBaseTradeSystemViewController *vc2 = [[QDBaseTradeSystemViewController alloc] init];
    vc2.title = @"交易";

    QDOrderBaseViewController *vc3 = [[QDOrderBaseViewController alloc] init];
    vc3.title = @"订单";
    vc3.view.backgroundColor = [UIColor cyanColor];

    QDTradeQueryBaseViewController *vc4 = [[QDTradeQueryBaseViewController alloc] init];
    vc4.title = @"查询";
    
    QDCustomTabViewController *customTabBarVC = [[QDCustomTabViewController alloc] init];
    customTabBarVC.subViewControllers =  @[vc1, vc2, vc3, vc4];
    
   
   
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:customTabBarVC];
     self.window.rootViewController = nav;

//    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panToTheNextViewController:)];
//    [self.window addGestureRecognizer:panGesture];
//    panGesture.delegate = self;
//    panGesture.delaysTouchesBegan = YES; //先识别手势，在进行事件派发
    
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTheViewWithWindowReceive:)];
//    tapGesture.delegate = self;
//    [self.window addGestureRecognizer:tapGesture];
    
   
//    UITabBarController *vc = [[UITabBarController alloc] init];
//    vc.viewControllers = @[vc4, vc5];
//    self.window.rootViewController = vc;
    
//    QDCustomerTabBarController *vc = [[QDCustomerTabBarController alloc] init];
//    vc.viewControllers = @[vc4, vc5];
//    self.window.rootViewController = vc;
    

//    [application setStatusBarHidden:NO];
//    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    return YES;
}

#pragma mark - touch action

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    NSLog(@"你摸我了");
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"TOUCHBEGAN" object:touches];
//}
//
//- (void)panToTheNextViewController:(UIPanGestureRecognizer*)gesture{
//    NSLog(@"window can kown the pan");
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"PANGESTURE" object:gesture];
//}
////判断是否同时识别
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
//    return NO;
//}
//当同时识别时，返回yes自己不识别让其他手势识别，否则，同时识别
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
//    CGPoint point = [gestureRecognizer locationInView:gestureRecognizer.view];
//    if(point.x <= 10)
//        return NO;
//    else
//        return YES;
//}
//
//
//因为手势不同于事件，不参与response chain而 window手势 > superView手势 > view手势 > 事件
//所以当setting界面出来时再让window识别此手势。否则让子视图识别
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
//    if(((UIView*)self.window.rootViewController.view.subviews.lastObject).frame.origin.x == 0)
//        return YES;
//    else
//        return NO;
//}
//
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
//    CGPoint point = [touch locationInView:self.view];
//    
//    if( CGRectContainsPoint(self.pullDownShowView.frame, point)){
//        return NO;
//    }else
//        return YES;
//    
//}
//
//
//- (void)tapTheViewWithWindowReceive:(UITapGestureRecognizer*)gesture{
//    NSLog(@"window can know the tap");
//}
//
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
//    return NO;
//}
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
//    return  NO;
//}



//将会废弃 will be deprecated at some point

//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
//    NSString *text = [[url host] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"打开啦" message:text delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [alertView show];
//    return YES;
//    return NO;
//}

//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
//    NSLog(@"sourceApplication: %@", sourceApplication);
//    NSLog(@"URL scheme:%@", [url scheme]);
//    NSLog(@"URL query:%@", [url query]);
//    
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"打开啦" message:[url query] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [alertView show];
//    return YES;
//
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
