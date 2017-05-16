//
//  ViewController.m
//  WZHLibrary
//
//  Created by QianHan on 2017/5/12.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

#import "ViewController.h"
#import "UIView+QHEmptyView.h"
#import "QHProgressHub.h"
#import "QHAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 空视图的使用
    [self.view qh_showWithImage:[UIImage imageNamed:@"empty_nomarl"]
                     description:@"哎呀，加载数据失败了!"
                    buttonTitles:@[@"QHAlertView", @"QHProgressHub"]
                          action:^(NSInteger index) {
                              
                              NSLog(@"%ld", index);
                              switch (index) {
                                  case 0: {
                                      
                                      [QHAlertView showWithTitle:@"温馨提示"
                                                         message:@"网络超时，加载数据失败"
                                                    buttonTitles:@[@"编辑", @"新增", @"删除"]
                                                          action:^(NSInteger index) {
                                          
                                                              NSLog(@"%ld", index);
                                                              [QHAlertView dismiss];
                                      }];
                                      break;
                                  }
                                  case 1: {
                                      
                                      [QHProgressHub show];
                                      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                          
                                          //[QHProgressHub dismiss];
                                          [QHProgressHub showWithStatus:@"网络超时，加载数据失败"];
                                      });
                                  }
                                      
                                  default: {
                                      
                                      break;
                                  }
                              }
                              [self.view qh_dismiss];
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
