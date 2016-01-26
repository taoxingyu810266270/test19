//
//  ViewController.m
//  4-CustomNSOperation
//
//  Created by qianfeng1 on 16/1/25.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import "ViewController.h"
#import "MyOperation.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    创建了自定义线程（跟NSInvocationOperation 和NSBlackOperation 是一样的，都是继承与 NSOoperation）
    MyOperation *myOP = [[MyOperation alloc]init];
    myOP.urlStr = @"http://jameswatt.local/word.jpg";
    
    [myOP setBlock:^(NSData *data) {
        NSLog(@"数据下载成功");
        NSLog(@"%@",[NSThread currentThread]);
    }];
//    创建队列
    NSOperationQueue  *queue = [[NSOperationQueue alloc]init];
//    把线程添加到队列里面
    [queue addOperation:myOP];
//    KVO 监听operation 的新值，如果新值等于0 说明线程已经直接完毕
    [queue addObserver:self forKeyPath:@"operationCount" options:(NSKeyValueObservingOptionNew |NSKeyValueObservingOptionOld) context:NULL];
    
    

}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {


    NSLog(@"如果新值 的interview == 0 的话，就说明下载完成");

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
