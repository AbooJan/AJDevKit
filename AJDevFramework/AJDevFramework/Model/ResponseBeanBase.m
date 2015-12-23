//
//  ResponseBeanBase.m
//  YueFaBao
//
//  Created by 钟宝健 on 15/9/9.
//  Copyright (c) 2015年 joiway. All rights reserved.
//

#import "ResponseBeanBase.h"

#warning !!!!!param replace
//#define kDataName @"data."

@implementation ResponseBeanBase

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{};
    
//    const char *msgName = "msg";
//    const char *codeName = "code";
//    
//    unsigned int propCount;
//    objc_property_t* properties = class_copyPropertyList([self class], &propCount);
//    
//    NSMutableDictionary *parmas = [[NSMutableDictionary alloc] initWithCapacity:propCount];
//    
//    for (int i=0; i<propCount; i++) {
//        
//        objc_property_t prop = properties[i];
//        const char *propName = property_getName(prop);
//        
//        if(propName) {
//            
//            // 过滤掉最外层参数
//            if (strcmp(propName, msgName) == 0 || strcmp(propName, codeName) == 0) {
//                continue;
//            }
//            
//            NSString *key = [NSString stringWithCString:propName encoding:NSUTF8StringEncoding];
//            
//            NSString *value = [kDataName stringByAppendingString:key];
//            
//            [parmas setObject:value forKey:key];
//            
//        }
//        
//    }
//    
//    return parmas;
}

MJExtensionLogAllProperties

@end
