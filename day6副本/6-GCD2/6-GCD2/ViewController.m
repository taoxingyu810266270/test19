//
//  ViewController.m
//  6-GCD2
//
//  Created by qianfeng1 on 16/1/25.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    GCD的高级用法
//    GCD的分组
    dispatch_group_t group = dispatch_group_create();
    
//    在分组里面可以执行任务
//    第一个参数 分组
//    第二个参数 队列  (一般是全局的队列)
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        for (int i = 0 ; i<20; i++) {
            NSLog(@"分组任务111");
            NSLog(@"%@",[NSThread currentThread]);
        }
        
    });
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        for (int i = 0 ; i<20; i++) {
            NSLog(@"分组任务222");
            NSLog(@"%@",[NSThread currentThread]);

        }
        
    });
    //分组的通知,当组里面的所有线程（任务） 都执行完成之后就会通知这个block，我们让这个block在指定的队列里面执行
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"前面两个任务全部完成了 在主线程刷新UI");
    });
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
