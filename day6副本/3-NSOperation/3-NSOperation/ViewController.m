//
//  ViewController.m
//  3-NSOperation
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
//    抽象 父类 只定义了方法 没有实现
//    NSInvocationOperation 创建了一个线程
    NSInvocationOperation *ivc = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(doThing) object:nil];
//    启动  是没有用的 ，他会在我们的主线程中
    
//    [ivc start];
     NSInvocationOperation *ivc2 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(doThing2) object:nil];
//    线程队列
    //    主线程队列
    [NSOperationQueue mainQueue];
    
    //    创建一个线程队列
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    //    把线程添加到线程队列里面
    
   
    //    [ivc2 start];
    
//    设置线程依赖，让ivc2依赖于1，设置依赖要在，线程添加在队列之前 （只要把线程添加到队列里面，队列会管理线程的执行）
//    你添加到费列里面两个线程，不一定就创建两个线程，因为系统根据CUP使用情况，自动的去判断。
    [ivc2 addDependency:ivc];
//    第二种创建NSOperation线程的方法
    NSBlockOperation *blockOp = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"block  op %@",[NSThread currentThread]);
    }];
//    添加到队列里
    [queue addOperation:blockOp];
    
//    (NSOperation要添加到线程队列里面)把线程添加到线程队列里面，不能用手动的启动，系统会自己安排启动
    [queue addOperation:ivc2];
    [queue addOperation:ivc];
    
//    控制队列的最大同时执行数量，并发数
    queue.maxConcurrentOperationCount = 1;
//需要去检测线程的状态
//    KVO键值观察，观察我们队列的 线程数量
    [queue addObserver:self forKeyPath:@"operationCount" options:NSKeyValueObservingOptionNew |NSKeyValueObservingOptionOld context:NULL];
    
    
}
//用这个方法 实现键值观察 必须实现observeValueForKeyPath
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
//监听operationCount的值 如果等于0；说明当前队列的线程已经执行完毕
    if ([change[@"new"] integerValue] == 0) {
        NSLog(@"线程已经执行完毕");
        NSLog(@"%@",[NSThread currentThread]);
        
//        如果要刷新UI的话，就必须回到主线程才能刷新
        [self performSelectorOnMainThread:@selector(backMainThread) withObject:nil waitUntilDone:NO];
    }

}
-(void)backMainThread {
//    打印当前方法名
    NSLog(@"%s",__func__);

    NSLog(@"%@",[NSThread currentThread]);

}

-(void)doThing {
    
    for (int i = 0; i<100; i++) {
        NSLog(@"dot  Thing 1......%@",[NSThread currentThread]);
    }


}
-(void)doThing2 {
    
    for (int i = 0; i<100; i++) {
        NSLog(@"dot  Thing 2......%@",[NSThread currentThread]);
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
