//
//  NSString+QHValidate.m
//  QHUtil
//
//  Created by QianHan on 2017/3/3.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

#import "NSString+QHValidate.h"

@implementation NSString (QHValidate)

- (BOOL)qh_validateMobile {
    
    if (self.length > 11 || self.length < 11) {
#ifdef DEBUG
        NSAssert(NO, @"Your phonenumber lenght must is 11");
#endif
        return NO;
    }
    /**
     * 移动号段正则表达式
     */
    NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
    /**
     * 联通号段正则表达式
     */
    NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(17[1,5,6])|(18[5,6]))\\d{8}|(1709)\\d{7}$";
    /**
     * 电信号段正则表达式
     */
    NSString *CT_NUM = @"^((133)|(153)|(17[0,3,7])|(18[0,1,9]))\\d{8}$";
    
    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
    NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
    
    BOOL isMatch1 = [pred1 evaluateWithObject:self];
    BOOL isMatch2 = [pred2 evaluateWithObject:self];
    BOOL isMatch3 = [pred3 evaluateWithObject:self];
    
    if (isMatch1 || isMatch2 || isMatch3) {
        return YES;
    }else{
        return NO;
    }
}

-(BOOL)qh_validateEmail {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)qh_validatePasswordLegal {
    
    BOOL result = NO;
    if ([self length] >= 6
        && [self length] <= 16) {
        
        // 判断长度大于6位后再接着判断是否同时包含数字和字符
        NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:self];
#ifdef DEBUG
        NSAssert(result, @"Your password must contain both letters and numbers");
#endif
    } else {
        
#ifdef DEBUG
        NSAssert(result, @"Your password lenght must between 6 to 16");
#endif
    }
    return result;
}

- (BOOL)qh_validateIdentityCard {
    
    BOOL flag = NO;
    if (self.length <= 0) {
        
        flag = NO;
        return flag;
    }
    
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    flag = [identityCardPredicate evaluateWithObject:self];
    
    // 如果通过该验证，说明身份证格式正确，但准确性还需计算
    if (flag) {
        
        if (self.length == 18) {
            
            // 将前17位加权因子保存在数组里
            NSArray * idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
            
            // 这是除以11后，可能产生的11位余数、验证码，也保存成数组
            NSArray * idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
            
            // 用来保存前17位各自乖以加权因子后的总和
            
            NSInteger idCardWiSum = 0;
            for (int i = 0;i < 17;i++) {
                
                NSInteger subStrIndex = [[self substringWithRange:NSMakeRange(i, 1)] integerValue];
                NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
                
                idCardWiSum+= subStrIndex * idCardWiIndex;
                
            }
            
            // 计算出校验码所在数组的位置
            NSInteger idCardMod     = idCardWiSum % 11;
            
            // 得到最后一位身份证号码
            NSString * idCardLast   = [self substringWithRange:NSMakeRange(17, 1)];
            
            // 如果等于2，则说明校验码是10，身份证号码最后一位应该是X
            if(idCardMod == 2) {
                
                if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
                    
                    return flag;
                } else {
                    
                    flag =  NO;
                    return flag;
                }
            } else {
                
                // 用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
                if ([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
                    
                    return flag;
                } else {
                    
                    flag = NO;
                    return flag;
                }
            }
        } else {
            
            flag = NO;
            return flag;
        }
    } else {
        
        return flag;
    }
}

- (BOOL)qh_validateChinese {
    
    NSString* chineseStr    = @"^[\u4E00-\u9FA5]*$";
    NSPredicate *chinesePre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",chineseStr];
    return [chinesePre evaluateWithObject:self];
}

@end
