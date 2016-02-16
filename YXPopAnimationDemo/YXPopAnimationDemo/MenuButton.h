//
//  MenuButton.h
//  YXPopAnimationDemo
//
//  Created by yixiang on 16/2/15.
//  Copyright © 2016年 yixiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@class MenuItem;

typedef void(^DidSelctedItemCompletedBlock)(MenuItem *menuItem);

@interface MenuButton : UIView

@property (nonatomic, copy) DidSelctedItemCompletedBlock didSelctedItemCompleted;

- (instancetype)initWithFrame:(CGRect)frame
                     menuItem:(MenuItem *)menuItem;

@end
