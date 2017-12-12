//
//  LeftSlideView.m
//  vivlove
//
//  Created by Skyer God on 2017/12/12.
//  Copyright © 2017年 Skyer God. All rights reserved.
//

#import "LeftSlideView.h"
#define selfOffset 170
#define selfWidth (kScreenWidth - selfOffset)
@interface LeftSlideView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableV;
@property (nonatomic, strong) UIView *maskView;
@end

@implementation LeftSlideView
{
    NSArray *imageArr;
}
-(instancetype)init{
    self = [super init];
    if (self) {
       
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
        
        [window addGestureRecognizer:panGR];
        _maskView = [[UIView alloc] initWithFrame:window.bounds];
        [window addSubview:_maskView];
        _maskView.backgroundColor = RGBA(0, 0, 0, 0.5);
        [_maskView addSubview:self];
         self.frame = CGRectMake(-selfWidth, 0, selfWidth , kScreenHeight);
        [self createView];
    }
    return self;
}
-(UITableView *)tableV{
    if (!_tableV) {
        _tableV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableV.backgroundColor = RGBA(82, 93, 144, 1);
        _tableV.delegate = self;
        _tableV.dataSource = self;
        [self addSubview:_tableV];
    }
    return _tableV;
}
- (void)createView{
    self.tableV.separatorInset =UIEdgeInsetsZero;
    self.tableV.frame = self.bounds;
    imageArr = @[@"相册", @"视频", @"压缩", @"设置"];
    
}
- (void)panAction:(UIPanGestureRecognizer *)panGR{
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return imageArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 220;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor cyanColor];
    
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.image = [UIImage imageNamed:@"视频"];
    [backView addSubview:imageV];
    imageV.sd_layout
    .centerXEqualToView(backView)
    .topSpaceToView(backView, NavigationBarHeight)
    .widthIs(80)
    .heightEqualToWidth();
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"vivlove.com";
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:titleLabel];
    
    titleLabel.sd_layout
    .centerXEqualToView(backView)
    .topSpaceToView(imageV, 10)
    .heightIs(30);
    [titleLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    
    return backView;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    cell.imageView.image = [UIImage imageNamed:imageArr[indexPath.row]];
    cell.textLabel.text = imageArr[indexPath.row];
    
    return cell;
}


- (void)showView{
    self.hidden = NO;
    self.frame = CGRectMake(-selfWidth, 0, selfWidth, kScreenHeight);
//    [_maskView bringSubviewToFront:self];
    [UIView animateWithDuration:.35 delay:0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        
    } completion:^(BOOL finished) {
        self.frame = CGRectMake(0, 0, selfWidth, kScreenHeight);
    }];
}

- (void)hiddenView{
    
    self.frame = CGRectMake(0, 0, selfWidth, kScreenHeight);
    [UIView animateWithDuration:.35 delay:0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        self.frame = CGRectMake(-selfWidth, 0, selfWidth, kScreenHeight);
    } completion:^(BOOL finished) {
        if (finished) {
            self.hidden = YES;
        }
    }];
}
@end
