//
//  ViewController.m
//  1-NSlock
//
//  Created by qianfeng1 on 16/1/26.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

//存在银行的钱
@property (nonatomic)NSInteger num;
//线程锁
@property (nonatomic, strong)NSLock *lock;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    假如在银行存了 50块钱
    self.num = 50;
    [self test1];
}

//正常情况下取钱
-(void)test0 {

    for (int i = 0; i<50; i++) {
        
        [self fetchMOney];
    }

}
//异步去取钱，也就是开始一个子线程去取钱
-(void)test1 {
//    创建线程锁 加锁之后，只能等解锁以后这个代码块，才会再被执行（同一时间只能执行一次，要想再次执行，必须等着解锁）
    _lock = [[NSLock alloc]init];
    for (int i = 0; i<50; i++) {
//        GCD创建了一个子线程，
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
////            加个锁 然后你就可以去取钱了
//            [_lock lock];
//            [self fetchMOney];
////          取完钱解锁
//            [_lock unlock];
//           线程锁的第二种方式
            @synchronized(self) {
//                加锁的代码块
                [self fetchMOney];
                
            }
        });
        
    }
    
}

//取钱的方法,每次取出一块
-(void)fetchMOney {
    if (_num>0) {
        [NSThread sleepForTimeInterval:1];
        self.num--;
        NSLog(@"取了1元，余额：%ld元",_num);
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
