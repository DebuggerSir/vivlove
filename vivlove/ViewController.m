//
//  ViewController.m
//  vivlove
//
//  Created by Skyer God on 2017/12/11.
//  Copyright © 2017年 Skyer God. All rights reserved.
//

#import "ViewController.h"
#import "MainViewController.h"
@interface ViewController ()
@property (nonatomic, copy) NSString *preValue;
@property (nonatomic, copy) NSString *sumValue;

@end

@implementation ViewController
{
    UITextView *textV;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor blackColor];
    //计算数字模块
    UIView *calculatorView = [UIView new];
    calculatorView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:calculatorView];
    
    calculatorView.sd_layout
    .leftEqualToView(self.view)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, autoScaleH(220))
    .bottomEqualToView(self.view);
    
    NSMutableArray *viewsArr = [NSMutableArray array];
    NSArray *titleArr = @[@"AC", @"+/_", @"％", @"÷"
                          ,@"7", @"8", @"9", @"×"
                          ,@"4", @"5", @"6", @"－"
                          ,@"1", @"2", @"3", @"＋"
                          ,@"0", @"", @"·", @"＝"];
    UIImage *image1 = [self imageWithColor:[UIColor lightGrayColor]];
    UIImage *image2 = [self imageWithColor:RGB(240, 153, 56)];
    UIImage *image3 = [self imageWithColor:RGB(51, 51, 51)];
    NSArray *imageArr = @[image1,
                          image2,
                          image3];
    
    CGFloat start_x = autoScaleW(15);
    CGFloat buttonWidth = (kScreenWidth - start_x * 2) / 4;
    CGFloat inset_x = autoScaleW(5);
    
    for (int i = 0; i < 20; i++) {
        if (i == 17) {
            continue;
        }
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [viewsArr addObject:button];
        [calculatorView addSubview:button];
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        button.tag = 100 + i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i != 16) {
            [button setImage:imageArr[2] forState:UIControlStateNormal];
        }
        if (i < 3) {
//            button.backgroundColor = [UIColor lightGrayColor];
            [button setTintColor:[UIColor blackColor]];
            [button setImage:imageArr[0] forState:UIControlStateNormal];
        }
        if ((i + 1) % 4 == 0) {
//            button.backgroundColor = [UIColor brownColor];
            [button setImage:imageArr[1] forState:UIControlStateNormal];
        }
        if (@available(iOS 8.2, *)) {
            button.titleLabel.font = [UIFont systemFontOfSize:35 weight:0];
        } else {
            // Fallback on earlier versions
        }
        
        if (i == 16) {
            button.sd_layout
            .leftSpaceToView(calculatorView, start_x + (i % 4) * buttonWidth + inset_x)
            .topSpaceToView(calculatorView, buttonWidth * (i / 4) + inset_x)
            .widthIs(buttonWidth * 2 - inset_x * 2)
            .heightIs(buttonWidth - inset_x * 2);
            [button setBackgroundImage:imageArr[2] forState:UIControlStateNormal];
            [button setSd_cornerRadiusFromHeightRatio:@(0.5)];
        } else {
            button.sd_layout
            .leftSpaceToView(calculatorView, start_x + (i % 4) * buttonWidth)
            .topSpaceToView(calculatorView, buttonWidth * (i / 4))
            .widthIs(buttonWidth)
            .heightEqualToWidth();
            button.imageView.layer.cornerRadius = kScreenWidth / 5 / 2;
        }
//        [button setSd_cornerRadiusFromHeightRatio:@(0.5)];
        button.imageEdgeInsets = UIEdgeInsetsMake(inset_x, inset_x, inset_x, inset_x);
        button.titleEdgeInsets =UIEdgeInsetsMake(0, -buttonWidth + inset_x * 2, 0, 0);
    }

    
    
    //创建显示面板
    textV = [[UITextView alloc] init];
    textV.editable = NO;
    textV.text = @"0";
    textV.backgroundColor = [UIColor blackColor];
    textV.textColor = [UIColor whiteColor];
    
    
    textV.font = [UIFont systemFontOfSize:60];
    [self.view addSubview:textV];
    
    textV.sd_layout
    .leftSpaceToView(self.view, start_x)
    .rightSpaceToView(self.view, start_x)
    .bottomSpaceToView(calculatorView, start_x)
    .topSpaceToView(self.view, NavigationBarHeight);

    [textV updateLayout];
    textV.textContainerInset = UIEdgeInsetsMake(textV.height_sd - 60, 0, 0, 0);
    textV.textAlignment = NSTextAlignmentRight;
    
    
}
//计算按钮点击事件
/*
 @[@"AC", @"+/_", @"％", @"÷"
 ,@"7", @"8", @"9", @"×"
 ,@"4", @"5", @"6", @"－"
 ,@"1", @"2", @"3", @"＋"
 ,@"0", @"", @"·", @"＝"]
 */
- (void)buttonClick:(UIButton *)sender{
    switch (sender.tag) {
        case 100:
            [self clearNumbersWithAC];
            break;
        case 101:
            [self changeNumberTag];
            break;
        case 102:
            [self percentChar];
            break;
        case 103:
            [self changeNumberTag];
            break;
        case 107:
            [self changeNumberTag];
            break;
        case 111:
            [self changeNumberTag];
            break;
        case 115:
            [self changeNumberTag];
            break;
        case 119:
            [self changeNumberTag];
            break;
        case 118:
            [self pointMethod];
            break;
        default:
            [self inputNumber:sender.titleLabel.text];
            break;
    }
}
//输入数字
- (void)inputNumber:(NSString *)number{
    if (_preValue) {

    }
    if ([textV.text integerValue] == 0) {
        textV.text = number;
    } else {
        textV.text = [textV.text stringByAppendingString:number];
    }
}
//小数点点击
- (void)pointMethod{
    if (![textV.text containsString:@"."]) {
        textV.text = [textV.text stringByAppendingString:@"."];
    }
}
//AC清空数据
-(void)clearNumbersWithAC{
    textV.text = @"0";
    _preValue = @"0";
    _sumValue = @"0";
}
//正负号切换
- (void)changeNumberTag{
    textV.text = [NSString stringWithFormat:@"%lf", -[textV.text doubleValue]];
}
//%
- (void)percentChar{
    if ([textV.text isEqualToString:@"195"]) {
        //密码正确，跳转页面
        MainViewController *root = [[MainViewController alloc] init];
        [UIApplication sharedApplication].keyWindow.rootViewController = [[UINavigationController alloc] initWithRootViewController:root];
    }
    textV.text = [NSString stringWithFormat:@"%lf", [textV.text doubleValue] * 0.01];
}
//除法
- (void)divisionMethod{
    _preValue = textV.text;
}
//乘法
- (void)mulitMethod{
    
}
//
/**<
 *  @author GodSkyer, 2017-10-20
 *
 *  根据颜色动态生成图片
 */
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, kScreenWidth / 5, kScreenWidth / 5);
    //根据矩形画带圆角的曲线
//    CGContextAddPath(UIGraphicsGetCurrentContext(), [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:0.5].CGPath);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage *imgae = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imgae;
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
