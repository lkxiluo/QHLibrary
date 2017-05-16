//
//  NSString+QHValidate.h
//  QHUtil
//
//  Created by QianHan on 2017/3/3.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 字符串验证类
 */
@interface NSString (QHValidate)

/**
 *  判断字符串是否是合法的手机号
 *
 *  @return YES：合法 NO：不合法
 */
- (BOOL)qh_validateMobile;

/**
 *  判断字符是否是合法的邮箱
 *
 *  @return YES：合法 NO：不合法
 */
- (BOOL)qh_validateEmail;

/* 判断用户输入的密码是否符合规范，符合规范的密码要求
 * 1. 长度大于6~16位
 * 2. 密码中必须同时包含数字和字母
 * @return YES：是 NO：不是
 */
- (BOOL)qh_validatePasswordLegal;

/**
 验证字符串是否是身份证

 @return YES：是 NO：不是
 */
- (BOOL)qh_validateIdentityCard;

/**
 验证字符串是否是中文
 
 @return YES：是 NO：不是
 */
- (BOOL)qh_validateChinese;

@end
