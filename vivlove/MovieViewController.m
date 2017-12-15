//
//  MovieViewController.m
//  vivlove
//
//  Created by Skyer God on 2017/12/15.
//  Copyright © 2017年 Skyer God. All rights reserved.
//

#import "MovieViewController.h"
#import <ZFPlayer.h>
@interface MovieViewController ()<ZFPlayerDelegate>
@property (weak, nonatomic) IBOutlet UIView *playerFatherView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) ZFPlayerView *playerView;

@property (nonatomic, strong) ZFPlayerModel *playerModel;

@end

@implementation MovieViewController
- (ZFPlayerModel *)playerModel {
    if (!_playerModel) {
        _playerModel                  = [[ZFPlayerModel alloc] init];
        _playerModel.title            = _videoModel.fileName;
        _playerModel.videoURL         = [NSURL fileURLWithPath:_videoModel.fileUrl isDirectory:YES];
        _playerModel.placeholderImage =(UIImage *)_videoModel.coverImage;
        _playerModel.fatherView       = self.playerFatherView;
    }
    return _playerModel;
}

- (ZFPlayerView *)playerView {
    if (!_playerView) {
        _playerView = [[ZFPlayerView alloc] init];
        
        /*****************************************************************************************
         *   // 指定控制层(可自定义)
         *   // ZFPlayerControlView *controlView = [[ZFPlayerControlView alloc] init];
         *   // 设置控制层和播放模型
         *   // 控制层传nil，默认使用ZFPlayerControlView(如自定义可传自定义的控制层)
         *   // 等效于 [_playerView playerModel:self.playerModel];
         ******************************************************************************************/
        [_playerView playerControlView:nil playerModel:self.playerModel];
        
        // 设置代理
        _playerView.delegate = self;
        
        //（可选设置）可以设置视频的填充模式，内部设置默认（ZFPlayerLayerGravityResizeAspect：等比例填充，直到一个维度到达区域边界）
        //         _playerView.playerLayerGravity = ZFPlayerLayerGravityResize;
        
        // 打开下载功能（默认没有这个功能）
        _playerView.hasDownload    = NO;
        _playerView.hasPreviewView = YES;
        
        // 打开预览图
        self.playerView.hasPreviewView = YES;
        
    }
    return _playerView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.playerView autoPlayTheVideo];
}
- (IBAction)backClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)zf_playerControlViewWillShow:(UIView *)controlView isFullscreen:(BOOL)fullscreen {
    self.backButton.hidden = YES;
    
    [UIView animateWithDuration:0.25 animations:^{
        
    }];
}

- (void)zf_playerControlViewWillHidden:(UIView *)controlView isFullscreen:(BOOL)fullscreen {
    self.backButton.hidden = YES;
    [UIView animateWithDuration:0.25 animations:^{
        
    }];
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
