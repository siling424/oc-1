//
//  ViewController.m
//  oc入组出组
//
//  Created by 成雷司 on 2018/4/9.
//  Copyright © 2018年 司成雷. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self group2];
}

- (void)group2 {
    
    //创建调度组
    dispatch_group_t group = dispatch_group_create();
    
    //创建队列
    dispatch_queue_t q = dispatch_queue_create(0, 0);
    
    //调度组监听队列调度任务
    //入组
    dispatch_group_enter(group);
    dispatch_async(q, ^{
        NSLog(@"download A %@", [NSThread currentThread]);
        
        //出组
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_async(q, ^{
        NSLog(@"download B %@", [NSThread currentThread]);
        
        //出组
        dispatch_group_leave(group);
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"come here %@", [NSThread currentThread]);
    });
    
}

- (void)group1 {
    //创建调度组
    dispatch_group_t group = dispatch_group_create();
    
    //创建队列
    dispatch_queue_t q = dispatch_queue_create(0, 0);
    
    //调度组监听队列调度任务
    dispatch_group_async(group, q, ^{
        NSLog(@"download A %@", [NSThread currentThread]);
    });
    
    dispatch_group_async(group, q, ^{
//        [NSThread sleepForTimeInterval:1.0];
        NSLog(@"download B %@", [NSThread currentThread]);
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"come here %@", [NSThread currentThread]);
    });
}

@end
