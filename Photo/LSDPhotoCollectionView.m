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

#define KPhotoCollectionViewItemW  (ScreenWidth - 20 - itemMargin*2) / 3

static NSString *LSDPhotoCollectionViewReuseIdentifier = @"LSDPhotoCollectionViewReuseIdentifier";
@interface LSDPhotoCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate>

///
@property(strong,nonatomic)UICollectionViewFlowLayout *flowLayout;

@end

@implementation LSDPhotoCollectionView

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
    CGFloat itemWidth = (ScreenWidth - 20 - itemMargin*2) / 3;

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
    
    return cell;
    
}

#pragma mark -- delegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row == self.imageArray.count) {
        if (self.addPhotoBlock) {
            self.addPhotoBlock();
        }
    }

}

#pragma mark -- 添加图片
-(void)photoCollectionViewAddImage:(UIImage *)image
{
    
    if (self.imageArray.count > 2) {
        
        [MBProgressHUD lsd_showMessag:@"最多支持三张截图" toView:self dimBackground:NO];
        return;
    }
    
    [self.imageArray addObject:image];
    
    [self reloadData];
    
}

-(NSArray *)getAllChosedImageArray
{
    return [_imageArray copy];
}


-(CGSize)calculationCollectionViewHeight
{
    CGFloat height = 0;
    if (self.imageArray.count  <= 2) {
        height = KPhotoCollectionViewItemW + 1;
    }else
    {
        height = KPhotoCollectionViewItemW * (self.imageArray.count / 3 + 1) + itemMargin *(self.imageArray.count / 3);
    }
    
    return CGSizeMake(ScreenWidth - 20, height);
    
}

@end














