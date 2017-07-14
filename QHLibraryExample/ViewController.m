//
//  ViewController.m
//  QHLibraryExample
//
//  Created by QianHan on 2017/7/14.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, weak) UITableView *exampleTableView;
@property (nonatomic, copy) NSArray *dataList;

@end

@implementation ViewController

#pragma mark - life cyclic
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"QHLibrary使用案例";
    self.view.backgroundColor = [UIColor colorWithRed:245.0 / 255.0
                                                green:245.0 / 255.0
                                                 blue:245.0 / 255.0
                                                alpha:1.0];
    self.dataList = @[
                      @[
                          @"QHHub",
                          @"QHEmptyView",
                          @"QHAlertView",
                          @"QHLoopScrollView",
                          @"QHRefresh",
                          @"SlideTabViewController",
                          @"QHWebController"
                          ]
                      ];
    [self setupView];
}

#pragma mark - event response

#pragma mark - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.dataList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *subDataList = self.dataList[section];
    return subDataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *const cellId = @"exampleCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    NSArray *subDataList = self.dataList[indexPath.section];
    cell.textLabel.text  = subDataList[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - private method
- (void)setupView {
    
    [self initExampleTableView];
}

#pragma mark - init subview
- (void)initExampleTableView {
    
    if (!self.exampleTableView) {
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.backgroundColor              = [UIColor clearColor];
        tableView.showsVerticalScrollIndicator = NO;
        tableView.delegate                     = self;
        tableView.dataSource                   = self;
        tableView.autoresizingMask             = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        tableView.tableFooterView = [UIView new];
        [self.view addSubview:tableView];
        self.exampleTableView = tableView;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
