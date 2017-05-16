//
//  WZHAlertView.h
//  WZHLibrary
//
//  Created by QianHan on 2017/5/16.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QHAlertView : NSObject

+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
         buttonTitles:(NSArray *)titles
               action:(void(^)(NSInteger index))action;
+ (void)dismiss;

@end
