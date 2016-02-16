//
//  MenuItem.h
//  YXPopAnimationDemo
//
//  Created by yixiang on 16/2/15.
//  Copyright © 2016年 yixiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MenuItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIImage *iconImage;
@property (nonatomic, assign) NSUInteger index;

- (instancetype)initWithTitle:(NSString *)title
                     iconName:(NSString *)iconName
                        index:(NSUInteger)index;

@end
