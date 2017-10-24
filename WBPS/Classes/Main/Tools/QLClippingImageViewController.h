//
//  QLClippingImageViewController.h
//  QiongLiao
//
//  Created by appleKaiFa on 16/7/20.
//  Copyright © 2016年 XQBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QLClippingImageViewController;
typedef enum{
    CIRCULARCLIP   = 0,   //圆形裁剪
    SQUARECLIP            //方形裁剪
    
}ClipType;

@protocol ClipViewControllerDelegate <NSObject>

-(void)ClipViewController:(QLClippingImageViewController *)clipViewController FinishClipImage:(UIImage *)editImage;

@end

@interface QLClippingImageViewController : UIViewController<UIGestureRecognizerDelegate>
{
    UIImageView *_imageView;
    UIImage *_image;
    UIView * _overView;
    UIView * _imageViewScale;
    
    CGFloat lastScale;
}
@property (nonatomic, assign)CGFloat scaleRation;//图片缩放的最大倍数
/**圆形裁剪框的半径*/
@property (nonatomic, assign)CGFloat radius;
/**矩形裁剪框*/
@property (nonatomic, assign)CGRect rectangleFrame;
@property (nonatomic, assign)CGRect OriginalFrame;
@property (nonatomic, assign)CGRect currentFrame;
/**是否是拍照截取*/
@property (nonatomic, assign)BOOL isCamera;


@property (nonatomic, assign)ClipType clipType;  //裁剪的形状
@property (nonatomic, strong)id<ClipViewControllerDelegate>delegate;

-(instancetype)initWithImage:(UIImage *)image;

@end
