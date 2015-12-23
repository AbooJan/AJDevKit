//
//  RegxUtil.h
//  jianzhimao
//
//  Created by 刘骞 on 3/26/14.
//  Copyright (c) 2014 Guangzhou jiuwei technology company. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegexKitLite.h"
#import "RegexDefine.h"

@interface RegexUtil : NSObject
+ (BOOL) inputIsUsername:(NSString *) inputStr;
+ (BOOL) inputIsPassword:(NSString *) inputStr;
+ (BOOL) inputIsEmail:(NSString *) inputStr;
+ (BOOL) inputIsPhoneNumber:(NSString *) inputStr;
+ (BOOL) inputIsTel:(NSString *)inputStr;         // 校验固定电话
+ (BOOL) inputIsCheckCode:(NSString *) inputStr;
/// 小数
+ (BOOL) inputIsFloatNum:(NSString *)inputStr;
/// 正整数
+ (BOOL) inputIsUInteger:(NSString *)inputStr;
/// 支付宝账户名
+ (BOOL) inputIsAlipayName:(NSString *)inputStr;

+ (NSInteger) string :(NSString *) string1 matchedCountInString:(NSString *) string2;
+ (NSString *)cleanSpecialCharForMD5:(NSString *) aString;
@end
