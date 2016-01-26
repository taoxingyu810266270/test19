//
//  MyOperation.m
//  4-CustomNSOperation
//
//  Created by qianfeng1 on 16/1/25.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import "MyOperation.h"

@implementation MyOperation
//继承NSOperation之后 要实现一个方法main

-(void)mian {
//子线程的操作
    NSLog(@"在这里面进行多线程操作");
    NSURL *url = [NSURL URLWithString:self.urlStr];
//    下载数据（同步的下载数据的方法）
    NSData *data = [NSData dataWithContentsOfURL:url];
//1.代理
//2.通知
//3.KVO
//4.Block
    
    
//    存一下结果， 方便使用
    self.resultData = data;
//    回调，如果block 存在才回调
    if (self.block) {
//        回到主线程然后回调block
        [self performSelectorOnMainThread:@selector(backMainThread) withObject:nil waitUntilDone:NO];
    }
    
}
//回到主线程
-(void)backMainThread {
//回调block
    _block(_resultData);
}

@end
