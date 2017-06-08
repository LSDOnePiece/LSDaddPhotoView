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
@property(strong,nonatomic)UIImageView *imageView;

///
@property(strong,nonatomic)UIImageView *addImageView;

@property(weak,nonatomic)UILabel *label;

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
    
    [self addSubview:imageView];
    self.imageView = imageView;
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    UIImageView *addImageView = [[UIImageView alloc]init];
    addImageView.image = [UIImage imageNamed:@"形状-11"];
    [addImageView sizeToFit];
     [self.imageView addSubview:addImageView];
    [addImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.imageView.center);
    }];
    self.addImageView = addImageView;
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"图片";
    label.textColor = [UIColor colorWithRed:27.0/255.0 green:150.0/255.0 blue:214.0/255.0 alpha:1.0];
    [label sizeToFit];
    [self.imageView addSubview:label];
    self.label = label;
    [label mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.imageView.mas_centerX);
        make.centerY.mas_equalTo(self.imageView.mas_centerY).offset(-25 *SCREEN_WIDTH_RATIO4);
    }];
    
 
}

-(void)setIconImage:(UIImage *)iconImage
{

    _iconImage = iconImage;
    
    if (iconImage == nil) {
        self.imageView.image = [UIImage imageNamed:@"圆角矩形-1"];
        self.addImageView.hidden = NO;
        self.label.hidden = NO;
        
    }else{
  
        self.imageView.image = self.iconImage;
        self.addImageView.hidden = YES;
        self.label.hidden = YES;
    }
    
}


@end




















