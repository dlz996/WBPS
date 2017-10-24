//
//  UINavigationBar+Extension.m
//  QiongLiao
//
//  Created by 董立峥 on 15/9/10.
//  Copyright (c) 2015年 WBKJ. All rights reserved.
//

#import "UINavigationBar+Extension.h"

@implementation UINavigationBar (Extension)
- (void)setNavigationBarBottomLineHidden:(BOOL)hidden {
    if ([self respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)])
    {
        
        NSArray *list=self.subviews;
        for (id obj in list){
            if ([UIDevice currentDevice].systemVersion.floatValue >= 10.0)
            {//10.0的系统字段不一样
                UIView *view = (UIView*)obj;
                for (id obj2 in view.subviews) {
                    
                    if ([obj2 isKindOfClass:[UIImageView class]])
                    {
                        
                        UIImageView *image =  (UIImageView*)obj2;
                        image.hidden = YES;
                    }
                }
            }else{
                if ([obj isKindOfClass:[UIImageView class]]) {
                    UIImageView *imageView=(UIImageView *)obj;
                    NSArray *list2=imageView.subviews;
                    for (id obj2 in list2) {
                        if ([obj2 isKindOfClass:[UIImageView class]]) {
                            UIImageView *imageView2=(UIImageView *)obj2;
                            imageView2.hidden=hidden;
                        }
                    }
                }
            }
        }
    }
}
@end
