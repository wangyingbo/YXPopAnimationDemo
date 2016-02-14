//
//  Demo1ViewController.m
//  YXUICollectionViewDemo
//
//  Created by yixiang on 15/10/10.
//  Copyright © 2015年 yixiang. All rights reserved.
//

#import "Demo1ViewController.h"
#import <POP/POP.h>

@interface Demo1ViewController()

@property (nonatomic , strong) UIView *demoView;

@end

@implementation Demo1ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
    [super initView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _demoView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, SCREEN_HEIGHT/2-100,100 ,100 )];
    _demoView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_demoView];
}

-(NSString *)controllerTitle{
    return @"基础动画";
}

-(NSArray *)operateTitleArray{
    return [NSArray arrayWithObjects:@"位移",@"透明度",@"缩放",@"旋转",@"Shape", @"UIView",nil];
}

-(void)clickBtn : (UIButton *)btn{
    switch (btn.tag) {
        case 0:
            [self positionAnimation];
            break;
        case 1:
            [self opacityAniamtion];
            break;
        case 2:
            [self scaleAnimation];
            break;
        case 3:
            [self rotateAnimation];
            break;
        case 4:
            [self cAShapeLayerAnimation];
            break;
        case 5:
            [self uIViewAnimation];
            break;
        default:
            break;
    }
}



/**
 *  位移动画演示
 */
-(void)positionAnimation{
    POPBasicAnimation *anima = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    anima.fromValue = [NSNumber numberWithFloat:0.];
    anima.toValue = [NSNumber numberWithFloat:SCREEN_WIDTH];
    anima.duration = 2.;
   // anima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];//动画的渐进渐出效果
    
    CGRect orginRect = _demoView.frame;
    [anima setCompletionBlock:^(POPAnimation *anima, BOOL finish) {
        if (finish) {
            _demoView.frame = orginRect;
            NSLog(@"%@",NSStringFromCGRect(_demoView.frame));//POP比较好的一点是保留了动画结束后的状态
        }
    }];
    [_demoView.layer pop_addAnimation:anima forKey:@"position"];
}

/**
 *  透明度动画
 */
-(void)opacityAniamtion{
    POPBasicAnimation *anima = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    anima.fromValue = [NSNumber numberWithFloat:1.];
    anima.toValue = [NSNumber numberWithFloat:0.];
    anima.duration = 2.;

    [anima setCompletionBlock:^(POPAnimation *anima, BOOL finish) {
        if (finish) {
            _demoView.layer.opacity = 1.;
        }
    }];
    [_demoView.layer pop_addAnimation:anima forKey:@"opacity"];
}

/**
 *  缩放动画
 */
-(void)scaleAnimation{
    POPBasicAnimation *anima = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    anima.fromValue = [NSValue valueWithCGPoint:CGPointMake(0.2, 0.2)];
    anima.toValue = [NSValue valueWithCGPoint:CGPointMake(1., 1.)];
    anima.duration = 2.;
    
    [_demoView.layer pop_addAnimation:anima forKey:@"scale"];
}

/**
 *  旋转动画
 */
-(void)rotateAnimation{
    POPBasicAnimation *anima = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
    anima.fromValue = [NSNumber numberWithFloat:0.];
    anima.toValue = [NSNumber numberWithFloat:M_PI];
    anima.duration = 2.;
    
    [anima setCompletionBlock:^(POPAnimation *anima, BOOL finish) {
        if (finish) {
            anima.removedOnCompletion=YES;
        }
    }];
    
    [_demoView.layer pop_addAnimation:anima forKey:@"rotation"];
}

/**
 *  基于CAShapeLayer的动画
 */
-(void)cAShapeLayerAnimation{
    _demoView.backgroundColor = [UIColor clearColor];

    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = _demoView.bounds;
//    shapeLayer.strokeEnd = 0.0f;
//    shapeLayer.strokeStart = 0.1f;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:_demoView.bounds];
    
    shapeLayer.path = path.CGPath;
    
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 2.0f;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    
    [_demoView.layer addSublayer:shapeLayer];
    
//    CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    pathAnima.duration = 3.0f;
//    pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    pathAnima.fromValue = [NSNumber numberWithFloat:0.0f];
//    pathAnima.toValue = [NSNumber numberWithFloat:1.0f];
//    pathAnima.fillMode = kCAFillModeForwards;
//    pathAnima.removedOnCompletion = NO;
//    [shapeLayer addAnimation:pathAnima forKey:@"strokeEndAnimation"];
    
    POPBasicAnimation *pathAnima = [POPBasicAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    pathAnima.duration = 3.0f;
    pathAnima.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnima.toValue = [NSNumber numberWithFloat:1.0f];
    
    [pathAnima setCompletionBlock:^(POPAnimation *anima, BOOL finish) {
        if (finish) {
            _demoView.backgroundColor = [UIColor redColor];
            [shapeLayer removeFromSuperlayer];
        }
    }];
    
    [shapeLayer pop_addAnimation:pathAnima forKey:@"strokeEndAnimation"];
    
    
}

/**
 *  基于UIView的动画
 */
-(void)uIViewAnimation{
    POPBasicAnimation *anima = [POPBasicAnimation animationWithPropertyNamed:kPOPViewBackgroundColor];
    anima.duration = 1.5f;
    anima.toValue = [UIColor greenColor];
    
    [anima setCompletionBlock:^(POPAnimation *anima, BOOL finish) {
        _demoView.backgroundColor = [UIColor redColor];
    }];
    [_demoView pop_addAnimation:anima forKey:@"UIViewAnimation"];
}

@end
