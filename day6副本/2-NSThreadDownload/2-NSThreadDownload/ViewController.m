//
//  ViewController.m
//  2-NSThreadDownload
//
//  Created by qianfeng1 on 16/1/25.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIImageView *imageview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    http://inews.gtimg.com/newsapp_match/0/153455554/640?tp=webp
    
    NSThread *thread1 = [[NSThread alloc]initWithTarget:self selector:@selector(doThing) object:nil];

    [thread1 start];
    
//    [self loadImage];
}
-(void)doThing {

    NSURL *url = [NSURL URLWithString:@"http://jameswatt.local/world.jpg"];
    
    NSData *imagedata = [NSData dataWithContentsOfURL:url];
    
    UIImage *image = [UIImage imageWithData:imagedata];
    
////    UI必须要在主线程里面刷新
//    self.imageview.image = image;
//    线程通信
    
//    之歌是直接回到主线程
//    self performSelectorOnMainThread:<#(nonnull SEL)#> withObject:<#(nullable id)#> waitUntilDone:<#(BOOL)#>
    
//    回到指定的一个线程
//    回到哪一个线程
//    方法的参数
//    是否要等待那个线程执行完毕 一般情况下 不要等待
    [self performSelector:@selector(otherThread:) onThread:[NSThread mainThread] withObject:image waitUntilDone:nil ];
    

}
-(void)otherThread:(UIImage*)image {
    
    
        self.imageview.image = image;


}

-(void)loadImage {

    NSURL *url = [NSURL URLWithString:@"http://jameswatt.local/world.jpg"];
    
    NSData *imagedata = [NSData dataWithContentsOfURL:url];

    UIImage *image = [UIImage imageWithData:imagedata];
    
    self.imageview.image = image;
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
