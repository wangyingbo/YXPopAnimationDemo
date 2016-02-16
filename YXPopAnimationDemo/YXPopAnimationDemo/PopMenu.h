//
//  PopMenu.h
//  YXPopAnimationDemo
//
//  Created by yixiang on 16/2/15.
//  Copyright © 2016年 yixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuItem.h"

typedef NS_ENUM(NSInteger, PopMenuAnimationType) {
    kPopMenuAnimationTypeSina = 0,
    kPopMenuAnimationTypeNetEase = 1,
};

typedef void(^DidSelectedItemBlock)(MenuItem *selectedItem);

@interface PopMenu : UIView

@property (nonatomic, assign) PopMenuAnimationType menuAnimationType;

@property (nonatomic, assign) BOOL isShowed;

@property (nonatomic, strong, readonly) NSArray *items;

@property (nonatomic, copy) DidSelectedItemBlock didSelectedItemCompletion;

- (instancetype)initWithFrame:(CGRect)frame
                        items:(NSArray *)items;

- (void)showMenuAtView:(UIView *)containerView;
- (void)showMenuAtView:(UIView *)containerView
            startPoint:(CGPoint)startPoint
              endPoint:(CGPoint)endPoint;
- (void)dismissMenu;

@end
