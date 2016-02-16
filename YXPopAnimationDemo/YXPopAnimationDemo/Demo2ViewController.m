//
//  Demo2ViewController.m
//  YXUICollectionViewDemo
//
//  Created by yixiang on 15/10/10.
//  Copyright © 2015年 yixiang. All rights reserved.
//

#import "Demo2ViewController.h"
#import <POP/POP.h>
#import "PopMenu.h"
#import "PaperButton.h"

@interface Demo2ViewController()

@property (nonatomic, strong) UIView *demoView;
@property (nonatomic, strong) PopMenu *popMenu;
@property (nonatomic, strong) PaperButton *paperBtn;

@end

@implementation Demo2ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
    [super initView];
    
    _demoView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-25, SCREEN_HEIGHT/2-100,50 ,50 )];
    _demoView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_demoView];
    
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:6];
    MenuItem *menuItem = [[MenuItem alloc] initWithTitle:@"Flickr" iconName:@"post_type_bubble_flickr" index:0];
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc] initWithTitle:@"Googleplus" iconName:@"post_type_bubble_googleplus" index:1];
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc] initWithTitle:@"Instagram" iconName:@"post_type_bubble_instagram" index:2];
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc] initWithTitle:@"Twitter" iconName:@"post_type_bubble_twitter" index:3];
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc] initWithTitle:@"Youtube" iconName:@"post_type_bubble_youtube" index:4];
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc] initWithTitle:@"Facebook" iconName:@"post_type_bubble_facebook" index:5];
    [items addObject:menuItem];
    
    if (!_popMenu) {
        _popMenu = [[PopMenu alloc] initWithFrame:self.view.bounds items:items];
        _popMenu.didSelectedItemCompletion = ^(MenuItem *selectedItem) {
           // NSLog(@"==%i==",selectedItem.index);
        };
    }
    
    _popMenu.hidden = YES;
    
    _paperBtn = [PaperButton buttonWithOrigin:CGPointMake(SCREEN_WIDTH/2-25, SCREEN_HEIGHT/2-100)];
    [self.view addSubview:_paperBtn];
    _paperBtn.hidden = YES;
    
    
}

-(NSString *)controllerTitle{
    return @"POPSpringAnimation";
}

-(NSArray *)operateTitleArray{
    return [NSArray arrayWithObjects:@"位移",@"新浪",@"网易",@"PaperBtn",nil];
}

-(void)clickBtn : (UIButton *)btn{
    switch (btn.tag) {
        case 0:
            _demoView.hidden = NO;
            _popMenu.hidden = YES;
            _paperBtn.hidden = YES;
            [self positionAnimation];
            break;
        case 1:
            _demoView.hidden = YES;
            _popMenu.hidden = NO;
            _paperBtn.hidden = YES;
            [self sinaAnimation];
            break;
        case 2:
            _demoView.hidden = YES;
            _popMenu.hidden = NO;
            _paperBtn.hidden = YES;
            [self netEaseAnimation];
            break;
        case 3:
            _demoView.hidden = YES;
            _popMenu.hidden = YES;
            _paperBtn.hidden = NO;
            [self paperBtnAnimation];
            break;
        default:
            break;
    }
}

//-(void)showView()

-(void)positionAnimation{
    POPSpringAnimation *positionAnima = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    positionAnima.fromValue = [NSNumber numberWithFloat:75.0f];
    positionAnima.toValue = [NSNumber numberWithFloat:SCREEN_WIDTH-75.0f];
    positionAnima.springBounciness = 20.0f;//[0-20] 弹力 越大则震动幅度越大，默认值为4
    positionAnima.springSpeed = 20.0f;//[0-20] 速度 越大则动画结束越快 [0, 20]，默认为12，和springBounciness一起决定着弹簧动画的效果
    [_demoView.layer pop_addAnimation:positionAnima forKey:@"positionAnima"];
    
}

-(void)sinaAnimation{
    _popMenu.menuAnimationType = kPopMenuAnimationTypeSina;
    [_popMenu showMenuAtView:self.view];
}

-(void)netEaseAnimation{
    _popMenu.menuAnimationType = kPopMenuAnimationTypeNetEase;
    //[_popMenu showMenuAtView:self.view];
    [_popMenu showMenuAtView:self.view startPoint:CGPointMake(CGRectGetWidth(self.view.bounds) - 60, CGRectGetHeight(self.view.bounds)) endPoint:CGPointMake(60, CGRectGetHeight(self.view.bounds))];
}

-(void)paperBtnAnimation{
    
}

@end
