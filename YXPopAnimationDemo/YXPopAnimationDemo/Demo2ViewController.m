//
//  Demo2ViewController.m
//  YXUICollectionViewDemo
//
//  Created by yixiang on 15/10/10.
//  Copyright © 2015年 yixiang. All rights reserved.
//

#import "Demo2ViewController.h"

@interface Demo2ViewController()

@end

@implementation Demo2ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
    [super initView];
    
    self.view.backgroundColor = [UIColor redColor];
}

-(NSString *)controllerTitle{
    return @"demo2";
}

@end
