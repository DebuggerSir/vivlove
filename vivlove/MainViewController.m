//
//  MainViewController.m
//  vivlove
//
//  Created by Skyer God on 2017/12/12.
//  Copyright © 2017年 Skyer God. All rights reserved.
//

#import "MainViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <TZImagePickerController.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import <TZImageManager.h>
#import <TZAssetModel.h>
#import <TZVideoPlayerController.h>
#import "ZTAssetHandleTool.h"
#import "CoreDataManage.h"
#import "Video+CoreDataProperties.h"
#import "ZTFilesManager.h"
@interface MainViewController ()<UITableViewDelegate, UITableViewDataSource, TZImagePickerControllerDelegate>
@property (nonatomic, strong) UITableView *tableV;
@end

@implementation MainViewController
{
    NSMutableArray *sourcesArr;
}
-(UITableView *)tableV{
    if (_tableV == nil) {
        _tableV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableV.backgroundColor = [UIColor whiteColor];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        [self.view addSubview:_tableV];
        _tableV.tableFooterView = [UIView new];
        _tableV.sd_layout
        .leftSpaceToView(self.view, 0)
        .rightSpaceToView(self.view, 0)
        .topSpaceToView(self.view, 0)
        .bottomSpaceToView(self.view, TabBarHeight);
    }
    
    return _tableV;
}
- (void)createBottomBarView{
    UIToolbar *bottomBarV = [[UIToolbar alloc] init];
    bottomBarV.backgroundColor = RGB(67, 186, 189);
    bottomBarV.tintColor = [UIColor whiteColor];
    [self.view addSubview:bottomBarV];
    bottomBarV.sd_layout
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .bottomEqualToView(self.view)
    .heightIs(TabBarHeight);
    
    
    NSArray *imagesArr = @[@"add", @"files", @"wifi"];
    NSMutableArray *buttonArr = [NSMutableArray array];
    CGFloat buttonWidth =  kScreenWidth / 3;
    for (NSInteger i = 0; i < imagesArr.count; i++) {
        UIBarButtonItem *buton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:imagesArr[i]] style:UIBarButtonItemStyleDone target:self action:@selector(buttonClick:)];
        buton.tag = 200 + i;
        if (i == 0) {
            buton.imageInsets = UIEdgeInsetsMake(0, 0, 0, buttonWidth - 40);
        }
        [buton setWidth:buttonWidth];
        [buttonArr addObject:buton];
    }
    bottomBarV.items = [buttonArr copy];
    
}
-(void)buttonClick:(UIBarButtonItem *)sender{
    

    switch (sender.tag) {
        case 200:
        {
            //相册
            TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initWithMaxImagesCount:10 delegate:self];
            imagePicker.allowPickingMultipleVideo = YES;
            imagePicker.allowPickingImage = NO;
            [[TZImageManager manager] setPhotoWidth:100];
            [imagePicker setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                if (assets.count > 0) {
                    [assets enumerateObjectsUsingBlock:^(id  _Nonnull phAsset, NSUInteger idx, BOOL * _Nonnull stop) {
                        [ZTAssetHandleTool getVideoFromPHAsset:phAsset needMetaData:YES Complete:^(NSData *fileData, NSString *fileName, NSString *filePath, PHAssetResource *pHAssetResource) {
                            ZTLog(@"%@", pHAssetResource);
                            [CoreDataManage inserDataWith_CoredatamodelClass:[Video class] CoredataModel:^(Video *model) {
                                NSString *fileUrl = [ZTFilesManager createLibraryPathWithExtension:[NSString stringWithFormat:@"Video/%@", fileName]];
                                [model.fileData writeToFile:fileUrl atomically:YES];
                                model.filePath = filePath;
                                model.fileUrl = fileUrl;
                                model.fileName = fileName;
                                model.coverImage = photos[idx];
                            } Error:^(NSError *error) {
                                
                            }];
                        }];
                    }];
                    [self lookupVideoInfo];
                }
            }];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:imagePicker animated:YES completion:^{
                
            }];
        }
            break;
        case 201:
            
            break;
        case 202:
            
            break;
            
        default:
            break;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[CoreDataManage shareCoreDataDB] createCoredataDB:@"CoreDataModel"];
    
    [self createBottomBarView];
    
    [self lookupVideoInfo];
    
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return sourcesArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cells"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"cells"];
    }
//   TZAssetModel *model = [TZAssetModel modelWithAsset:sourcesArr[indexPath.row] type:TZAssetModelMediaTypeVideo];
//    [[TZImageManager manager] getPhotoWithAsset:model.asset completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
//        cell.imageView.image = photo;
//    }];
    Video *model = sourcesArr[indexPath.row];
    cell.imageView.image = (UIImage *)model.coverImage;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = model.fileName;
    cell.detailTextLabel.text = model.fileUrl;
    return cell;
}
- (void)lookupVideoInfo{
    [CoreDataManage selectDataWith_CoredatamoldeClass:[Video class] where:nil Alldata_arr:^(NSArray *coredataModelArr) {
        sourcesArr = [NSMutableArray arrayWithArray:coredataModelArr];
        [self.tableV reloadData];
        if (coredataModelArr.count > 0) {
            Video *model = coredataModelArr[0];
            ZTLog(@"%@,\n path - %@ \n data - %@", model.fileName, model.filePath, model.fileUrl);
        }
    } Error:^(NSError *error) {
        
    }];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TZAssetModel *model = [TZAssetModel modelWithAsset:sourcesArr[indexPath.row] type:TZAssetModelMediaTypeVideo];
//    TZVideoPlayerController *vc = [[TZVideoPlayerController alloc] init];
//    vc.model = model;
//    [self presentViewController:vc animated:YES completion:nil];

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
