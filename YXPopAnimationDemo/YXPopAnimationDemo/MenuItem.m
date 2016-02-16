//
//  MenuItem.m
//  YXPopAnimationDemo
//
//  Created by yixiang on 16/2/15.
//  Copyright © 2016年 yixiang. All rights reserved.
//

#import "MenuItem.h"

@implementation MenuItem

- (instancetype)initWithTitle:(NSString *)title
                     iconName:(NSString *)iconName
                        index:(NSUInteger)index {
    self = [super init];
    if (self) {
        self.title = title;
        self.iconImage = [UIImage imageNamed:iconName];
        self.index = index;
    }
    return self;
}

@end