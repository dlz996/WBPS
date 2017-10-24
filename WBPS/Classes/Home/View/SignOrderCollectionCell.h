//
//  SignOrderCollectionCell.h
//  WBPS
//
//  Created by 董立峥 on 2017/9/29.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SignOrderRemoImageDelegate;
@protocol SignOrderRemoImageDelegate <NSObject>

/**
 移除图片调用的代理方法

 @param indexPath 移除图片下标
 */
- (void)remoImageOf:(NSIndexPath *)indexPath;

@end

@interface SignOrderCollectionCell : UICollectionViewCell
@property (nonatomic,strong)UIImageView * selectImage;
@property (nonatomic,strong)UIButton * remoButton;
@property (nonatomic,assign)NSIndexPath * indexPath;
@property (weak,nonatomic)id <SignOrderRemoImageDelegate> delegate;

@end
