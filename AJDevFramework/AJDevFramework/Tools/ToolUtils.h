//
//  ToolUtils.h
//  拍卖行
//
//  Created by admin on 13-8-29.
//  Copyright (c) 2013年 liouly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface ToolUtils : NSObject

//返回Cache路径
+(NSString *)returnCachePath;

//保存数据到本地沙盒
+(void)setDataToSandboxWithPersonalInfo:(NSDictionary *)dicToSandbox;

//读取沙盒中的数据
+(NSDictionary *)getDataFromSanboxWithPersonalInfo;

//删除沙盒中的数据
+(void)deleteDataInSanbox;

//判断沙盒中是否有数据
+(BOOL)isDataInSanbox;

//计算指定文件夹下的文件总大小
+(float)folderSizeAtPath:(NSString*) folderPath;

//计算指定文件的大小
+(float)fileSizeAtPath:(NSString*) filePath;

//删除指定文件夹下的文件
+(void)removeFolderWithPath:(NSString *)folderPath;

//删除本地的指定文件
+(void)deleteFileWithFileName:(NSString *)fileName;

//16进制颜色获取
+ (UIColor *) colorWithHexString: (NSString *)color;
+ (UIColor *) colorWithHexString: (NSString *)color andAlpha:(CGFloat )alpha;

//返回完整的图片路径
+(NSString *)orgianPath:(NSString *)imagePath;

+(BOOL)isEmpty:(NSString *)string;

+(BOOL)isEmptyArray:(NSArray *)array;

#pragma mark - 日期

//返回格式化时间String
+(NSString *)dateStringFromDate:(NSDate *)date Formatter:(NSString *)formatterString;

//返回当前时间Date
+(NSDate *)getCurrentDateWithFormatter:(NSString *)formatterString;

//NSString 转 Date
+(NSDate *)dateFromDateString:(NSString *)dateString Formatter:(NSString *)matter;

//转为北京时间
+ (NSDate *)dateForGMT:(NSDate *)data;

//返回当前时间
+(NSString *)getTimeNowWithFormatter:(NSString *)formatterString;

//时间比较
+(NSComparisonResult)checkDateTimeWithDate1:(NSDate *)date1 Data2:(NSDate *)date2;

//计算两个时间的时间差NSDate
+(double)timeDiffWithDate:(NSDate *)date1 date2:(NSDate *)date2;

//计算两个时间的时间差String
+(double)timeDiffWithTimeString:(NSString *)time1 time2:(NSString *)time2 formatter:(NSString *)formatter;

//获取字符的长度，英文为一个，中文为两个
+(int)getTextLength:(NSString *)text;

/*  UIButton 图片背景不拉伸
 *
 *  top顶部高度
 *  bottom底部高度
 *  left左部宽度
 *  right右部宽度
 */
+(UIImage *)noStretchImageWithImage:(UIImage *)image
                                Top:(CGFloat)top
                             Bottom:(CGFloat)bottom
                               Left:(CGFloat)left
                              Right:(CGFloat)right;

+(UIImage *)noStretchImageWithImage:(UIImage *)image;


//操作系统
+(NSString *)getSystemName;

//设备型号
+(NSString *)getDeviceModel;

//操作系统版本
+ (NSString *)getSystemVersion;


/**
 *  计算目标内容的长度，中文、英文、空格都为一个字符计算
 *
 *  @param content 需要计算长度的内容
 *
 *  @return 内容长度
 */
+(NSInteger)countWord:(NSString *)content;

/**
 *  日期格式转换
 *
 *  @param originalDateStr 需要转换的日期
 *  @param goalFormat      需要转换的格式
 *
 *  @return 转换后的日期
 */
+ (NSString *)formatDateWithOriginal:(NSString *)originalDateStr goalFormat:(NSString *)goalFormat;

@end
