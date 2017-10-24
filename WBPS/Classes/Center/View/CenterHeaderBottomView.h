//
//  CenterHeaderBottomView.h
//  WBPS
//
//  Created by 董立峥 on 2017/9/25.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 接单总数、评价、总里程数视图 */
@interface CenterHeaderBottomView : UIView
/** 提示文字 */
@property (nonatomic,strong)UILabel * hintLabel;
/** 数值 */
@property (nonatomic,strong)UILabel * valueLabel;

@end
