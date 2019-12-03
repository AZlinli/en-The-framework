//
//  LYRouterManager.h
//  ToursCool
//
//  Created by tourscool on 10/25/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 导航栏
 */
FOUNDATION_EXPORT NSString * _Nullable const kCurrentNavigationVCKey;
/**
 详情
 */
FOUNDATION_EXPORT NSString * _Nullable const LineDetailsViewControllerKey;
/**
 我的收藏
 */
FOUNDATION_EXPORT NSString * _Nullable const MineCollectViewControllerKey;
/**
 日期
 */
FOUNDATION_EXPORT NSString * _Nullable const SelectDateViewControllerKey;
/**
 列表
 */
FOUNDATION_EXPORT NSString * _Nullable const ProductListViewControllerKey;
/**
 优惠券
 */
FOUNDATION_EXPORT NSString * _Nullable const MineCouponsVTMagicControllerKey;
/**
 订单列表
 */
FOUNDATION_EXPORT NSString * _Nullable const OrderVTMagicViewControllerKey;
/**
 搜索界面
 */
FOUNDATION_EXPORT NSString * _Nullable const SearchViewControllerKey;
/**
 货币切换
 */
FOUNDATION_EXPORT NSString * _Nullable const CurrencySwitchesViewControllerKey;
/**
 意见反馈
 */
FOUNDATION_EXPORT NSString * _Nullable const FeedbackViewControllerKey;
/**
 订单详情
 */
FOUNDATION_EXPORT NSString * _Nullable const OrderDetailViewControllerKey;
/**
 支付
 */
FOUNDATION_EXPORT NSString * _Nullable const PayTypeViewControllerKey;
/**
 评论列表
 */
FOUNDATION_EXPORT NSString * _Nullable const ProductCommentListViewControllerKey;
/**
 发布评论
 */
FOUNDATION_EXPORT NSString * _Nullable const ProductPublishCommentViewControllerKey;
/**
 WebView 无任何交互
 */
FOUNDATION_EXPORT NSString * _Nullable const SafariViewControllerKey;
/**
 优惠券对应的产品列表
 */
FOUNDATION_EXPORT NSString * _Nullable const CouponProductListViewControllerKey;
/**
 攻略列表
 */
FOUNDATION_EXPORT NSString * _Nullable const StrategyListViewControllerKey;
/**
 攻略详情
 */
FOUNDATION_EXPORT NSString * _Nullable const StrategyDetailsViewControllerKey;
/**
 景区详情
 */
FOUNDATION_EXPORT NSString * _Nullable const ScenicAreaDetailsViewControllerKey;
/**
 列表
 */
FOUNDATION_EXPORT NSString * _Nullable const AllScenicAreaListViewControllerKey;
/**
 语音导览地图
 */
FOUNDATION_EXPORT NSString * _Nullable const GuideTourMapViewControllerKey;
/**
 语音导览国家列表
 */
FOUNDATION_EXPORT NSString * _Nullable const GuideTourRegionListViewControllerKey;
/**
 语音导览国家景区列表
 */
FOUNDATION_EXPORT NSString * _Nullable const GuideTourScenicAreaListViewControllerKey;
/**
目的地新首页
*/
FOUNDATION_EXPORT NSString * _Nullable const DestinationHomeViewControllerKey;

FOUNDATION_EXPORT NSString * _Nullable const WebViewControllerKey;

FOUNDATION_EXPORT NSString * _Nullable const GeneralInformationViewControllerKey;
NS_ASSUME_NONNULL_BEGIN

@interface LYRouterManager : NSObject
/**
 登陆界面

 @param currentVC VC
 @param parameter 参数
 */
+ (void)openReconstructionLoginTypeViewControllerWithCurrentVC:(UIViewController *)currentVC parameter:(NSDictionary * _Nullable)parameter;
/**
 详情界面弹框

 @param vc VC
 @param type 类型
 @param dataArray 数组 NSArray<NSArray *> *
 @param title 标题
 */
+ (void)openPopoverViewControllerWithVC:(UIViewController * _Nullable)vc type:(NSInteger)type dataArray:(NSArray * _Nullable)dataArray title:(NSString * _Nullable)title;
/**
 远程打开

 @param urlString 打开链接地址
 @param userInfo 参数
 */
+ (void)allPowerfulOpenVCForServerWithUrlString:(NSString *)urlString userInfo:(NSDictionary *)userInfo;
/**
 客户端打开界面

 @param parameters 数组 只能放2个对象 第一个NavigationVC 第二个参数
 @param urlKey 打开链接地址
 */
+ (void)openSomeOneVCWithParameters:(NSArray *)parameters urlKey:(NSString *)urlKey;


+ (void)goToGeneralInformationViewControllerWith:(id)vc userInfo:(NSDictionary *)userInfo complete:(nullable void (^)(NSArray *selectPeople))completeBlock;

+ (NSString *)jointURLPattern:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
