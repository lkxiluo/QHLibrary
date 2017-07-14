//
//  NSDictionary+QHSafeConvert.m
//  QHUtil
//
//  Created by QianHan on 2017/3/3.
//  Copyright © 2017年 karl.luo. All rights reserved.
//

#import "NSDictionary+QHSafeConvert.h"

@implementation NSDictionary (QHSafeConvert)

- (id)objectForKeySafe:(id)aKey
{
    if (!aKey) {
        return nil;
    }
    return [[self objectForKey:aKey] isKindOfClass:[NSNull class]] ? nil : [self objectForKey:aKey];
}

- (NSString *)qh_stringForKeySafe:(id)aKey
{
    NSString *value = [self objectForKeySafe:aKey];
    if (value) {
        
        if ([value isKindOfClass:[NSString class]]) {
            
            return value;
        } else if ([value isKindOfClass:[NSNumber class]]) {
            
            return [NSString stringWithFormat:@"%@", value];
        }
        return @"";
    }
    return @"";
}

- (NSNumber *)qh_numberForKeySafe:(id)aKey
{
    NSNumber *value = [self objectForKeySafe:aKey];
    if (value) {
        
        if ([value isKindOfClass:[NSNumber class]]) {
            
            return value;
        } else if ([value respondsToSelector:@selector(doubleValue)]) {
            
            return [NSNumber numberWithDouble:[value doubleValue]];
        }
        return [NSNumber numberWithInt:0];
    }
    return [NSNumber numberWithInt:0];
}

- (NSInteger)qh_integerForKeySafe:(id)aKey
{
    NSString *value = [self objectForKeySafe:aKey];
    if (value && [value respondsToSelector:@selector(integerValue)]) {
        
        return [value integerValue];
    }
    return 0;
}

- (int)qh_intForKeySafe:(id)aKey
{
    NSString *value = [self objectForKeySafe:aKey];
    if (value && [value respondsToSelector:@selector(intValue)]) {
        
        return [value intValue];
    }
    return 0;
}

- (float)qh_floatForKeySafe:(id)aKey
{
    NSString *value = [self objectForKeySafe:aKey];
    if (value && [value respondsToSelector:@selector(floatValue)]) {
        
        return [value floatValue];
    }
    return 0;
}

- (double)qh_doubleForKeySafe:(id)aKey
{
    NSString *value = [self objectForKeySafe:aKey];
    if (value && [value respondsToSelector:@selector(doubleValue)]) {
        
        return [value doubleValue];
    }
    return 0;
}

- (BOOL)qh_boolForKeySafe:(id)aKey
{
    NSString *value = [self objectForKeySafe:aKey];
    if (value && [value respondsToSelector:@selector(boolValue)]) {
        
        return [value boolValue];
    }
    return false;
}

- (NSArray *)qh_arrayForKeySafe:(id)aKey
{
    NSArray *value = [self objectForKeySafe:aKey];
    if (value && [value isKindOfClass:[NSArray class]]) {
        
        return value;
    }
    return @[];
}

- (NSDictionary *)qh_dictionaryForKeySafe:(id)akey
{
    NSDictionary *value = [self objectForKeySafe:akey];
    if (value && [value isKindOfClass:[NSDictionary class]]) {
        
        return value;
    }
    return @{};
}

@end
