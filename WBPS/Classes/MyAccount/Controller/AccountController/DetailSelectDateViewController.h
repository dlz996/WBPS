//
//  DetailSelectDateViewController.h
//  WBPS
//
//  Created by 董立峥 on 2017/10/12.
//  Copyright © 2017年 董立峥. All rights reserved.
//

#import "BasicViewController.h"
#import "HooDatePicker.h"

typedef void(^returnSelectDate)(NSString * selectDate);

@interface DetailSelectDateViewController : BasicViewController

@property (nonatomic,copy)returnSelectDate date;

@end
