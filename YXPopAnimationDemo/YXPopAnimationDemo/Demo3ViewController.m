//
//  Demo3ViewController.m
//  YXPopAnimationDemo
//
//  Created by yixiang on 16/2/14.
//  Copyright © 2016年 yixiang. All rights reserved.
//

#import "Demo3ViewController.h"
#import <POP/POP.h>

@interface Demo3ViewController ()

@property (nonatomic , strong) UIView *demoView;

@end

@implementation Demo3ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
    [super initView];
    
    _demoView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-25, SCREEN_HEIGHT/2-100,50 ,50 )];
    _demoView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_demoView];
    
}

-(NSString *)controllerTitle{
    return @"POPSpringAnimation";
}

-(NSArray *)operateTitleArray{
    return [NSArray arrayWithObjects:@"位移",nil];
}

-(void)clickBtn : (UIButton *)btn{
    switch (btn.tag) {
        case 0:
            [self positionAnimation];
            break;
        default:
            break;
    }
}

-(void)positionAnimation{
    POPDecayAnimation *positionAnima = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    positionAnima.fromValue = [NSNumber numberWithFloat:75.0f];
    positionAnima.velocity = @(200);
    positionAnima.deceleration = 0.998f;//衰减系数(越小则衰减得越快) 默认0.998
    //注意点：1、这里对POPDecayAnimation设置toValue是没有意义的 会被忽略(因为目的状态是动态计算得到的)
    //       2、POPDecayAnimation也是没有duration字段的 其动画持续时间由velocity与deceleration决定
    [_demoView.layer pop_addAnimation:positionAnima forKey:@"positionAnima"];
}

@end
