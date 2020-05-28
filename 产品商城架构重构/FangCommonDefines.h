//
//  FangCommonDefines.h
//  Bang
//
//  Created by 邱 育良 on 17/4/27.
//  Copyright © 2017年 www.fang.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef FangCommonDefines_h
#define FangCommonDefines_h

#pragma mark - 颜色初始化
/** 十六进制颜色 */
#define UIColorMake(hex) UIColorAlphaMake(hex, 1)
/** 十六进制颜色(alpha) */
#define UIColorAlphaMake(hex, alpha) UIColorRGBAMake((hex & 0xFF0000) >> 16, (hex & 0xFF00) >> 8, hex & 0xFF, alpha)
/** RGB颜色 */
#define UIColorRGBMake(r, g, b) UIColorRGBAMake(r, g, b, 1)
/** RGB颜色(alpha) */
#define UIColorRGBAMake(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/1.0]
/** 字号初始化 */
#define UIFontMake(fontSize) [UIFont systemFontOfSize:fontSize]

#define UIFontWeightMake(fontSize, w) (iOS(9) ? [UIFont systemFontOfSize:fontSize weight:w] : UIFontMake(fontSize))

#define UIFontWeightRegularMake(fontSize) UIFontWeightMake(fontSize, UIFontWeightRegular)
#define UIFontWeightUltraLightMake(fontSize) UIFontWeightMake(fontSize, UIFontWeightUltraLight)
#define UIFontWeightThinMake(fontSize) UIFontWeightMake(fontSize, UIFontWeightThin)
#define UIFontWeightLightMake(fontSize) UIFontWeightMake(fontSize, UIFontWeightLight)
#define UIFontWeightMediumMake(fontSize) UIFontWeightMake(fontSize, UIFontWeightMedium)
#define UIFontWeightSemiboldMake(fontSize) UIFontWeightMake(fontSize, UIFontWeightSemibold)

/** 图片初始化 */
#define UIImageMake(img) [UIImage imageNamed:img]
#define UIOriginalImageMake(img) [UIImageMake(img) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
/** 一像素 */
#define PixelOne 1 / [[UIScreen mainScreen] scale]

#pragma mark - debug

//A better version of NSLog
//#define NSLog(format, ...) do {                                                                          \
//                             fprintf(stderr, "<%s : %d> %s\n",                                           \
//                             [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
//                             __LINE__, __func__);                                                        \
//                             (NSLog)((format), ##__VA_ARGS__);                                           \
//                             fprintf(stderr, "-------\n");                                               \
//                           } while (0)


#define NSLogRect(rect) NSLog(@"%s x:%.4f, y:%.4f, w:%.4f, h:%.4f", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
#define NSLogSize(size) NSLog(@"%s w:%.4f, h:%.4f", #size, size.width, size.height)
#define NSLogPoint(point) NSLog(@"%s x:%.4f, y:%.4f", #point, point.x, point.y)

#pragma mark - oldDefine

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
//by yanhongjun
#define ISFOURINCH (CGSizeEqualToSize(CGSizeMake(320, 568),[[UIScreen mainScreen] bounds].size)?YES: NO)

#define iOS(version) (([[[UIDevice currentDevice] systemVersion] intValue] >= version)?1:0)

//RGB色值
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
//十六进制色值,hexString前加0x
#define HEXCOLOR(hexString) [UIColor colorWithRed:((float)((hexString & 0xFF0000) >> 16))/255.0 green:((float)((hexString & 0xFF00) >> 8))/255.0 blue:((float)(hexString & 0xFF))/255.0 alpha:1.0]
#define TABLEBGCOLOR UIColorMake(0xfafafa)
//状态栏高度(标准方法)
#define STATUSBARHEIGHT [UIApplication sharedApplication].statusBarFrame.size.height
//状态栏高度
#define STATUSBAR_HEIGHT 20.0f
//导航栏高度self.navigationController.navigationBar.frame.size.height
#define NAVIGATIONBAR_HEIGHT 44.0f
//屏幕宽度
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
//屏幕高度
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

//status bar, navigation bar 以及底部bar(iPhoneX系列底部34)高度
#define STATUS_BAR_HEIGHT ([[UIApplication sharedApplication] statusBarFrame].size.height)
#define NAVIBAR_HEIGHT (self.navigationController.navigationBar.frame.size.height)
#define SCREEN_TOP_BAR_HEIGHT ((STATUS_BAR_HEIGHT)+(NAVIBAR_HEIGHT))//顶部bar高度
#define SCREEN_BOTTOM_BAR_HEIGHT (FangiPhoneXSeries?34:0)//底部bar高度
#define BAR_HEIGHT ((SCREEN_TOP_BAR_HEIGHT) + (SCREEN_BOTTOM_BAR_HEIGHT)) //bar总高度

// 状态栏高度
#define FIT_STATUSBAR_HEIGHT (FangiPhoneXSeries ? 44.f : 20.f)
// 导航栏高度
#define FIT_NAVIGATION_BAR_HEIGHT (FangiPhoneXSeries ? 88.f : 64.f)
// tabBar高度
#define FIT_TAB_BAR_HEIGHT (FangiPhoneXSeries ? (49.f+34.f) : 49.f)
// 底部安全区域
#define FIT_BOTTOMSAFE_HEIGHT (FangiPhoneXSeries ? 34.f : 0.f)
// 状态栏差
#define FIT_STATUSBAR_MISTAKE (FangiPhoneXSeries ? 24.f : 0.f)

///weakself（block 用） 黄雷2015.8.26添加
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

//非全屏布局不带TabBar的TableView高度(iOS7以下)
#define TABLEVIEW_HEIGHT_WITHOUT_TABBAR SCREEN_HEIGHT - STATUSBAR_HEIGHT - NAVIGATIONBAR_HEIGHT
//默认TableView规格
#define TABLEVIEW_BOUNDS CGRectMake(0, 0, SCREEN_WIDTH, TABLEVIEW_HEIGHT_WITHOUT_TABBAR)


//新房帮添加
//#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneUIViewHeight ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) ? 548 : 460) : 460)

//适配
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define WidthScale [UIScreen mainScreen].bounds.size.width/320///宽比例系数
#define HeightScale (iPhone4?([UIScreen mainScreen].bounds.size.height/480):([UIScreen mainScreen].bounds.size.height/568))

//适配添加 昌+++++
#define KSCREENSIZE ([UIScreen mainScreen].applicationFrame.size)  //屏幕尺寸
#define KSCREEN_WIDTH ([UIScreen mainScreen].applicationFrame.size.width)
#define KSCREEN_HEIGHT ([UIScreen mainScreen].applicationFrame.size.height)


#define SECRETSTRING @"-|1^:9HgZ6u};pY"


/*
 a、1Point的线在非Retina屏幕则是一个像素，在Retina屏幕上则可能是2个像素（非6plus）或者3个像素（6plus），取决于系统设备的DPI。
 
 b、所以在非6plus屏幕上1像素我们需要当成 1.0/2 = 0.5 来处理。系统绘制的时候再乘上[UIScreen mainScreen].scale得到像素数去绘制。
 
 c、6plus上则需要1.0/3来处理。如果继续用0.5系统绘制时会有0.5像素的问题，系统会采用“antialiasing(反锯齿)”的技术处理，（详见http://www.cnblogs.com/smileEvday/p/iOS_PixelVsPoint.html）。所以6plus上0.5的线宽（即1.5像素）有时候是1像素有时候是2像素，取决于origin.y的不同。
 
 d、因此，有这样的宏。使用时，将所有0.5的替换成KSINGLELINE_WIDTH即可。
 */
#define KSINGLELINE_WIDTH  1.0f/([UIScreen mainScreen].scale)//1像素线宽的宏。


#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

//iphone6+ 1242, 2208; 放大模式1125, 2001
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)

//iPhoneX以上机型(包括X Xs 11系列 截止2019-11-12)
#define FangiPhoneXSeries (FangiPhoneDEVICE && FangIOS11DEVICE && (MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) >= 375 && MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) >= 812))

//iphoneX 1125x2436;
#define iPhoneX (FangiPhoneDEVICE && FangIOS11DEVICE && (MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) >= 375 && MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) >= 812))

#define iPhoneMax ((CGSizeEqualToSize(CGSizeMake(414, 896), [UIScreen mainScreen].bounds.size)) || (CGSizeEqualToSize(CGSizeMake(896, 414), [UIScreen mainScreen].bounds.size)))

#define KSOUFUN_NAV_HEIGHT  44


#endif /* FangCommonDefines_h */
