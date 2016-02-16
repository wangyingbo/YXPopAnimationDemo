//
//  Demo4ViewController.m
//  YXPopAnimationDemo
//
//  Created by yixiang on 16/2/14.
//  Copyright © 2016年 yixiang. All rights reserved.
//

#import "Demo4ViewController.h"
#import <POP/POP.h>

@interface Demo4ViewController ()

@end

@implementation Demo4ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
    [super initView];
    

    
}

-(NSString *)controllerTitle{
    return @"POPCustomAnimation";
}

-(NSArray *)operateTitleArray{
    return [NSArray arrayWithObjects:@"秒表",nil];
}

-(void)clickBtn : (UIButton *)btn{
    switch (btn.tag) {
        case 0:
            [self customAnimation_1];
            break;
        default:
            break;
    }
}

-(void)customAnimation_1{
    POPAnimatableProperty *prop = [POPAnimatableProperty propertyWithName:@"countdown" initializer:^(POPMutableAnimatableProperty *prop) {
        //readBlock告诉POP当前的属性值
        prop.readBlock = ^(id obj , CGFloat values[]){
            NSLog(@"%f",values[0]);
        };
        //writeBlock中修改变化后的属性值
        prop.writeBlock = ^(id obj , const CGFloat values[]){
            UILabel *label = (UILabel *)obj;
            label.text = [NSString stringWithFormat:@"%02d:%02d:%02d",(int)values[0]/60,(int)values[0]%60,(int)(values[0]*100)%100];
            //NSLog(@"%f",values[0]);
        };
        //threashold决定了动画变化间隔的阈值 值越大writeBlock的调用次数越少
        //prop.threshold = 100;
    }];
    
    POPBasicAnimation *anima = [POPBasicAnimation linearAnimation];//秒表当然必须是线性的时间函数
    anima.property = prop;//自定义属性
    anima.fromValue = @(0);//从0开始
    anima.toValue = @(3*60);//180秒
    anima.duration = 3*60;//持续3分钟
    anima.beginTime = CACurrentMediaTime() + 1.0f;//延迟1秒开始
    
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 50)];
    timeLabel.textColor = [UIColor blackColor];
    timeLabel.font = [UIFont systemFontOfSize:25.];
    //timeLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:timeLabel];
    
    [timeLabel pop_addAnimation:anima forKey:@"timeAnima"];
    
    
    
}


@end
