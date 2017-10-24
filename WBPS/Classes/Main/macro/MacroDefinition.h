//
//  MacroDefinition.h
//  MacroDefinitionDemo
//
//  Created by 新风作浪 on 13-6-9.
//  Copyright (c) 2013年 SpinningSphere Labs. All rights reserved.
//

#ifndef MacroDefinition_h
#define MacroDefinition_h

////-------------------全局头文件-------------------------
#import "QLFactory.h"
#import "UITextField+Extension.h"
#import "UIView+frame.h"
#import "UIImageView+Extension.h"
#import "UIButton+Extension.h"
#import "UILabel+Extension.h"
#import "UIBarButtonItem+Extension.h"
#import "QLRegularTool.h"
#import "MBProgressHUD+Extension.h"
#import "QLMD5.h"
#import "NSDate+Extension.h"
#import "UINavigationBar+Extension.h"
#import "NSString+Extension.h"
#import "AppDelegate.h"
#import "LWLocationManager.h"
#import "NetWorkingManager.h"
#import "BasicViewController.h"
#import "BasicNavigationVontroller.h"

#import "LeftSlideMenuView.h"
#import "UserAndCarStateEditView.h"
#import "SuspensionView.h"

#import "CameraCropOverlay.h"  //图片剪切

/** 用户数据模型 */
#import "UserModel.h"
#import "AccessTool.h"


/** 空数据视图 */
#import "DataNullView.h"



/*   --- -  --- - - --系统库 -- - -- - - --- - -*/
#import <AVFoundation/AVFoundation.h>  //多媒体框架
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVAudioSession.h>


//-------------------第三方框架-------------------------
#import <AMapNaviKit/AMapNaviKit.h>
#import <TZImagePickerController.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapNaviKit/AMapNaviKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

#import <UIImageView+WebCache.h>
#import <SDWebImageManager.h>
#import <UIImageView+AFNetworking.h>
#import <Masonry.h>
#import <MJExtension.h>
//#import "WMPageController.h"
#import <MJRefresh.h>
#import <AFNetworking.h>
#import "IQKeyboardManager.h"
//#import "MWPhotoBrowser.h"

// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif


//-------------------获取设备大小-------------------------
//NavBar高度
#define NavigationBar_HEIGHT 44
//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

/** 根据当前手机是否是iPhone X来处理头部高度 */
#define TopHeight iPhoneX?84:64

#define iPhoneX      [UIScreen mainScreen].bounds.size.width == 375 && [UIScreen mainScreen].bounds.size.height == 812


//-------------------适配-------------------------

#define SCRXFrom6(x) ([UIScreen mainScreen].bounds.size.width / 360.0f * (x))
#define SCRYFrom6(y) ([UIScreen mainScreen].bounds.size.height / 640.0f * (y))

//-------------------常用-------------------------
/** 底部按钮高度 */
#define Bottom_Button_Height 40

#define FONT [UIFont systemFontOfSize:15]

#define FONTS(size) [UIFont systemFontOfSize:(size)]

#define BOLDFONTS(size) [UIFont boldSystemFontOfSize:(size)]

#define WS(weakself) __weak __typeof(&*self)weakself = self

/********** 字体、字号、字色相关 **********/
#define Title_Font @"Thonburi-Bold"  //标题
#define UserName_Font @"Arial-BoldMT"   //名字
#define Common_Font @"common"   //常规

#define Button_Size_Font 20  //按钮
#define Title_Size_Font 14  //标题 &&名字
#define Text_Size_Font 12  //文本
#define Note_Size_Font 9  //注释

#define Text_Color_One UIColorFromRGB(0x303030)  //主要字体颜色
#define Text_Color_Two UIColorFromRGB(0x635E5E)  //(文本，描述）
#define Text_Color_Three UIColorFromRGB(0x9A9A9A)  //（输入框文字/辅助性文字）
#define Text_Color_Four UIColorFromRGB(0xF78830)  //有响应的文本或需要突出信息内容的地方 橘色



/********** 颜色 **********/

/** 黑色 */
#define Black_Color UIColorFromRGB(0x3B3E40)

/** 红色 */
#define Red_Color UIColorFromRGB(0xFF0000)
/** 白色 */
#define White_Color UIColorFromRGB(0xffffff)

/** 字体灰色 */
#define FontGray_Color UIColorFromRGB(0xABABAB)
/** 浅灰色 */
#define LightGray_Color UIColorFromRGB(0xE8E8E8)
/** 线条灰色 */
#define LineGray_Color UIColorFromRGB(0xEFEFEF)
/** 按钮深灰 */
#define DarkGray_Color UIColorFromRGB(0x97948C)
/** 灰色边框色 */
#define BorderGray_Color  [[UIColor grayColor]CGColor]
//-------------------打印日志-------------------------
//DEBUG  模式下打印日志,当前行
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif


//重写NSLog,Debug模式下打印日志和当前行数
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

//DEBUG  模式下打印日志,当前行 并弹出一个警告
#ifdef DEBUG
#   define ULog(fmt, ...)  { UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%s\n [Line %d] ", __PRETTY_FUNCTION__, __LINE__] message:[NSString stringWithFormat:fmt, ##__VA_ARGS__]  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]; [alert show]; }
#else
#   define ULog(...)
#endif


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

//---------------------打印日志--------------------------


//----------------------系统----------------------------

//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion [[UIDevice currentDevice] systemVersion]
#define IS_IOS10_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)

//获取当前语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//国际化
#define WJLocalizedString(key) [NSBundle.mainBundle localizedStringForKey:(key) value:@"" table:nil]

//判断是否 Retina屏、设备是否%fhone 5、是否是iPad
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)


//判断是真机还是模拟器
#if TARGET_IPHONE_SIMULATOR
#define SIMULATOR 1
#elif TARGET_OS_IPHONE
#define SIMULATOR 0
#endif



//检查系统版本
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


//----------------------系统----------------------------


//----------------------内存----------------------------

//使用ARC和不使用ARC
#if __has_feature(objc_arc)
//compiling with ARC
#else
// compiling without ARC
#endif

#pragma mark - common functions
#define RELEASE_SAFELY(__POINTER) { [__POINTER release]; __POINTER = nil; }

//释放一个对象
#define SAFE_DELETE(P) if(P) { [P release], P = nil; }

#define SAFE_RELEASE(x) [x release];x=nil



//----------------------内存----------------------------


//----------------------图片----------------------------

//读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

//定义UIImage对象
#define IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]

//定义UIImage对象
#define ImageNamed(_pointer) [UIImage imageNamed:[UIUtil imageName:_pointer]]

//定义UIImage对象
#define UIImageName(name) [UIImage imageNamed:name]
//建议使用前两种宏定义,性能高于后者
//----------------------图片----------------------------



//----------------------颜色类---------------------------
// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//带有RGBA的颜色设置
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

//背景色
#define BACKGROUND_COLOR [UIColor colorWithRed:242.0/255.0 green:236.0/255.0 blue:231.0/255.0 alpha:1.0]

//清除背景色
#define CLEARCOLOR [UIColor clearColor]

#pragma mark - color functions
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
// 随机色
#define RandomCOLOR RGBCOLOR(arc4random_uniform(256),arc4random_uniform(256),arc4random_uniform(256))

//----------------------颜色类--------------------------



//----------------------其他----------------------------

//方正黑体简体字体定义
//#define FONT(F) [UIFont fontWithName:@"FZHTJW--GB1-0" size:F]



//设置View的tag属性
#define VIEWWITHTAG(_OBJECT, _TAG)    [_OBJECT viewWithTag : _TAG]
//程序的本地化,引用国际化的文件
#define MyLocal(x, ...) NSLocalizedString(x, nil)

//G－C－D
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

//NSUserDefaults 实例化
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]


//由角度获取弧度 有弧度获取角度
#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)



//单例化一个类
#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
\
static classname *shared##classname = nil; \
\
+ (classname *)shared##classname \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [[self alloc] init]; \
} \
} \
\
return shared##classname; \
} \
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [super allocWithZone:zone]; \
return shared##classname; \
} \
} \
\
return nil; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return self; \
}



#endif
