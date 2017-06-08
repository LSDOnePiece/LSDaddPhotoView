//
//  LSDPhotoCollectionView.m
//  CloodForSafeHomeSecurity
//
//  Created by ls on 16/6/27.
//  Copyright © 2016年 李辉. All rights reserved.
//

#import "LSDPhotoCollectionView.h"
#import "LSDPhotoCollectionViewCell.h"

CGFloat itemMargin = 10.0;

#define KPhotoCollectionViewItemW  (ScreenWidth - 30 - itemMargin*2) / 3

static NSString *LSDPhotoCollectionViewReuseIdentifier = @"LSDPhotoCollectionViewReuseIdentifier";
@interface LSDPhotoCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,LSDPhotoCollectionViewCellDelegate>

///
@property(strong,nonatomic)UICollectionViewFlowLayout *flowLayout;

@end

@implementation LSDPhotoCollectionView

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{

    if (self = [super initWithCoder:aDecoder]) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        self.flowLayout = flowLayout;
        self.backgroundColor = [UIColor whiteColor];
        [self setupCollectionView];
    }
    return self;
}


-(instancetype)initWithFrame:(CGRect)frame
{

    if (self = [super initWithFrame:frame]) {
    self = [self initWithFrame:frame collectionViewLayout:self.flowLayout];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.flowLayout = flowLayout;
    if (self = [super initWithFrame:frame collectionViewLayout:flowLayout]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self setupCollectionView];
    }
    return self;
}

-(void)setupCollectionView
{
 
    _imageArray = [NSMutableArray array];
    
    WeakSelf(wself);
    wself.dataSource = self;
    wself.delegate = self;
    
    [self registerClass:[LSDPhotoCollectionViewCell class] forCellWithReuseIdentifier:LSDPhotoCollectionViewReuseIdentifier];
    self.showsVerticalScrollIndicator = NO;
    ///不能滚动
    self.scrollEnabled = NO;
}

-(void)layoutSubviews
{

    [super layoutSubviews];
    CGFloat itemWidth = (ScreenWidth - 30 - itemMargin*2) / 3;

    self.flowLayout.itemSize = CGSizeMake(itemWidth - 1, itemWidth - 1);
    self.flowLayout.minimumLineSpacing = 0;
    self.flowLayout.minimumInteritemSpacing = 0;

  
}

#pragma mark -- dataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    NSInteger count = self.imageArray.count == 0? 1 :  self.imageArray.count + 1;
   
    return count;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    LSDPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LSDPhotoCollectionViewReuseIdentifier forIndexPath:indexPath];

    if (indexPath.item == self.imageArray.count) {
        cell.iconImage = nil;
    }else
    {
        cell.iconImage = self.imageArray[indexPath.row];
    }
    cell.delegate = self;
    cell.indexPath = indexPath;
    return cell;
    
}

#pragma mark -- delegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row == self.imageArray.count) {

        UIImagePickerController* picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        
        
        if([[[UIDevice
              currentDevice] systemVersion] floatValue]>=8.0) {
            
            [self getCurrentVC].modalPresentationStyle=UIModalPresentationOverCurrentContext;
            
        }
        
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                
                [ITTPromptView showMessage:@"相机不可用,请检查相机!"];
                return;
            }
            picker.sourceType = sourceType;
            [[self getCurrentVC] presentViewController:picker animated:YES completion:nil];
        }];
        
        [alertView addAction:action1];
        
        UIAlertAction *action2  = [UIAlertAction actionWithTitle:@"从手机相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            [[self getCurrentVC] presentViewController:picker animated:YES completion:nil];
        }];
        
        [alertView addAction:action2];
        
        
        UIAlertAction *action3  = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertView addAction:action3];
        
        [[self getCurrentVC] presentViewController:alertView animated:YES completion:nil];

    }

}


-(NSArray *)getAllChosedImageArray
{
    return [_imageArray copy];
}


-(CGSize)calculationCollectionViewHeight
{
    
    LSDLog(@"self.imageArray.count === %zd",self.imageArray.count);
    
    CGFloat height = 0;
    if (self.imageArray.count  <= 2) {
        height = KPhotoCollectionViewItemW + 1;
    }else
    {
        if (self.imageArray.count == self.MaxAddImageCount) {
           height = KPhotoCollectionViewItemW * (self.imageArray.count / 3 );
        }else{
           height = KPhotoCollectionViewItemW * (self.imageArray.count / 3 + 1) + itemMargin *(self.imageArray.count / 3);
        }
       
    }
    
    return CGSizeMake(ScreenWidth - 20, height);
    
}

#pragma mark -- UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
   
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    if (self.imageArray.count == self.MaxAddImageCount) {
        
        [ITTPromptView showMessage:[NSString stringWithFormat:@"最多添加%zd张照片",self.MaxAddImageCount]];
        return;
    }
    
    [self.imageArray addObject:image];
    
    [self reloadData];
    
    if (self.addPhotoBlock) {
        self.addPhotoBlock();
    }
    
    
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark --LSDPhotoCollectionViewCellDelegate
-(void)photoCollectionViewCellDidDeleteBtnClickWithIndexPath:(NSIndexPath *)indexPath{

    [self.imageArray removeObjectAtIndex:indexPath.item];
    
    [self reloadData];
}
@end














