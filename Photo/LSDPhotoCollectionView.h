//
//  LSDPhotoCollectionView.h
//  CloodForSafeHomeSecurity
//
//  Created by ls on 16/6/27.
//  Copyright © 2016年 李辉. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AddPhotoBlock)();

@interface LSDPhotoCollectionView : UICollectionView

///
@property(strong,nonatomic)NSMutableArray *imageArray;

///
@property(copy,nonatomic)AddPhotoBlock addPhotoBlock;

#pragma mark -- 添加图片
-(void)photoCollectionViewAddImage:(UIImage *)image;

-(NSArray *)getAllChosedImageArray;

-(CGSize)calculationCollectionViewHeight;
@end
