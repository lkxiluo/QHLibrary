//
//  NSDictionary+QHSafeConvert.h
//  QHUtil
//
//  Created by QianHan on 2017/3/3.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 字典的安全转换，主要是防止转化时出现NSNull类型出现
 */
@interface NSDictionary (QHSafeConvert)

/**
 获取字典中的字符串

 @param aKey 键
 @return 字符串
 */
- (NSString *)qh_stringForKeySafe:(id)aKey;

/**
 获取字典中NSNumber

 @param aKey 键
 @return NSNumber
 */
- (NSNumber *)qh_numberForKeySafe:(id)aKey;

/**
 获取字典中的NSInteger类型

 @param aKey 键
 @return NSInteger
 */
- (NSInteger)qh_integerForKeySafe:(id)aKey;

/**
 获取字典中的int

 @param aKey 键
 @return int
 */
- (int)qh_intForKeySafe:(id)aKey;

/**
 获取字典中的CGFloat

 @param aKey 键
 @return float
 */
- (float)qh_floatForKeySafe:(id)aKey;

/**
 获取字典中的double

 @param aKey 键
 @return double
 */
- (double)qh_doubleForKeySafe:(id)aKey;

/**
 获取字典中的BOOL

 @param aKey 键
 @return BOOL
 */
- (BOOL)qh_boolForKeySafe:(id)aKey;

/**
 获取字典中的数组

 @param aKey 键
 @return 数组
 */
- (NSArray *)qh_arrayForKeySafe:(id)aKey;

/**
 获取字典中的字典

 @param akey 键
 @return 字典
 */
- (NSDictionary *)qh_dictionaryForKeySafe:(id)akey;

@end
