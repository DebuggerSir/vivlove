//
//  BaseViewController.m
//  CodoonWallet
//
//  Created by Skyer God on 2017/10/19.
//  Copyright © 2017年 God Skyer. All rights reserved.
//

#import "BaseViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "LeftSlideView.h"
#define defalutNavigationBarColor RGB(59, 138, 247)
@interface BaseViewController ()
/**  存储push的历史页面标题  **/
@property (nonatomic, strong) NSMutableArray *titlesArr;
@end

@implementation BaseViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (!_needNavigationBarOpaque) {
        [self handleNavigationBarColor];
    }
    [self setNavigationView];
    if (self.navigationController.viewControllers.count == 1 && !self.presentingViewController) {
        _leftBarItem.hidden = YES;
    } else {
        _leftBarItem.hidden = NO;
    }
}
#pragma mark ---- viewDidLoad -----------
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.rightBarItem setTitle:@"slide" forState:UIControlStateNormal];
//    self.hideBackTitle = YES;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
-(UIStatusBarAnimation)preferredStatusBarUpdateAnimation{
    return UIStatusBarAnimationSlide;
}
//处理导航栏颜色
- (void)handleNavigationBarColor{
    UIImage *nilImage = [self imageWithColor: _customNaviBarColor ?_customNaviBarColor: defalutNavigationBarColor];
    [self.navigationController.navigationBar setBackgroundImage:nilImage forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = nilImage;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    [self setNeedsStatusBarAppearanceUpdate];
    self.navigationController.navigationBar.barTintColor = _customNaviBarColor ?_customNaviBarColor: defalutNavigationBarColor;
}
#pragma mark -- 初始化导航栏 ------
/**<
 *  @author GodSkyer, 2017-10-20
 *
 *  初始化导航栏设置
 */
- (void)setNavigationView{
    
    self.leftBarItem.tintColor = [UIColor whiteColor];
    //处理跳转逻辑
    [self pushAndPopViewControllerHandle];
    
    // 判断条件为2 ： 为了去除window.rootVC 和  模态弹出的情况
    if (_titlesArr.count >= 2 && !_hideBackTitle) {
        [self.leftBarItem setTitle:_titlesArr[_titlesArr.count - 2] forState:UIControlStateNormal];
    }
    
}
-(void)setCustomNaviBarColor:(UIColor *)customNaviBarColor{
    _customNaviBarColor = customNaviBarColor;
}
#pragma mark --  处理页面跳转逻辑 --
/**<
 *  @author GodSkyer, 2017-10-20
 *
 *  push 和 pop。以及模态跳转页面的逻辑处理
 */
- (void)pushAndPopViewControllerHandle{
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    
    if (!self.leftBarItem.isHidden) {
        [self.navigationController.navigationBar addGestureRecognizer:tapGR];
    }
    NSArray *naviArr = self.navigationController.viewControllers;
    if (naviArr.count == 1) {
        //为1 说明是present
        [[NSUserDefaults standardUserDefaults] setObject:@[] forKey:@"_titlesArr"];
    }
    self.titlesArr = [[[NSUserDefaults standardUserDefaults] objectForKey:@"_titlesArr"] mutableCopy];
    if (naviArr.count == _titlesArr.count) {
        //pop 连续pop
    } else if (_titlesArr.count <= naviArr.count) {
        //push 连续
        if (self.titleView.text == nil || [self.titleView.text isEqualToString:@""]) {
            [self.titlesArr addObject:@"返回"];
        } else {
            [self.titlesArr addObject:self.titleView.text];
        }
        
    } else {
        if (naviArr == nil || _titlesArr.count == 0) {
            //present 模态弹出
        } else {
            //jump push。跨跃性pop
            [self.titlesArr removeObjectsInRange:NSMakeRange(naviArr.count - 1, _titlesArr.count - naviArr.count)];
        }
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:_titlesArr forKey:@"_titlesArr"];
    //    ZTLog(@"%@", [_titlesArr componentsJoinedByString:@","]);
    
}
/**<
 *  @author GodSkyer, 修改时间
 *
 *  左边按钮点击
 */
- (void)leftBarButtonItemAction{
    [self.navigationController popViewControllerAnimated:YES];
    [_titlesArr removeLastObject];
    [[NSUserDefaults standardUserDefaults] setObject:_titlesArr forKey:@"_titlesArr"];
}
/**<
 *  @author GodSkyer, 修改时间
 *
 *  右边按钮点击
 */
- (void)rightBarButtonItemAction:(UIButton *)sender{
    LeftSlideView *leftView = [[LeftSlideView alloc] init];
    [leftView showView];
}
/**<
 *  @author GodSkyer, 2017-10-20
 *
 *  保存push过来的页面标题，用于展示在返回键上
 */
-(NSMutableArray *)titlesArr{
    if (!_titlesArr) {
        _titlesArr = [NSMutableArray array];
    }
    return _titlesArr;
}
/**<
 *  @author GodSkyer, 修改时间
 *
 *  中间标题
 */
-(UILabel *)titleView{
    if (_titleView == nil) {
        _titleView = [[UILabel alloc]init];
        _titleView.frame = CGRectMake(0, 0, 80, 30);
        _titleView.textAlignment = NSTextAlignmentCenter;
        _titleView.font = [UIFont systemFontOfSize:18];
        
        _titleView.textColor = [UIColor whiteColor];
        _titleView.adjustsFontSizeToFitWidth = YES;
        self.navigationItem.titleView = _titleView;
    }
    return _titleView;
}
/**<
 *  @author GodSkyer, 修改时间
 *
 *  是否展示返回键文字展示
 */
-(void)setHideBackTitle:(BOOL)hideBackTitle{
    _hideBackTitle = hideBackTitle;
}
/**<
 *  @author GodSkyer, 修改时间
 *
 *  当设置系统的self.title时，赋值给_titleView.text
 */
-(void)setTitle:(NSString *)title{
    self.titleView.text = title;
}
/**<
 *  @author GodSkyer, 修改时间
 *
 *  导航栏返回键
 */
-(UIButton *)leftBarItem{
    if (!_leftBarItem) {
        _leftBarItem = [UIButton buttonWithType:UIButtonTypeSystem];
        _leftBarItem.tintColor = [UIColor whiteColor];
        _leftBarItem.titleLabel.font = [UIFont systemFontOfSize:17];
        _leftBarItem.imageEdgeInsets = UIEdgeInsetsMake(0, -7, 0, 0);
        [_leftBarItem setImage:[UIImage imageNamed:@"backArrowIcon"] forState:UIControlStateNormal]; //backArrowIcon
        
        _leftBarItem.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_leftBarItem addTarget:self action:@selector(leftBarButtonItemAction) forControlEvents:UIControlEventTouchUpInside];
        _leftBarItem.frame = CGRectMake(0, 7, 100, 44);
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_leftBarItem];

    }
    return _leftBarItem;
}
/**<
 *  @author GodSkyer, 2017-10-20
 *  手势响应
 *  模拟返回键全范围点击返回
 */
- (void)tapClick:(UITapGestureRecognizer *)tapGR {
    if (_leftBarItem.hidden) {
        return;
    }
    CGRect rect = CGRectMake(0, 0, 30, 44);
    CGPoint point = [tapGR locationInView:self.navigationController.navigationBar];
    if (CGRectContainsPoint(rect, point)) {
        [self performSelector:@selector(leftBarButtonItemAction) withObject:_leftBarItem];
    }
}
/**<
 *  @author GodSkyer, 修改时间
 *
 *  导航栏右边键
 */
-(UIButton *)rightBarItem{
    if (!_rightBarItem) {
        _rightBarItem = [UIButton buttonWithType:UIButtonTypeCustom];
        //    [_rightBarItem setImage:[UIImage imageNamed:@"排序"] forState:UIControlStateNormal];
        _rightBarItem.frame = CGRectMake(0, 7, 100, 30);
        [_rightBarItem addTarget:self action:@selector(rightBarButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
        _rightBarItem.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightBarItem];
    }
    return _rightBarItem;
}
/**<
 *  @author GodSkyer, 2017-10-20
 *
 *  是否需要导航栏透明。默认为NO，不投明
 */
- (void)setNeedNavigationBarOpaque:(BOOL)needNavigationBarOpaque{
    _needNavigationBarOpaque = needNavigationBarOpaque;
    
    if (_needNavigationBarOpaque) {
        UIImage *nilImage = [self imageWithColor:[UIColor clearColor]];
        [self.navigationController.navigationBar setBackgroundImage:nilImage forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.shadowImage = nilImage;
    } else {
        
    }
}
/**<
 *  @author GodSkyer, 2017-10-20
 *
 *  根据颜色动态生成图片
 */
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage *imgae = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imgae;
}
- (BOOL)willDealloc{
    return NO;
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
