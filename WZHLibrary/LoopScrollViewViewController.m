//
//  LoopScrollViewViewController.m
//  WZHLibrary
//
//  Created by QianHan on 2017/5/17.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

#import "LoopScrollViewViewController.h"
#import "LoopScrollView.h"

@interface LoopScrollViewViewController ()<
UITableViewDelegate,
UITableViewDataSource
> {
    
    CGFloat _loopHeight;
}

@property (nonatomic, weak) UITableView *loopTypeTabelView;
@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, assign) LoopScrollViewType type;

@end

@implementation LoopScrollViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArray = @[
                       @"LoopScrollViewNormal",
                       @"LoopScrollViewFold1",
                       @"LoopScrollViewFold2",
                       @"LoopScrollView3DFlow"
                       ];
    self.type   = LoopScrollViewNormal;
    _loopHeight = 180.0f;
    [self addLoopTypeTabelView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"CellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        
        cell  = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return _loopHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    LoopScrollView *bannerView = [[LoopScrollView alloc] initWithType:self.type
                                                                frame:CGRectMake(0.0,
                                                                                 0.0,
                                                                                 tableView.frame.size.width,
                                                                                 _loopHeight)];
    bannerView.imageUrlArray = @[
                                 @"http://pic15.nipic.com/20110623/7810872_173729199142_2.jpg",
                                 @"http://pic38.nipic.com/20140222/13141444_190705666137_2.jpg",
                                 @"http://img4.3lian.com/img2005/05/19/14.jpg",
                                 @"http://img.taopic.com/uploads/allimg/121214/267863-121214204F841.jpg",
                                 @"http://img.taopic.com/uploads/allimg/121215/267862-12121520062755.jpg"
                                 ];
    
    return bannerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.type = indexPath.row;
    if (self.type == LoopScrollViewNormal) {
        
        _loopHeight = 180.0f;
    } else {
        
        _loopHeight = 150.0f;
    }
    [tableView reloadData];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)addLoopTypeTabelView {
    
    if (self.loopTypeTabelView == nil) {
        
        UITableView *loopTypeTabelView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                                      style:UITableViewStylePlain];
        loopTypeTabelView.delegate   = self;
        loopTypeTabelView.dataSource = self;
        [self.view addSubview:loopTypeTabelView];
        self.loopTypeTabelView       = loopTypeTabelView;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
