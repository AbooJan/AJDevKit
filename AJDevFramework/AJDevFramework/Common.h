//
//  DevCommon.h
//  AJDevFramework
//
//  Created by 钟宝健 on 15/12/21.
//  Copyright © 2015年 钟宝健. All rights reserved.
//

#ifndef Common_h
#define Common_h

#define NavigationBar_HEIGHT 64
#define NavigationBar_HEIGHT_BackUp ([[UIDevice currentDevice] systemVersion].floatValue>=7.0?64:44)
#define TabgationBar_HEIGHT 49

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_WIDTh_STATEBAR ([UIScreen mainScreen].bounds.size.width-20)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion ([[UIDevice currentDevice] systemVersion])
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])
#define DIVIDE_LINE_WIDTH 1.0


#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

/* 获取系统信息 */
#define kSystemVersion   [[UIDevice currentDevice] systemVersion]

/* 获取当前语言环境 */
#define kCurrentLanguage [[NSLocale preferredLanguages] objectAtIndex:0]

/* 获取当前APP版本 */
#define kAppVersion      [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

/* 获取当前APP名字 */
#define APP_NAME            [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]

/* 是否为7以上版本 */
#define SYSTEM7_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"7."] != NSOrderedAscending )

/* 是否为8以上版本 */
#define SYSTEM8_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"8."] != NSOrderedAscending )

#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif

#pragma mark - degrees/radian functions
#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)

#pragma mark - color functions
#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define ITTDEBUG
#define ITTLOGLEVEL_INFO     10
#define ITTLOGLEVEL_WARNING  3
#define ITTLOGLEVEL_ERROR    1

#ifndef ITTMAXLOGLEVEL

#ifdef DEBUG
#define ITTMAXLOGLEVEL ITTLOGLEVEL_INFO
#else
#define ITTMAXLOGLEVEL ITTLOGLEVEL_ERROR
#endif

#endif

// The general purpose logger. This ignores logging levels.
#ifdef ITTDEBUG
#define ITTDPRINT(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define ITTDPRINT(xx, ...)  ((void)0)
#endif

// Prints the current method's name.
#define ITTDPRINTMETHODNAME() ITTDPRINT(@"%s", __PRETTY_FUNCTION__)

// Log-level based logging macros.
#if ITTLOGLEVEL_ERROR <= ITTMAXLOGLEVEL
#define ITTDERROR(xx, ...)  ITTDPRINT(xx, ##__VA_ARGS__)
#else
#define ITTDERROR(xx, ...)  ((void)0)
#endif

#if ITTLOGLEVEL_WARNING <= ITTMAXLOGLEVEL
#define ITTDWARNING(xx, ...)  ITTDPRINT(xx, ##__VA_ARGS__)
#else
#define ITTDWARNING(xx, ...)  ((void)0)
#endif

#if ITTLOGLEVEL_INFO <= ITTMAXLOGLEVEL
#define ITTDINFO(xx, ...)  ITTDPRINT(xx, ##__VA_ARGS__)
#else
#define ITTDINFO(xx, ...)  ((void)0)
#endif

#ifdef ITTDEBUG
#define ITTDCONDITIONLOG(condition, xx, ...) { if ((condition)) { \
ITTDPRINT(xx, ##__VA_ARGS__); \
} \
} ((void)0)
#else
#define ITTDCONDITIONLOG(condition, xx, ...) ((void)0)
#endif

#define ITTAssert(condition, ...)                                       \
do {                                                                      \
if (!(condition)) {                                                     \
[[NSAssertionHandler currentHandler]                                  \
handleFailureInFunction:[NSString stringWithUTF8String:__PRETTY_FUNCTION__] \
file:[NSString stringWithUTF8String:__FILE__]  \
lineNumber:__LINE__                                  \
description:__VA_ARGS__];                             \
}                                                                       \
} while(0)



#define _po(o) DLOG(@"%@", (o))
#define _pn(o) DLOG(@"%d", (o))
#define _pf(o) DLOG(@"%f", (o))
#define _ps(o) DLOG(@"CGSize: {%.0f, %.0f}", (o).width, (o).height)
#define _pr(o) DLOG(@"NSRect: {{%.0f, %.0f}, {%.0f, %.0f}}", (o).origin.x, (o).origin.x, (o).size.width, (o).size.height)

#define DOBJ(obj)  DLOG(@"%s: %@", #obj, [(obj) description])

#define MARK    NSLog(@"\nMARK: %s, %d", __PRETTY_FUNCTION__, __LINE__)


//SQLite打印
#define SQLLog(sql)   NSLog(@"************SQL语句************\n\n%@\n\n******************************",sql)


//////////单例//////////
#undef	AS_SINGLETON
#define AS_SINGLETON( __class ) \
- (__class *)sharedInstance; \
+ (__class *)sharedInstance;
#undef	DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
- (__class *)sharedInstance \
{ \
return [__class sharedInstance]; \
} \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[[self class] alloc] init]; } ); \
return __singleton__; \
}


//  粗体字
#define kBoldTextFont(a) [UIFont boldSystemFontOfSize:a]
//  细体字
#define kLightTextFont(a) [UIFont systemFontOfSize:a]

#define iPhone5RealSize CGSizeMake(640,1136)
#define iPhone6RealSize CGSizeMake(750,1334)
#define iPhone6PlusRealSize CGSizeMake(1242,2208)
#define RespondToSel_CurrMode [UIScreen instancesRespondToSelector:@selector(currentMode)]
#define CurrentDeviceRealSize [[[UIScreen mainScreen] currentMode] size]
//是否为iphone5 的尺寸
#define iPhone5 (RespondToSel_CurrMode && CGSizeEqualToSize(iPhone5RealSize, CurrentDeviceRealSize))
#define iPhone6 (RespondToSel_CurrMode && CGSizeEqualToSize(iPhone6RealSize, CurrentDeviceRealSize))
#define iPhone6Plus (RespondToSel_CurrMode && CGSizeEqualToSize(iPhone6PlusRealSize, CurrentDeviceRealSize))


#define FONT_LIGHT(a) [ToolUtils getLightFontSize:a]
#define FONT_BOLD(a) [ToolUtils getBlodFontSize:a]
//默认字体大小

#define default_font6 FONT_LIGHT(6)
#define default_font7 FONT_LIGHT(7)
#define default_font8 FONT_LIGHT(8)
#define default_font10 FONT_LIGHT(10)
#define default_font12 FONT_LIGHT(12)
#define default_font13 FONT_LIGHT(13)
#define default_font14 FONT_LIGHT(14)
#define default_font15 FONT_LIGHT(15)
#define default_font16 FONT_LIGHT(16)
#define default_font18 FONT_LIGHT(18)
#define default_font20 FONT_LIGHT(20)
#define default_font25 FONT_LIGHT(25)
#define default_font40 FONT_LIGHT(40)
#define default_font60 FONT_LIGHT(60)

#define default_font8_bold FONT_BOLD(8)
#define default_font10_bold FONT_BOLD(10)
#define default_font12_bold FONT_BOLD(12)
#define default_font13_bold FONT_BOLD(13)
#define default_font14_bold FONT_BOLD(14)
#define default_font15_bold FONT_BOLD(15)
#define default_font16_bold FONT_BOLD(16)
#define default_font18_bold FONT_BOLD(18)
#define default_font20_bold FONT_BOLD(20)
#define default_font25_bold FONT_BOLD(25)
#define default_font35_bold FONT_BOLD(35)
#define default_font40_bold FONT_BOLD(40)
#define default_font60_bold FONT_BOLD(60)


/* 常用属性设置 */
#define default_color_clean [UIColor clearColor]
#define default_color_white [ToolUtils colorWithHexString:@"#ffffff"]               //白色
#define default_color_black [ToolUtils colorWithHexString:@"#000000"]               //字体黑色
#define default_color_black_mid [ToolUtils colorWithHexString:@"#3f3f3f"]           //字体中黑色
#define default_color_gray [ToolUtils colorWithHexString:@"#9c9c9c"]                //字体灰色
#define default_color_gray_mid [ToolUtils colorWithHexString:@"#c8c8c8"]            //输入灰色
#define default_color_line [ToolUtils colorWithHexString:@"#d9d9d9"]                //线条颜色
#define default_color_red [ToolUtils colorWithHexString:@"#fe4318"]                 //红色
#define default_color_green [ToolUtils colorWithHexString:@"#6cb022"]               //绿色
#define default_color_green_prePrice [ToolUtils colorWithHexString:@"#7cc464"]      //绿色-预付款
#define default_color_green_zm [ToolUtils colorWithHexString:@"#51baa6"]            //草绿色，芝麻信用分
#define default_color_green_name [ToolUtils colorWithHexString:@"#0b9cbb"]          //蓝绿色，男用户名
#define default_color_blue [ToolUtils colorWithHexString:@"#2b80f3"]                //天蓝色
#define default_color_blue_mid [ToolUtils colorWithHexString:@"#3194d2"]            //浅蓝色（高亮）
#define default_color_orange [ToolUtils colorWithHexString:@"#fe7418"]              //橙色
#define default_color_bg_view [ToolUtils colorWithHexString:@"#f3f3f3"]             //底色
#define default_color_purple [ToolUtils colorWithHexString:@"#e946bd"]              //紫色

#define default_color_segment_unsel [ToolUtils colorWithHexString:@"#f9ccab"]
#define default_color_segment_sel [ToolUtils colorWithHexString:@"#ffffff"]
#define default_color_segment_bg [ToolUtils colorWithHexString:@"#f38e28"]
#define default_color_segment_line [ToolUtils colorWithHexString:@"#E75628"]

#define default_color_cell_status_red [ToolUtils colorWithHexString:@"#f1503a"]
#define default_color_cell_status_orange [ToolUtils colorWithHexString:@"#f38e28"]
#define default_color_cell_status_black [ToolUtils colorWithHexString:@"#737373"]

#define default_color_cell_line [ToolUtils colorWithHexString:@"#c4c4c4"]

#define default_color_msg_subTitle [ToolUtils colorWithHexString:@"#808080"]


/* 快捷宏 */

//string是否为空
#define isEmptyString(string) [ToolUtils isEmpty:string]

//array是否为空
#define isEmptyArray(array) [ToolUtils isEmptyArray:array]

//keyWindow
#define appKeyWindow [UIApplication sharedApplication].keyWindow

//类名
#define selfClassName NSStringFromClass(self.class)

//UserDefaults
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

//打印
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#   define NSLog(...)
#endif


#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;


#define SMALL_BORDER_WIDTH 8.0
#define BIG_BORDER_WIDTH   16.0

#define STORYBOARD(NAME) [UIStoryboard storyboardWithName:(NAME) bundle:[NSBundle mainBundle]]
#define UINIB(NAME)      [UINib nibWithNibName:(NAME) bundle:[NSBundle mainBundle]]

#endif

