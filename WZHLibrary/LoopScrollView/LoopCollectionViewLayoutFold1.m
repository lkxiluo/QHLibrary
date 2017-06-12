//
//  FoldCollectionViewLayout.m
//  WZHLibrary
//
//  Created by QianHan on 2017/5/17.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

#import "LoopCollectionViewLayoutFold1.h"

//static NSInteger const kItemCount = 3;        // 可视区内的选项数据
@interface LoopCollectionViewLayoutFold1 ()

@property (nonatomic, assign) CGSize itemSize;      // 选项大小
@property (nonatomic, assign) CGFloat viewWidth;    // 可视区域宽
@property (nonatomic, assign) CGFloat itemWidth;    // 选项宽

@end

@implementation LoopCollectionViewLayoutFold1

- (void)prepareLayout {
    
    [super prepareLayout];
    self.itemSize = CGSizeMake(CGRectGetHeight(self.collectionView.frame) * 4 / 3,
                               CGRectGetHeight(self.collectionView.frame));
    self.viewWidth = CGRectGetWidth(self.collectionView.frame);
    self.itemWidth = self.itemSize.width;
    self.collectionView.contentInset = UIEdgeInsetsMake(0,
                                                        (self.viewWidth - self.itemWidth) / 2,
                                                        0,
                                                        - (self.viewWidth - self.itemWidth) / 2);
    
}

- (CGSize)collectionViewContentSize {
    
    NSInteger sectionCount = [self.collectionView numberOfSections];
    CGFloat contentWidth   = 0.0;
    for (NSInteger i = 0; i < sectionCount; i++) {
        
        NSInteger cellCount    = [self.collectionView numberOfItemsInSection:i];
        contentWidth += cellCount * self.itemWidth;
    }
    return CGSizeMake(contentWidth, CGRectGetHeight(self.collectionView.frame));
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    CGFloat centerX         = self.viewWidth / 2 + self.collectionView.contentOffset.x;
    NSInteger currentIndex  = centerX / self.itemWidth;
    NSInteger sectionCount  = [self.collectionView numberOfSections];
    NSInteger allItemsCount = 0; // 选项总数
    
    NSMutableArray *layoutArray= [NSMutableArray new];
    for (NSInteger i = 0; i < sectionCount; i++) {
        
        NSInteger preItemsCount       = allItemsCount; // 当前section之前的所有选项总数
        NSInteger preSectionCount     = i - 1 >= 0 ? [self.collectionView numberOfItemsInSection:i - 1] : 0; // 前一个section的row数
        NSInteger currentSectionCount = [self.collectionView numberOfItemsInSection:i]; // 当前section的row数
        NSInteger nextSectionCount    = i + 1 < sectionCount ? [self.collectionView numberOfItemsInSection:i + 1] : 0; // 下一个section的row数
        allItemsCount                 += currentSectionCount;
        
        if (currentIndex < allItemsCount) {
            
            NSIndexPath *indexPath;
            if (currentIndex < allItemsCount) {
                
                NSMutableArray *indexPathArray = [NSMutableArray new];
                
                if ((currentIndex - 1 >= preItemsCount || preItemsCount == 0)
                    && currentIndex + 1 < allItemsCount) {
                    
                    NSInteger minIndex = MAX(0, currentIndex - 1 - preItemsCount);
                    NSInteger maxIndex = MIN(currentIndex - (preItemsCount - 1), allItemsCount - 1);
                    for (NSInteger j = minIndex; j <= maxIndex; j++) {
                        
                        indexPath = [NSIndexPath indexPathForItem:j inSection:i];
                        [indexPathArray addObject:indexPath];
                    }
                } else {
                
                    if (currentIndex - 1 < preItemsCount
                        && preSectionCount > 0) {
                        
                        indexPath = [NSIndexPath indexPathForItem:preSectionCount - 1 inSection:i - 1];
                        [indexPathArray addObject:indexPath];
                    } else {
                        
                        indexPath = [NSIndexPath indexPathForItem:MAX((currentIndex - preItemsCount) - 1, 0) inSection:i];
                        [indexPathArray addObject:indexPath];
                    }
                    
                    if (currentIndex + 1 == allItemsCount
                        && nextSectionCount > 0) {
                        
                        indexPath = [NSIndexPath indexPathForItem:0 inSection:i + 1];
                        [indexPathArray addObject:indexPath];
                    }
                    
                    indexPath = [NSIndexPath indexPathForItem:currentIndex - preItemsCount inSection:i];
                    [indexPathArray addObject:indexPath];
                }
                
                for (NSIndexPath *indexPath in indexPathArray) {
                    
                    NSLog(@"%ld %ld %ld", indexPath.section, indexPath.row, currentIndex - preItemsCount);
                    UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
                    [layoutArray addObject:attributes];
                }
            }
            
            break;
        }
    }
    
    return layoutArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.size     = self.itemSize;
  
    CGFloat cY          = self.collectionView.contentOffset.x + self.viewWidth / 2;
    CGFloat attributesY = 0.0f;
    for (NSInteger i = 0; i <= indexPath.section; i++) {
        
        if (indexPath.section == i) {
            
            attributesY += indexPath.row * self.itemWidth;
        } else {
            
            NSInteger itemNumber = [self.collectionView numberOfItemsInSection:i];
            attributesY += itemNumber * self.itemWidth;
        }
    }
    attributesY += self.itemWidth / 2;
    attributes.zIndex   = -ABS(attributesY - cY);

    CGFloat delta        = cY - attributesY;
    CGFloat ratio        = - delta / (self.viewWidth * 2);
    CGFloat scale        = 1 - ABS(delta) / (self.itemWidth * 6.0) * cos(ratio * M_PI_4);
    attributes.transform = CGAffineTransformMakeScale(scale, scale);
    CGFloat centerY      = attributesY;
    centerY              = cY + (attributesY - cY) * scale;
    attributes.center = CGPointMake(centerY, CGRectGetHeight(self.collectionView.frame) / 2);
    
    return attributes;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset
                                 withScrollingVelocity:(CGPoint)velocity {
    
    CGFloat index = roundf((proposedContentOffset.x + self.viewWidth / 2 - self.itemWidth / 2) / self.itemWidth);
    proposedContentOffset.x = self.itemWidth * index + self.itemWidth / 2 - self.viewWidth / 2;
    return proposedContentOffset;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {

    return !CGRectEqualToRect(newBounds, self.collectionView.bounds);
}

@end
