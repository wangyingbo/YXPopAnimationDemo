//
//  PopMenu.m
//  YXPopAnimationDemo
//
//  Created by yixiang on 16/2/15.
//  Copyright © 2016年 yixiang. All rights reserved.
//

#import "PopMenu.h"
#import "MenuButton.h"
#import <POP.h>

#define MenuButtonHeight 110
#define MenuButtonVerticalPadding 10
#define MenuButtonHorizontalMargin 10
#define MenuButtonAnimationTime 0.2
#define MenuButtonAnimationInterval (MenuButtonAnimationTime / 5)

#define kMenuButtonBaseTag 100

@interface PopMenu ()

@property (nonatomic, strong, readwrite) NSArray *items;

@property (nonatomic, strong) MenuItem *selectedItem;

@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) CGPoint endPoint;

@end

@implementation PopMenu

- (id)initWithFrame:(CGRect)frame
              items:(NSArray *)items {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.items = items;
        
        [self setup];
    }
    return self;
}

- (void)setup {
    self.backgroundColor = [UIColor clearColor];
}

#pragma mark - 公开方法

- (void)showMenuAtView:(UIView *)containerView {
    CGPoint startPoint = CGPointMake(0, CGRectGetHeight(self.bounds));
    CGPoint endPoint = startPoint;
    switch (self.menuAnimationType) {
        case kPopMenuAnimationTypeNetEase:
            startPoint.x = CGRectGetMidX(self.bounds);
            endPoint.x = startPoint.x;
            break;
        default:
            break;
    }
    [self showMenuAtView:containerView startPoint:startPoint endPoint:endPoint];
}

- (void)showMenuAtView:(UIView *)containerView
            startPoint:(CGPoint)startPoint
              endPoint:(CGPoint)endPoint {
    if (self.isShowed) {
        return;
    }
    self.startPoint = startPoint;
    self.endPoint = endPoint;
    [containerView addSubview:self];
    
    [self showButtons];
}

- (void)dismissMenu {
    [self hidenButtons];
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1.0f];
}

#pragma mark - 私有方法

- (void)showButtons {
    self.isShowed = YES;
    NSArray *items = [self menuItems];
    
    NSInteger perRowItemCount = 3;
    CGFloat menuButtonWidth = (CGRectGetWidth(self.bounds) - ((perRowItemCount + 1) * MenuButtonHorizontalMargin)) / perRowItemCount;
    
    typeof(self) __weak weakSelf = self;
    for (int index = 0; index < items.count; index ++) {
        
        MenuItem *menuItem = items[index];
        menuItem.index = index;
        MenuButton *menuButton = (MenuButton *)[self viewWithTag:kMenuButtonBaseTag + index];
        
        CGRect toRect = [self getFrameWithItemCount:items.count perRowItemCount:perRowItemCount perColumItemCount:3 itemWidth:menuButtonWidth itemHeight:MenuButtonHeight paddingX:MenuButtonVerticalPadding paddingY:MenuButtonHorizontalMargin atIndex:index onPage:0];
        
        CGRect fromRect = toRect;
        
        switch (self.menuAnimationType) {
            case kPopMenuAnimationTypeSina:
                fromRect.origin.y = self.startPoint.y;
                break;
            case kPopMenuAnimationTypeNetEase:
                fromRect.origin.x = self.startPoint.x - menuButtonWidth / 2.0;
                fromRect.origin.y = self.startPoint.y;
                break;
            default:
                break;
        }
        if (!menuButton) {
            menuButton = [[MenuButton alloc] initWithFrame:fromRect menuItem:menuItem];
            menuButton.tag = kMenuButtonBaseTag + index;
            menuButton.didSelctedItemCompleted = ^(MenuItem *menuItem) {
                weakSelf.selectedItem = menuItem;
                [weakSelf dismissMenu];
            };
            [self addSubview:menuButton];
        } else {
            menuButton.frame = fromRect;
        }
        
        double delayInSeconds = index * MenuButtonAnimationInterval;
        
        [self initailzerAnimationWithToPostion:toRect formPostion:fromRect atView:menuButton beginTime:delayInSeconds];
    }
}

- (void)hidenButtons {
    self.isShowed = NO;
    NSArray *items = [self menuItems];
    
    for (int index = 0; index < items.count; index ++) {
        MenuButton *menuButton = (MenuButton *)[self viewWithTag:kMenuButtonBaseTag + index];
        
        CGRect fromRect = menuButton.frame;
        
        CGRect toRect = fromRect;
        
        switch (self.menuAnimationType) {
            case kPopMenuAnimationTypeSina:
                toRect.origin.y = self.endPoint.y;
                break;
            case kPopMenuAnimationTypeNetEase:
                toRect.origin.x = self.endPoint.x - CGRectGetMidX(menuButton.bounds);
                toRect.origin.y = self.endPoint.y;
                break;
            default:
                break;
        }
        double delayInSeconds = (items.count - index) * MenuButtonAnimationInterval;
        
        [self initailzerAnimationWithToPostion:toRect formPostion:fromRect atView:menuButton beginTime:delayInSeconds];
    }
}

- (NSArray *)menuItems {
    return self.items;
}

/**
 *  通过目标的参数，获取一个grid布局
 *
 *  @param perRowItemCount   每行有多少列
 *  @param perColumItemCount 每列有多少行
 *  @param itemWidth         gridItem的宽度
 *  @param itemHeight        gridItem的高度
 *  @param paddingX          gridItem之间的X轴间隔
 *  @param paddingY          gridItem之间的Y轴间隔
 *  @param index             某个gridItem所在的index序号
 *  @param page              某个gridItem所在的页码
 *
 *  @return 返回一个已经处理好的gridItem frame
 */
- (CGRect)getFrameWithItemCount:(NSInteger)itemCount
                perRowItemCount:(NSInteger)perRowItemCount
              perColumItemCount:(NSInteger)perColumItemCount
                      itemWidth:(CGFloat)itemWidth
                     itemHeight:(NSInteger)itemHeight
                       paddingX:(CGFloat)paddingX
                       paddingY:(CGFloat)paddingY
                        atIndex:(NSInteger)index
                         onPage:(NSInteger)page {
    NSUInteger rowCount = itemCount / perRowItemCount + (itemCount % perColumItemCount > 0 ? 1 : 0);
    CGFloat insetY = (CGRectGetHeight(self.bounds) - (itemHeight + paddingY) * rowCount) / 2.0;
    
    CGFloat originX = (index % perRowItemCount) * (itemWidth + paddingX) + paddingX + (page * CGRectGetWidth(self.bounds));
    CGFloat originY = ((index / perRowItemCount) - perColumItemCount * page) * (itemHeight + paddingY) + paddingY;
    
    CGRect itemFrame = CGRectMake(originX, originY + insetY, itemWidth, itemHeight);
    return itemFrame;
}


#pragma mark - Animation

- (void)initailzerAnimationWithToPostion:(CGRect)toRect formPostion:(CGRect)fromRect atView:(UIView *)view beginTime:(CFTimeInterval)beginTime {
    POPSpringAnimation *springAnimation = [POPSpringAnimation animation];
    springAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
    springAnimation.removedOnCompletion = YES;
    springAnimation.beginTime = beginTime + CACurrentMediaTime();
    CGFloat springBounciness = 10 - beginTime * 2;
    springAnimation.springBounciness = springBounciness;    // value between 0-20
    
    CGFloat springSpeed = 12 - beginTime * 2;
    springAnimation.springSpeed = springSpeed;     // value between 0-20
    springAnimation.toValue = [NSValue valueWithCGRect:toRect];
    springAnimation.fromValue = [NSValue valueWithCGRect:fromRect];
    
    [view pop_addAnimation:springAnimation forKey:@"POPSpringAnimationKey"];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self dismissMenu];
}

@end
