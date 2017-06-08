//
//  LSDPhotoCollectionViewCell.m
//  CloodForSafeHomeSecurity
//
//  Created by ls on 16/6/27.
//  Copyright © 2016年 李辉. All rights reserved.
//

#import "LSDPhotoCollectionViewCell.h"

@interface LSDPhotoCollectionViewCell ()

///
@property(weak,nonatomic)UIImageView *imageView;
///
@property(weak,nonatomic)UIImageView *addImageView;

@property(weak,nonatomic)UILabel *label;

///
@property(weak,nonatomic)UILabel *label1;

///
@property(weak,nonatomic)UIButton *deleteBtn;

///
@property(weak,nonatomic)UIImageView *deleteImageView;

@end



@implementation LSDPhotoCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{


    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self setupUI];
    }
    return self;
}

-(void)setupUI
{
    
    UIImageView *imageView = [[UIImageView alloc]init];
    
    [self.contentView addSubview:imageView];
    self.imageView = imageView;
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    UIImageView *addImageView = [[UIImageView alloc]init];
    addImageView.image = [UIImage imageNamed:@"organization_increase"];
    
     [self.imageView addSubview:addImageView];
    [addImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    self.addImageView = addImageView;
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"证明资料";
    label.textColor = [UIColor lsd_ColorWithString:@"D1D1D1"];
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    [self.imageView addSubview:label];
    self.label = label;
    [label mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.imageView);
        make.bottom.equalTo(self.mas_bottom).offset(-15);
        make.height.mas_equalTo(15);
    }];
    UILabel *label1 = [[UILabel alloc]init];
    label1.text = @"(最多3张)";
    label1.textColor = [UIColor lsd_ColorWithString:@"D1D1D1"];
    label1.font = [UIFont systemFontOfSize:12];
    label1.textAlignment = NSTextAlignmentCenter;
    [self.imageView addSubview:label1];
    self.label1 = label1;
    [label1 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.imageView);
        make.bottom.equalTo(self.imageView.mas_bottom);
        make.height.mas_equalTo(15);
    }];
    
    
    UIImageView *deleteImageView = [[UIImageView alloc]init];
    deleteImageView.image = [UIImage imageNamed:@"all_delete"];
    
    [self.imageView addSubview:deleteImageView];
    [deleteImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self.imageView);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    self.deleteImageView = deleteImageView;
    
    UIButton *deletebtn = [[UIButton alloc]init];
    [deletebtn addTarget:self action:@selector(deleteImageBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.deleteBtn = deletebtn;
    [self.contentView addSubview:deletebtn];
   
    [deletebtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
}

-(void)deleteImageBtnClick{

    if ([self.delegate respondsToSelector:@selector(photoCollectionViewCellDidDeleteBtnClickWithIndexPath:)]) {
        [self.delegate photoCollectionViewCellDidDeleteBtnClickWithIndexPath:self.indexPath];
    }
}

-(void)setIconImage:(UIImage *)iconImage
{

    _iconImage = iconImage;
    
    if (iconImage == nil) {
        self.imageView.image = [UIImage imageNamed:@"organization_increase"];
        self.addImageView.hidden = NO;
        self.label.hidden = NO;
        self.label1.hidden = NO;
        self.deleteImageView.hidden = YES;
        self.deleteBtn.hidden = YES;
    
    }else{
  
        self.imageView.image = self.iconImage;
        self.addImageView.hidden = YES;
        self.label.hidden = YES;
        self.label1.hidden = YES;
        self.deleteImageView.hidden = NO;
        self.deleteBtn.hidden = NO;
    }
    
}


@end




















