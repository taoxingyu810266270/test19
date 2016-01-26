//
//  MyOperation.h
//  4-CustomNSOperation
//
//  Created by qianfeng1 on 16/1/25.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import <Foundation/Foundation.h>
//起别名 //返回值类型 //block名称 //参数
typedef void(^BlockComplication)(NSData*data);


//首先是Viewcontroller让我们去下载数据， 当我们下载完数据，需要回调给（告诉）Viewcontroller

@interface MyOperation : NSOperation
//给他一个网址
@property (nonatomic, copy)NSString *urlStr;
//属性

//存放下载的结果 
@property (nonatomic, strong)NSData *resultData;

//声明block 属性 ，也用copy
@property (nonatomic,copy)BlockComplication block;

//声明block 的setter 方法
-(void)setBlock:(BlockComplication)block;



@end
