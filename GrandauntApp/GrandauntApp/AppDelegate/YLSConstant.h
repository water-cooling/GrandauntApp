//
//  Header.h
//  YLSC_New
//
//  Created by 姜昊池 on 2019/7/17.
//  Copyright © 2019 yltx. All rights reserved.
//

#ifndef Header_h
#define Header_h

#pragma mark ThirdClassKey
#define kImageOSSAddressForHttp              @"http://yltx-x.oss-cn-hangzhou.aliyuncs.com/"
#define kImageOSSAddressHeadForHttp          @"http://oss-cn-hangzhou.aliyuncs.com/"

//OSS 路径
#define kOSSBULKETKEY                        @"lordfund"
#define kOSSDOMAINURL                        @"oss-cn-hangzhou.aliyuncs.com"
#define kOSSIMAGEBASEFILEURL                 [NSString stringWithFormat:@"http://%@.%@/",kOSSBULKETKEY,kOSSDOMAINURL]


#define BAIDUAPIKEY                         @"GGwaeRHdxCIybXo4HRpoUBM8nRUwooAp"
#define TTS_APP_ID               @"11463548"
#define TTS_API_KEY              @"GGwaeRHdxCIybXo4HRpoUBM8nRUwooAp"
#define TTS_SECRET_KEY           @"2RU3FjAkLQzod6vwUl2epv5mkyYYKBLp"
#define BAIDUSecretKey
#define JPUSHKEY                            @"0fcbe09829e4b4779f1a7da1"
#define WXAPPID                             @"wx9aecd959b5f7e62a"
//发送通知的宏定义
#define AlipayNotification                  @"AlipayNotification"
#define AliAuthNotification                  @"AliAuthNotification"
#define WXPayNotification                   @"WXPayNotification"
#define WXAuthNotification                   @"WXAuthNotification"
#define WXShareNotication                   @"WXShareNotification"
#define ShoppingCartNotification            @"ShoppingCartNotification"
#define ProductOrderReFreshNotification     @"ProductOrderReFreshNotification"
#define FillOilOrderRefreshNotification     @"FillOilOrderRefreshNotification"
#define FuelCardRefreshNotification         @"FuelCardRefreshNotification"
#define RechageRefreshNotification          @"RechageRefreshNotification"
#define MyNotificationIsReadNotification    @"MyNotificationIsReadNotification"
#define YlscAuthYltxLoginSuccessNotification @"YlscAuthYltxLoginSuccessNotification"
#define TxFaceResultNotification @"TxFaceResultNotification"


//#define UMengKey @"5bfe07b5f1f556075b0004ec"
#define UMengKey @"5dc36d6a4ca3572510000147"
//腾讯实名认证的key
// 测试
//#define LICENCE @"eZDPQz+ogUe82S/Y7XSVjOFFY15jAR5VmCYWyqh/OIJHj6Fmzdsqdw863k0XilOw1LFgmoHhI11Zp0eU0emKz48E4GuNpW+fdrrwr7dXtfnyhPnzKxObA982dPu3ZydEtuwwDB8EjGaPmu0DD0l7FYJv5doD0NiEfd/KdBmBp/OKx5eH2rMY1lw8dKYzT5q2TrfmD/Bzgv3tlJNxi7GJVZMKPJqYK+7yUrQL/IrN7w3YoxOrofYNUxb50dX3G0gzne2kAqx8EFfk4PrP+cucGdIeXjovpQbmd8Dam/fHtKi9A1OvdI0xL3XKWmyUuvRJoBwavMneTXtZxhz5W5NOZQ=="
//#define TxAPPId @"TIDA1Oe4"

// 生产
#define LICENCE @"ioLwDWXIOqxY+Y2DmrKjOMLo3JuT93XCBqz4hYQzqHruYtHsXXI8xnALrdAAuJmsAucD/hT9mUDAyzMnfApHWVxj7teXppQC256uIMi3BA/fFUWdgqTlmGGy0qHuvt3PN5KzI/wOlSuUA+zeg9Hdj3kXhKV45mDiGKUbvu0FjKGKx5eH2rMY1lw8dKYzT5q2TrfmD/Bzgv3tlJNxi7GJVZMKPJqYK+7yUrQL/IrN7w3YoxOrofYNUxb50dX3G0gzne2kAqx8EFfk4PrP+cucGdIeXjovpQbmd8Dam/fHtKi9A1OvdI0xL3XKWmyUuvRJoBwavMneTXtZxhz5W5NOZQ=="
#define TxAPPId @"IDA0lWUz"

#pragma mark - constant

#define YLTXSTORYBOARD  [UIStoryboard storyboardWithName:@"YLTX" bundle:nil]
#define YLSPSTORYBOARD  [UIStoryboard storyboardWithName:@"YLSP" bundle:nil]
#define YLHHRSTORYBOARD  [UIStoryboard storyboardWithName:@"YLHHR" bundle:nil]
#define NAVHIGH           (IPHONEX?88.f:64.f)
#define TabbarSafeBottomMargin  (IPHONEX ? 34.f : 0.f)
#define RatioW(x)  (double)x * kMulriple

#pragma mark - typedef block
typedef void (^emptyHandler)(void);

#pragma mark - method
#define DOUBLESTR(_double_) [NSString stringWithFormat:@"%.2f",_double_]

#define ViewHeight kHeight
#define ViewWidth kWight
#define kWight [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define kMulriple [UIScreen mainScreen].bounds.size.width / 375.0
#define kMulripleX ([UIScreen mainScreen].bounds.size.width / 375.0)
#define kMulripleY ([UIScreen mainScreen].bounds.size.height / 667.0)
#define kmyWight(VIEW) VIEW.frame.size.width
#define kmyHeight(VIEW) VIEW.frame.size.height

#define K_DEFULT(x) (x ? x : @"")
//屏幕适配
/*
 iphoneXS       375*812
 iphoneXS MAX   375*812
 iphoneXR       375*812
 iphone8P       414*736
 iphone8        375*667
 */
#define GetWidth(markWidth)        markWidth/375.0*[UIScreen mainScreen].bounds.size.width
#define GetHeight(markHeight)     markHeight/667.0*[UIScreen mainScreen].bounds.size.height

#define OBJC_CLASS(_ref) NSClassFromString(NSStringFromClass(_ref))

//app
#define MainBundle()                                ([NSBundle mainBundle])
#define PathForBundleResource(resName, resType)     [MainBundle() pathForResource:(resName) ofType:(resType)]
#define URLForBundleResource(resName, resType)      [MainBundle() URLForResource:(resName) \
withExtension:(resType)]
#define APPDisplayName()                            [MainBundle() \
objectForInfoDictionaryKey:@"CFBundleDisplayName"]
#define AppBundleIdentifier()                       [MainBundle() \
objectForInfoDictionaryKey:@"CFBundleIdentifier"]
#define AppReleaseVersionNumber()                   [MainBundle() \
objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
#define AppBuildVersionNumber()                     [MainBundle() objectForInfoDictionaryKey:@"CFBundleVersion"]
#define  adjustsScrollViewInsets(scrollView)\
do {\
_Pragma("clang diagnostic push")\
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")\
if ([scrollView respondsToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
NSMethodSignature *signature = [UIScrollView instanceMethodSignatureForSelector:@selector(setContentInsetAdjustmentBehavior:)];\
NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];\
NSInteger argument = 2;\
invocation.target = scrollView;\
invocation.selector = @selector(setContentInsetAdjustmentBehavior:);\
[invocation setArgument:&argument atIndex:2];\
[invocation retainArguments];\
[invocation invoke];\
}\
_Pragma("clang diagnostic pop")\
} while (0)
//判断系统
#define IsIOS6 (([[[UIDevice currentDevice] systemVersion] floatValue] >=6.0 &&[[[UIDevice currentDevice] systemVersion] floatValue] <7.0) ? YES : NO)
#define IsIOS7 (([[[UIDevice currentDevice] systemVersion] floatValue] >=7.0 &&[[[UIDevice currentDevice] systemVersion] floatValue] <8.0) ? YES : NO)
#define IsIOS8 (([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0 &&[[[UIDevice currentDevice] systemVersion] floatValue] <9.0) ? YES : NO)

#define IsIOS8AndLater (([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0) ? YES : NO)
#define IsIOS11AndLater (([[[UIDevice currentDevice] systemVersion] floatValue] >=11.0) ? YES : NO)

#define IOS8_OR_LATER    ( [[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending )
#define IOS7_OR_LATER    ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define IOS6_OR_LATER    ( [[[UIDevice currentDevice] systemVersion] compare:@"6.0"] != NSOrderedAscending )
//环信颜色
#define TEXT_COLOR [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]
//判断是否是6P
#define IsIphone6Plus  ([[Common platformString] isEqualToString:@"iPhone6_Plus"]||[[Common platformString] isEqualToString:@"iPhone6_PlusS"])

#define IsIphone6  ([[Common platformString] isEqualToString:@"iPhone6"]||[[Common platformString] isEqualToString:@"iPhone6S"])

#define IsIphone5s  ([[Common platformString] isEqualToString:@"iPhone5S"])

#define iPhone5C    ([[Common platformString] isEqualToString:@"iPhone5C"])

#define iPhone4S    ([[Common platformString] isEqualToString:@"iPhone4S"]||[[Common platformString] isEqualToString:@"iPhone5"])

#define IsIphone6Or6P  ([[Common platformString] isEqualToString:@"iPhone6"] || [[Common platformString] isEqualToString:@"iPhone6_Plus"])

#define Not6PParse(_ref)  [Common parseWhenNot6P:_ref]

/** 设备是否为iPhone 4/4S 分辨率320x480，像素640x960，@2x */
#define iPhone4Size ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

/** 设备是否为iPhone 5C/5/5S 分辨率320x568，像素640x1136，@2x */
#define iPhone5Size ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

/** 设备是否为iPhone 6 分辨率375x667，像素750x1334，@2x */
#define iPhone6Size ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

/** 设备是否为iPhone 6 Plus 分辨率414x736，像素1242x2208，@3x */
#define iPhone6PSize ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define PhoneUUIDString    [[[UIDevice currentDevice] identifierForVendor] UUIDString] ?[[[UIDevice currentDevice] identifierForVendor] UUIDString] : @""
#define KeyChainUUID [Common getUUIDByKeyChain]
//断言加返回
#define SitAbort       HCAbort();return;
#define SitAbortNil    HCAbort();return nil;
//打印相关
#define MOCLogDebug(_ref)  NSLog(@"%@ %@ %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd),_ref);

//打印日志
#ifdef kSitTest
#define WYLog(...) NSLog(__VA_ARGS__)
#else
#ifdef kTestUse
#define WYLog(...) NSLog(__VA_ARGS__)
#else
#define WYLog(...)  NSLog(__VA_ARGS__)/* 临时打开*/
#endif
#endif

#define WYWeakSelfDefine __weak __typeof(&*self) weakSelf = self

#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif


//定义keyWindow宏
#define KEYWINDOWS [UIApplication sharedApplication].keyWindow

//定义rootViewController宏
#define ROOTVIEWCONTROLLER [UIApplication sharedApplication].keyWindow.rootViewController

//定义最顶层的DISPLAYVIEWCONTROLLER，如果是present出来的Viewcontroller，windows栈中展示给用户看的rootviewcontroller
#define DISPLAYVIEWCONTROLLER ((UIWindow *)[[UIApplication sharedApplication].windows lastObject]).rootViewController
//NAVI背景颜色
#define CUSTOMNAVIGATIONCOLOR  [UIColor colorWithHexString:@"#f13a3a"]
#define DefeatColor  [UIColor colorWithHexString:@"FEAF59"]

#define CUSTOMNAVIGATIONCOLORALPHA  RGBA(245,75,106,1)
//计算颜色
#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
//Use HEX color value with 0x000000 format
#define RGBColor(rgbValue, alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]

//Label自适应宽高
#define LabelSize(label,W,H) [label.text boundingRectWithSize:CGSizeMake(W,H) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: label.font} context:nil].size

//String自适应宽高
#define StringSize(String,W,H,Font) [String boundingRectWithSize:CGSizeMake(W,H) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:Font]} context:nil].size

#define kFont(float) [UIFont systemFontOfSize:float]
#define KSemiblodFont(float) [UIFont fontWithName:@"PingFangSC-Semibold" size:float];

//图片高度PX
#define SCREENHEIGHTPX(X) (SCREENWIDTH*(X)/750.0)

#define SCREENFRAME [[UIScreen mainScreen] bounds]  // 当前屏幕frmae
#define SCREENWIDTH SCREENFRAME.size.width          // 当前屏幕宽度
#define SCREENHEIGHT SCREENFRAME.size.height        // 当前屏幕高度
#define SCREEN_MAX_LENGTH (MAX(SCREENWIDTH, SCREENHEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREENWIDTH, SCREENHEIGHT))
#define kTabBarH        49.0f
#define kStatusBarH     20.0f
#define kNavigationBarH 44.0f
// View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]



#ifndef judgeEmpty
#define judgeEmpty
///是否为空或是[NSNull null]
#define NotNilAndNull(_ref)  (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]))
#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))
///字符串是否为空
#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]))

//NSString为空返回
#define StrEmptyReturn(_ref,_message)    if(((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""])) {[self alertMessage:_message];return;}

//组装String
#define MontageStr(_a,_b)  [NSString stringWithFormat:@"%@/%@",_a,_b]

///数组是否为空
#define IsArrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref) count] == 0))

#define    __STRINGNOTNIL( __x )   (__x?__x:@"")

#endif

///线程执行方法 GCD
#define PERFORMSEL_BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define PERFORMSEL_SYNC_BACK(block) dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define PERFORMSEL_MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

//图片
#define BundleImageNamed(_pointer) [UIImage imageNamed:[UIUtil imageName:_pointer]]
#define IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]

#define kImage(name) [UIImage imageWithNamed:name]

//CoreData
#define main_managed_object_context [NSManagedObjectContext MR_defaultContext]
#define main_managed_object_context_save() [main_managed_object_context MR_saveToPersistentStoreAndWait]
#define non_main_managed_object_context_save(context)  [context MR_saveToPersistentStoreAndWait]


#define DEVICE_TOKEN @"DEVICE_TOKEN"

//环信============================================================================================================
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define KNOTIFICATION_LOGINCHANGE @"loginStateChange"
#define CHATVIEWBACKGROUNDCOLOR [UIColor colorWithRed:0.936 green:0.932 blue:0.907 alpha:1]
//环信============================================================================================================

typedef void (^VoidBlock) (void);

static inline void  mainBlock(VoidBlock block){
    //通知主线程刷新
    dispatch_async(dispatch_get_main_queue(), ^{
        //回调或者说是通知主线程刷新，
        block();
    });
}

//异步操作
static inline void  asynchronousBlock(VoidBlock block){
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 处理耗时操作的代码块...
        block();
    });
}


typedef enum
{
    ShareTypeAddOilType = 0,
    ShareTypeFillGasType,
    ShareTypeGiftCardType,
    ShareTypeStoreValueCardType,
    ShareTypeProductType
} ShareType;

//custom
#define zNoParam                        [NSMutableDictionary dictionary]
#define zStrVal(str)                    ([str isKindOfClass:NSNull.class] || !str)?@"":str
#define zNumStrVal(num)                 ([num isKindOfClass:NSNull.class] || !num)?@"0":num
#define zModel                            weakSelf.model
#define NavBarHeight 44
#define zScreen_Bounds           [UIScreen mainScreen].bounds
#define zScreen_Width            [UIScreen mainScreen].bounds.size.width
#define zScreen_Height           [UIScreen mainScreen].bounds.size.height
#endif /* Header_h */
