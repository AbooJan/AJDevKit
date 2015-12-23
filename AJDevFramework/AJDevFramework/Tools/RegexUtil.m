    //
//  RegxUtil.m
//  jianzhimao
//
//  Created by 刘骞 on 3/26/14.
//  Copyright (c) 2014 Guangzhou jiuwei technology company. All rights reserved.
//

#import "RegexUtil.h"

@implementation RegexUtil
+ (BOOL)inputIsCheckCode:(NSString *)inputStr{
    
    return [inputStr isMatchedByRegex:REGXEX_CHECKCODE];
}
+ (BOOL)inputIsEmail:(NSString *)inputStr{
    
    return [inputStr isMatchedByRegex:REGXEX_EMAIL];
}
+ (BOOL)inputIsPassword:(NSString *)inputStr{
    return [inputStr isMatchedByRegex:REGXEX_PASSWORD];
}
+ (BOOL)inputIsPhoneNumber:(NSString *)inputStr{
    return [inputStr isMatchedByRegex:REGXEX_PHONE];
}
+ (BOOL)inputIsTel:(NSString *)inputStr
{
    return [inputStr isMatchedByRegex:REGXEX_TEL_NUMBER];
}
+ (BOOL)inputIsUsername:(NSString *)inputStr{
    return [inputStr isMatchedByRegex:REGXEX_USERNAME];
}
+ (BOOL)inputIsFloatNum:(NSString *)inputStr
{
    return [inputStr isMatchedByRegex:REGXEX_FLOAT_NUM];
}
+ (BOOL) inputIsUInteger:(NSString *)inputStr
{
    return [inputStr isMatchedByRegex:REGXEX_UINTEGER];
}

+ (BOOL) inputIsAlipayName:(NSString *)inputStr
{
    return [inputStr isMatchedByRegex:REGXEX_UINTEGER];
}

+ (NSInteger)string:(NSString *)string1 matchedCountInString:(NSString *)string2{
    return  [string2 arrayOfCaptureComponentsMatchedByRegex:string1].count;
}
+ (NSString *)cleanSpecialCharForMD5:(NSString *)aString{
    
    NSArray *letterAndNums = [aString arrayOfCaptureComponentsMatchedByRegex:REGXEX_LETTER_AND_NUM];
    if (letterAndNums != nil && letterAndNums.count>0) {
        NSMutableString *s = [NSMutableString new];
        for (NSArray *arr in letterAndNums) {
            for (NSString *code in arr) {
                [s appendString:code];
            }
        }
        return s;
    }
    return @"";
}
@end
