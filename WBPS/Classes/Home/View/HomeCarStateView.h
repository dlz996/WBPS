//
//  HomeCarStateView.h
//  WBPS
//
//  Created by 董立峥 on 2017/10/10.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeCarStateViewDelegate;
@protocol HomeCarStateViewDelegate<NSObject>


/**
 剩余的体积以及重量

 @param volume 体积
 @param weight 重量
 */
- (void)remainingVolume:(NSString *)volume weight:(NSString *)weight;

@end

@interface HomeCarStateView : UIView

@property (nonatomic,weak)id <HomeCarStateViewDelegate> delegate;

@end
