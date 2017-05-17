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
#import "LoopScrollViewViewController.h"

#define kCellIdentify @"cellIdentify"
@interface ViewController () <
UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) UITableView *theTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.items = @[
                   @"WZHEmptyView",
                   @"QHAlertView",
                   @"QHProgressHub",
                   @"LoopScrollView"
                   ];
    [self.view addSubview:self.theTableView];
    NSLog(@"%ld", self.theTableView.tag);
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentify];
    cell.textLabel.text = [self.items objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
            
            case 0: {
                [self.view qh_showEmptyViewWithImage:[UIImage imageNamed:@"empty_nomarl"]
                                description:@"哎呀，加载数据失败了!"
                               buttonTitles:@[@"取消", @"重新加载"]
                                     action:^(NSInteger index) {
                                         
                                         NSLog(@"%ld", index);
                                         [self.view qh_dismissEmptyView];
                                     }];
                break;
            }
            
            case 1: {
                
                [QHAlertView showWithTitle:@"温馨提示"
                                   message:@"网络超时，加载数据失败"
                              buttonTitles:@[@"编辑", @"新增", @"删除"]
                                    action:^(NSInteger index) {
                                        
                                        NSLog(@"%ld", index);
                                        [QHAlertView dismiss];
                                    }];
                break;
            }
            
            case 2: {
                
                [QHProgressHub show];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                             (int64_t)(3.0 * NSEC_PER_SEC)),
                               dispatch_get_main_queue(), ^{
                    
                    //[QHProgressHub dismiss];
                    [QHProgressHub showWithStatus:@"网络超时，加载数据失败"];
                });
                break;
            }
            
            case 3: {
                
                LoopScrollViewViewController *loopViewController = [[LoopScrollViewViewController alloc] init];
                [self.navigationController pushViewController:loopViewController animated:YES];
                break;
            }
            
            case 4: {
                
                break;
            }
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableView *)theTableView {
    
    if (!_theTableView) {
        
        _theTableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                     style:UITableViewStylePlain];
        _theTableView.delegate = self;
        _theTableView.dataSource = self;
        [_theTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentify];
    }
    return  _theTableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
