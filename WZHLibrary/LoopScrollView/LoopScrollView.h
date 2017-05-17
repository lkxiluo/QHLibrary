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
    LoopScrollViewFold         // 折叠效果
};

/**
 轮播图
 */
@interface LoopScrollView : UIView

- (instancetype)initWithType:(LoopScrollViewType)type frame:(CGRect)frame;

@end
