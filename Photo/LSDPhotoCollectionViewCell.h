//
//  LSDPhotoCollectionViewCell.h
//  CloodForSafeHomeSecurity
//
//  Created by ls on 16/6/27.
//  Copyright © 2016年 李辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LSDPhotoCollectionViewCellDelegate <NSObject>
@optional
-(void)photoCollectionViewCellDidDeleteBtnClickWithIndexPath:(NSIndexPath *)indexPath;

@end

@interface LSDPhotoCollectionViewCell : UICollectionViewCell

///
@property(strong,nonatomic)UIImage *iconImage;
///
@property(weak,nonatomic)id<LSDPhotoCollectionViewCellDelegate> delegate;

///
@property(strong,nonatomic)NSIndexPath *indexPath;

@end
