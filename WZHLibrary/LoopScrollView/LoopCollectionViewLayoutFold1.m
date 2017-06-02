//
//  FoldCollectionViewLayout.m
//  WZHLibrary
//
//  Created by QianHan on 2017/5/17.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

#import "LoopCollectionViewLayoutFold1.h"

static CGFloat kItemSpace = 15.0f;    // 选项间的距离
@interface LoopCollectionViewLayoutFold1 ()

@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) CGFloat viewWidth;
@property (nonatomic, assign) CGFloat itemWidth;

@end

@implementation LoopCollectionViewLayoutFold1

- (void)prepareLayout {
    [super prepareLayout];
    self.itemSize = CGSizeMake(CGRectGetHeight(self.collectionView.frame) - kItemSpace * 2,
                               CGRectGetHeight(self.collectionView.frame) - kItemSpace * 2);
    self.viewWidth = CGRectGetWidth(self.collectionView.frame);
    self.itemWidth = self.itemSize.width;
    self.collectionView.contentInset = UIEdgeInsetsMake(0,
                                                        (self.viewWidth - self.itemWidth) / 2,
                                                        0,
                                                        (self.viewWidth - self.itemWidth) / 2);
    
}

@end
