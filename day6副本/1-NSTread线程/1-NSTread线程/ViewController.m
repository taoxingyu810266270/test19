//
//  ViewController.m
//  1-NSTread线程
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
//    创建一个子线程,指定子线程启动的方法  自动执行的
    NSLog(@"当前方法所在的线程%@",[NSThread currentThread]);

//    [NSThread detachNewThreadSelector:@selector(doThing) toTarget:self withObject:nil];
//    第二种创建线程的方法(NSThread) ,不会自动执行
    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(doThing) object:nil];
    thread.name = @"下载线程";
//    启动线程
    [thread start];
    
//    创建另一个线程
    NSThread *thread1 = [[NSThread alloc]initWithTarget:self selector:@selector(doThing1) object:nil];
    
    thread1.name = @"上传线程";
    [thread1 start];
//    取消一个线程
//    [thread1 cancel];
    
    
    
    
}
//方法里面，做的事情都是子线程在做
-(void)doThing {
    NSLog(@"子线程，做事情");
    
//    主线程
    NSLog(@"主线程%@",[NSThread mainThread]);
    NSLog(@"当前方法所在的线程%@",[NSThread currentThread]);
    NSLog(@"-----%@",[NSThread currentThread]);
    
}
-(void)doThing1 {
    
    //线程休眠,可以让线程休眠一段时间
    NSLog(@"进入子线程，紧接着就让这个线程 休眠3秒");
    [NSThread sleepForTimeInterval:3];
//    线程休眠方法二
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:3];
    [NSThread sleepUntilDate:date];
    
    NSLog(@"休眠结束了");
    NSLog(@"主线程%@",[NSThread mainThread]);
    NSLog(@"-----%@",[NSThread currentThread]);
    for (int i = 0; i<100; i++) {
        NSLog(@"-----%@%d",[NSThread currentThread],i);
    }
    
//    让子线程里面 刷新UI （错误的做法）
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"欢迎来到子线程" message:nil preferredStyle:UIAlertControllerStyleAlert];
//    
//    [self presentViewController:alert animated:YES completion:nil];
    

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
