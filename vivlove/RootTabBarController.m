//
//  RootTabBarController.m
//  CodoonWallet
//
//  Created by Skyer God on 2017/11/3.
//  Copyright © 2017年 God Skyer. All rights reserved.
//

#import "RootTabBarController.h"

@interface RootTabBarController ()<UITabBarDelegate, UITabBarControllerDelegate>
{
    NSInteger _currentIndex;
}

@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initViewControllers];
}
- (void)initViewControllers{
    //初始化tablebar个数
    NSMutableArray *arrTitle = [NSMutableArray arrayWithArray:@[@"首页", @"钱包", @"分享", @"我的"]];
    //图标
    NSMutableArray *arrBarIcon = [NSMutableArray arrayWithArray:@[@"home_barIcon",@"wallet_barIcon",@"share_barIcon",@"my_barIcon"]];
    //vc个数
    NSMutableArray *arrClass = [NSMutableArray arrayWithArray:@[@"HomePageViewController", @"WalletViewController",@"ShareViewController", @"MyViewController"]];
    NSMutableArray *arrNC = [NSMutableArray array];
    for (int i = 0; i < arrClass.count; i++) {
        Class className = NSClassFromString(arrClass[i]);
        if (className) {
            UIViewController *viewController = [[[className class] alloc]init];
            UINavigationController *naviController = [[UINavigationController alloc] initWithRootViewController:viewController];
            
            naviController.title = arrTitle[i];
            [naviController.tabBarItem setImage:[UIImage imageNamed:arrBarIcon[i]]];
            [arrNC addObject:naviController];
        }
    }
    self.viewControllers = [arrNC mutableCopy];
    self.delegate = self;
}

#pragma mark -- 代理方法 --
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    //点击tabBarItem动画
    if (self.selectedIndex != _currentIndex)[self tabBarButtonClick:[self getTabBarButton]];
}
- (UIControl *)getTabBarButton{
    
    NSMutableArray *tabBarButtons = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (UIView *tabBarButton in self.tabBar.subviews) {
        
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButtons addObject:tabBarButton];
        }
    }
    
    UIControl *tabBarButton = [tabBarButtons objectAtIndex:self.selectedIndex];
    
    return tabBarButton;
}

- (void)tabBarButtonClick:(UIControl *)tabBarButton
{
    for (UIView *imageView in tabBarButton.subviews) {
        
        if ([imageView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
            //需要实现的帧动画,这里根据需求自定义
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
            
            animation.keyPath = @"transform.scale";
            animation.values = @[@1.0,@1.1,@0.9,@1.0];
            animation.duration = 0.3;
            animation.calculationMode = kCAAnimationCubic;
            //把动画添加上去就OK了
            [imageView.layer addAnimation:animation forKey:nil];
            
        }
    }
    _currentIndex = self.selectedIndex;
}

@end
