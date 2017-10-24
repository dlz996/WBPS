//
//  SelectableOverlay.m
//  officialDemo2D
//
//  Created by yi chen on 14-5-8.
//  Copyright (c) 2014年 AutoNavi. All rights reserved.
//

#import "SelectableOverlay.h"

@implementation SelectableOverlay

#pragma mark - MAOverlay Protocol

- (CLLocationCoordinate2D)coordinate{
    return [self.overlay coordinate];
}

- (MAMapRect)boundingMapRect{
    return [self.overlay boundingMapRect];
}

#pragma mark - Life Cycle

- (id)initWithOverlay:(id<MAOverlay>)overlay{
    self = [super init];
    if (self){
        self.overlay       = overlay;
        self.selected      = NO;
        self.selectedColor = [UIColor colorWithRed:56/255.0 green:158/255.0 blue:74/255.0  alpha:1];
        self.regularColor  = [UIColor colorWithRed:175/255.0  green:234/255.0  blue:190/255.0  alpha:1];
    }
    return self;
}

@end
