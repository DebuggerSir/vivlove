//
//  BaseViewController.h
//  CodoonWallet
//
//  Created by Skyer God on 2017/10/19.
//  Copyright © 2017年 God Skyer. All rights reserved.
//

#import <UIKit/UIKit.h>
//此基类只适合含有导航栏的控制器，并且模态弹出导航栏控制器不含返回标题。
//设置控制器标题 可用self.title 或者self.titleView.text,不能使用self.navigationController.navigationBar.title
@interface BaseViewController : UIViewController
//如果模态弹出也要显示，需要模态导航栏控制器
@property (nonatomic, strong) UIButton *leftBarItem;
/** 右边导航   (strong) **/
@property (nonatomic, strong) UIButton *rightBarItem;
/** 标题   (strong) **/
@property (nonatomic, strong) UILabel * titleView;
/**<
 *  @author GodSkyer, 修改时间
 *
 *  默认为YES， 显示，需要修改改为NO，不显示
 */
@property (nonatomic, assign) BOOL hideBackTitle;
/**
 *  @author GodSkyer, 2017-10-21
 *  功能:  用于修改导航栏颜色
 *  描述:  默认色 为蓝色
 *  @param <#参数#> <#参数描述#>
 */
@property (nonatomic, strong) UIColor *customNaviBarColor;
/** 是否需要设计导航栏为透明状态 **/
@property (nonatomic, assign) BOOL needNavigationBarOpaque;
/** 左边导航action **/
- (void)leftBarButtonItemAction;
//右边按钮方法
- (void)rightBarButtonItemAction:(UIButton *)sender;
@end
