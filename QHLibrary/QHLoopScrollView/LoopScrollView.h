//
//  LoopScrollView.h
//  WZHLibrary
//
//  Created by QianHan on 2017/5/16.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LoopScrollViewType) {
    
    LoopScrollViewNormal = 0,  // 正常效果
    LoopScrollViewFold1,       // 折叠效果
    LoopScrollViewFold2,       // 折叠效果
    LoopScrollView3DFlow       // 3D效果
};

/**
 轮播图
 */
@interface LoopScrollView : UIView

// 二者只存在一种，设置一个则另一个清空
@property (nonatomic, copy) NSArray *imageNameArray;    // 图片名集合
@property (nonatomic, copy) NSArray *imageUrlArray;     // 图片URL集合

- (instancetype)initWithType:(LoopScrollViewType)type frame:(CGRect)frame;

@end
