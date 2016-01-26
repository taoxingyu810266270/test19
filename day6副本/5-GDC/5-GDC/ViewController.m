//
//  ViewController.m
//  5-GDC
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
    
//    GDC是基于C语言的是NSOperation的底层实现
    
//    系统的全局队列（子线程）
//    如果在全局队列里面执行子线程任务的话 系统会自动调度（什么时候开始）
//    1.队列的ID  DISPATCH_QUEUE_PRIORITY_DEFAULT
//    2.队列的标示
  dispatch_queue_t globalQueue =  dispatch_get_global_queue(0, 0);
    
//    主线程队列(刷新UI)
    dispatch_queue_t mainQueue =  dispatch_get_main_queue();
    dispatch_async(globalQueue, ^{
        NSLog(@"子线程");
        [NSThread sleepForTimeInterval:3];
        NSLog(@"%@",[NSThread currentThread]);
        for (int i = 0; i<=100; i++) {
            NSLog(@"1 %@",[NSThread currentThread]);
        }
    });
//    创建另一个线程
    dispatch_async(globalQueue, ^{
        NSLog(@"子线程2");
        NSLog(@"%@",[NSThread currentThread]);
        for (int i = 0; i<=100; i++) {
            NSLog(@"2 %@",[NSThread currentThread]);
        }
    });
//    创建另一个线程，让他去下载数据
    dispatch_async(globalQueue, ^{
        
        [NSThread sleepForTimeInterval:5];
        NSURL *iurl = [NSURL URLWithString:@"http://jameswatt.local/world.jpg"];
//        NSData *data = [NSData dataWithContentsOfURL:iurl];
//        刷新UI肯定要回到主线程
        dispatch_async(mainQueue, ^{
            NSLog(@"回到了主线程，在这里刷新UI");
            NSLog(@"%@",[NSThread currentThread]);
        });
        
        
    });
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
