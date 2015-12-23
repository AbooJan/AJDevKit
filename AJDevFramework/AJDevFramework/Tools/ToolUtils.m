//
//  ToolUtils.m
//  拍卖行
//
//  Created by admin on 13-8-29.
//  Copyright (c) 2013年 liouly. All rights reserved.
//

#import "ToolUtils.h"
#include <sys/sysctl.h>
#import <CommonCrypto/CommonDigest.h>
#import "NSDateFormatter+Category.h"
#import "NSString+Size.h"

@implementation ToolUtils

#pragma  mark - 文件路径

//返回Cache路径
+(NSString *)returnCachePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES);
    
    NSString *cachesDir = [paths objectAtIndex:0];
    
    return cachesDir;
}

//保存数据到本地沙盒
+(void)setDataToSandboxWithPersonalInfo:(NSDictionary *)dicToSandbox
{
    NSMutableDictionary *data;
    
    //获得沙盒路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    
    NSString *fileName = [path stringByAppendingPathComponent:@"personal.plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:fileName];
    
    if (!dic) {
        
        NSFileManager *fm = [NSFileManager defaultManager];
        [fm createFileAtPath:fileName contents:nil attributes:nil];
        data = [NSMutableDictionary dictionaryWithDictionary:dicToSandbox];
        [data writeToFile:fileName atomically:YES];

    }
}

//读取沙盒中的数据
+(NSDictionary *)getDataFromSanboxWithPersonalInfo
{
    //获得沙盒路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    
    NSString *fileName = [path stringByAppendingPathComponent:@"personal.plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:fileName];
    
    if (dic) {
        
        return dic;
        
    }else{
        
        return nil;
        
    }
}

//删除沙盒中的数据
+(void)deleteDataInSanbox
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    
    NSString *fileName = [path stringByAppendingPathComponent:@"personal.plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:fileName];
    
    if (dic) {
        
        NSFileManager *fm = [NSFileManager defaultManager];
        [fm removeItemAtPath:fileName error:nil];

    }

}

//判断沙盒中是否有数据
+(BOOL)isDataInSanbox
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    
    NSString *fileName = [path stringByAppendingPathComponent:@"personal.plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:fileName];
    
    if (dic) {
        
        return YES;
    }
    
    return NO;
}


#pragma mark - 本地缓存文件操作

//计算指定文件夹下的文件总大小
+(float )folderSizeAtPath:(NSString*) folderPath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    float folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += (float)[self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/1024;
}

//删除指定文件夹下的文件
+(void)removeFolderWithPath:(NSString *)folderPath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:folderPath]){
        
        NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
        NSString* fileName;

        while ((fileName = [childFilesEnumerator nextObject]) != nil){
            NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
            [manager removeItemAtPath:fileAbsolutePath error:nil];
        }
    }
}

//计算指定文件的大小
+(float)fileSizeAtPath:(NSString*) filePath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return (float)[[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

//删除本地的指定文件
+(void)deleteFileWithFileName:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    
    NSString *file = [path stringByAppendingPathComponent:fileName];
    
    if (fileName) {
        
        NSFileManager *fm = [NSFileManager defaultManager];
        [fm removeItemAtPath:file error:nil];
        
    }
}


+ (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

+ (UIColor *) colorWithHexString: (NSString *)color andAlpha:(CGFloat )alpha
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];
}

//返回完整的图片路径
+(NSString *)orgianPath:(NSString *)imagePath
{
//    NSString *path = [NSString stringWithFormat:@"%@%@",BASEIMAGEURL,imagePath];
    
    return imagePath;
}

+(BOOL)isEmpty:(NSString *)string
{
    if (!string) {
        
        return YES;
        
    }
    
    if ([string isEqualToString:@""]) {
        
        return YES;
        
    }
    
    return NO;
    
}

+(BOOL)isEmptyArray:(NSArray *)array
{
    if (!array) {
        
        return YES;
        
    }
    
    if (array.count<=0) {
        
        return YES;
        
    }
    
    return NO;
    
}

#pragma mark -格式化富文本
+(void)formatRawFacebookContentForFrontEndRichTextContents:(NSString *)stringToFormat completion:(void (^)(NSAttributedString *attString))completion
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        NSData *dataContent = [stringToFormat dataUsingEncoding:NSUnicodeStringEncoding];
        
        NSMutableAttributedString * richTxtContent = [[NSMutableAttributedString alloc] initWithData:dataContent options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion)
                completion(richTxtContent);
        });
    });
}

#pragma mark - 日期

//返回格式化的时间
+(NSString *)dateStringFromDate:(NSDate *)date Formatter:(NSString *)formatterString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatterString];
    NSString *dateString = [formatter stringFromDate:date];
    
    return dateString;
}

//返回当前时间String
+(NSString *)getTimeNowWithFormatter:(NSString *)formatterString
{
    NSString* date;
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:formatterString];
    date = [formatter stringFromDate:[NSDate date]];
    NSString  *timeNow = [[NSString alloc] initWithFormat:@"%@",date];
    
    return timeNow;
}

//返回当前时间Date
+(NSDate *)getCurrentDateWithFormatter:(NSString *)formatterString
{
    NSString *currentString = [ToolUtils getTimeNowWithFormatter:formatterString];
    
    NSDate *date = [ToolUtils dateFromDateString:currentString Formatter:formatterString];
    
    return date;
}

//NSString 转 Date
+(NSDate *)dateFromDateString:(NSString *)dateString Formatter:(NSString *)matter
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:matter];
    NSDate *date = [formatter dateFromString:dateString];
    
    return date;
}

//转为北京时间
+ (NSDate *)dateForGMT:(NSDate *)data
{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [zone secondsFromGMTForDate:data];
    
    NSDate *localeDate = [data  dateByAddingTimeInterval:interval];
    
    return localeDate;
}

//时间比较
+(NSComparisonResult )checkDateTimeWithDate1:(NSDate *)date1 Data2:(NSDate *)date2
{
    switch ([date1 compare:date2]) {
        case NSOrderedSame:             //相等
        {
            return NSOrderedSame;
        }
            break;
        case NSOrderedAscending:        //date1比date2小
        {
            return NSOrderedAscending;
        }
            break;
        case NSOrderedDescending:       //date1比date2大
        {
            return NSOrderedDescending;
        }
            break;
            
        default:
            
            DLog(@"非法时间");
            
            break;
    }
    
    return NSOrderedSame;
}

//计算两个时间的时间差NSDate
+(double)timeDiffWithDate:(NSDate *)date1 date2:(NSDate *)date2
{
    double timeDiff = 0.0;
    
    timeDiff = [date2 timeIntervalSinceDate:date1];
    
    return timeDiff;
    
}

//计算两个时间的时间差String
+(double)timeDiffWithTimeString:(NSString *)time1 time2:(NSString *)time2 formatter:(NSString *)formatter
{
    double timeDiff = 0.0;
    
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:formatter];
    NSDate *date1 = [formatter1 dateFromString:time1];
    
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    [formatter2 setDateFormat:formatter];
    NSDate *date2 = [formatter2 dateFromString:time2];
    
    timeDiff = [self timeDiffWithDate:date1 date2:date2];
    
    return timeDiff;
    
}

//获取字符的长度，英文为一个，中文为两个
+(int)getTextLength:(NSString *)text
{
    float asciiLength = 0;
    
    for (NSInteger i = 0, len = text.length; i < len; i++)
    {
        unichar uc = [text characterAtIndex: i];
        
        asciiLength += isascii(uc) ? 1 : 2;
    }
    return  asciiLength;
}

#pragma mark - Image处理

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
                              Right:(CGFloat)right
{
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    
    if (IOS_VERSION>=6.0) {
        image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeTile];
    }else{
        image = [image resizableImageWithCapInsets:insets];
    }
    
    
    return image;
}

+(UIImage *)noStretchImageWithImage:(UIImage *)image
{
    UIEdgeInsets insets = UIEdgeInsetsMake(5, 5, 5, 5);
    
    if (IOS_VERSION>=6.0) {
        image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeTile];
    }else{
        image = [image resizableImageWithCapInsets:insets];
    }
    
    
    return image;
}

+(BOOL)imageHasAlpha: (UIImage *) image
{
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(image.CGImage);
    return (alpha == kCGImageAlphaFirst ||
            alpha == kCGImageAlphaLast ||
            alpha == kCGImageAlphaPremultipliedFirst ||
            alpha == kCGImageAlphaPremultipliedLast);
}
+(NSString *)image2DataURL: (UIImage *) image
{
    NSData *imageData = nil;
    NSString *mimeType = nil;
    
    if ([self imageHasAlpha: image]) {
        imageData = UIImagePNGRepresentation(image);
        mimeType = @"image/png";
    } else {
        imageData = UIImageJPEGRepresentation(image, 1.0f);
        mimeType = @"image/jpeg";
    }
    
    return [imageData base64EncodedStringWithOptions: 0];
}

#pragma mark - 设备相关

//操作系统
+(NSString *)getSystemName
{
    return [UIDevice currentDevice].systemName;
}

//操作系统版本
+(NSString *)getSystemVersion
{
    return [UIDevice currentDevice].systemVersion;
}

+ (NSString*)getDeviceVersion
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char*)malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}

//设备型号
+ (NSString *)getDeviceModel
{
    NSString *platform = [self getDeviceVersion];
    //iPhone
    if ([platform isEqualToString:@"iPhone1,1"])   return@"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])   return@"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])   return@"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])   return@"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"])   return@"Verizon iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"])   return@"iPhone 4 (CDMA)";
    if ([platform isEqualToString:@"iPhone4,1"])   return @"iPhone 4s";
    if ([platform isEqualToString:@"iPhone5,1"])   return @"iPhone 5 (GSM/WCDMA)";
    if ([platform isEqualToString:@"iPhone4,2"])   return @"iPhone 5 (CDMA)";
    
    //iPot Touch
    if ([platform isEqualToString:@"iPod1,1"])     return@"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])     return@"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])     return@"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])     return@"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])     return@"iPod Touch 5G";
    //iPad
    if ([platform isEqualToString:@"iPad1,1"])     return@"iPad";
    if ([platform isEqualToString:@"iPad2,1"])     return@"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])     return@"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])     return@"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])     return@"iPad 2 New";
    if ([platform isEqualToString:@"iPad2,5"])     return@"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad3,1"])     return@"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])     return@"iPad 3 (CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])     return@"iPad 3 (GSM)";
    if ([platform isEqualToString:@"iPad3,4"])     return@"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"i386"] || [platform isEqualToString:@"x86_64"])        return@"Simulator";
    
    return platform;
}


+ (NSInteger)countWord:(NSString *)content
{
    NSInteger i,n=[content length],l=0,a=0,b=0;
    unichar c;
    for(i=0;i<n;i++){
        c=[content characterAtIndex:i];
        if(isblank(c)){
            b++;
        }else if(isascii(c)){
            a++;
        }else{
            l++;
        }
    }
    if(a==0 && l==0) return 0;
    return l+(int)ceilf((float)(a+b));
}

/**
 *  日期格式转换
 *
 *  @param originalDateStr 需要转换的日期
 *  @param goalFormat      需要转换的格式
 *
 *  @return 转换后的日期
 */
+ (NSString *)formatDateWithOriginal:(NSString *)originalDateStr goalFormat:(NSString *)goalFormat
{
    NSDateFormatter *originalFormatter = [NSDateFormatter defaultDateFormatter];
    NSDateFormatter *goalFormatter = [NSDateFormatter dateFormatterWithFormat:goalFormat];
    
    NSDate *originalDate = [originalFormatter dateFromString:originalDateStr];
    
    return [goalFormatter stringFromDate:originalDate];
}

+ (UIWindow *)lastWindow {
    
    NSArray *windows = [[UIApplication sharedApplication] windows];

    UIWindow *window = windows.lastObject;
    
    return window;

}

@end
