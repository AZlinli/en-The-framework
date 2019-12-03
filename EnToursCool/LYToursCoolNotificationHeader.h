//
//  LYToursCoolNotificationHeader.h
//  ToursCool
//
//  Created by tourscool on 2/25/19.
//  Copyright © 2019 tourscool. All rights reserved.
//

#ifndef LYToursCoolNotificationHeader_h
#define LYToursCoolNotificationHeader_h

/**
 支付成功
 */
#define kPayNotificationIdentifier @"LYNotificationPayIdentifier"

/**
 关闭首页EmailView的通知
 */
#define kCloseEmailViewNotificationIdentifier @"kCloseEmailViewNotificationIdentifier"

/**
 收藏通知
 */
#define kCollectProductNotificationIdentifier @"LYCollectProductNotificationIdentifier"
/**
 收藏列表删除 更新详情页收藏状态
 */
#define kCollectListProductNotificationIdentifier @"LYCollectListProductNotificationIdentifier"
/**
 收藏列表 跳转详情
 */
#define kCollectListGoProductDetailNotificationIdentifier @"LYCollectListGoProductDetailNotificationIdentifier"
/**
 收藏列表 跳转攻略详情
 */
#define kCollectListGoStrategyDetailNotificationIdentifier @"LYCollectListGoStrategyDetailNotificationIdentifier"

/**
 找回密码 注册
 */
#define kUserModifyPasswordSuccessfulIdentifier @"LYUserModifyPasswordSuccessfulIdentifier"

/**
 登录成功通知 限获取token
 */
#define kUserLoginSuccessfulIdentifier @"LYUserLoginSuccessfulIdentifier"

/**
 重新登录
 */
#define kUserLoginLoseEfficacydentifier @"LYUserLoginLoseEfficacydentifier"

/**
 列表搜索通知 刷新数据
 */
#define kUserSearchNotificationIdentifier @"LYUserSearchNotificationIdentifier"

/**
 修改密码
 */
#define kUserModifyPWDNotificationIdentifier @"LYUserModifyPWDNotificationIdentifier"

/**
 忘记密码
 */
#define kUserForgetPWDNotificationIdentifier @"LYUserForgetPWDNotificationIdentifier"

/**
 订单确认界面 选择接送机服务 刷新tableView
 */
#define kOrderAffirmSelectAttributesNotificationIdentifier @"LYOrderAffirmSelectNotificationIdentifier"

/**
 点击状态栏通知 详情页
 */
#define kStatusBarTappedNotification @"kStatusBarTappedNotificationName"
/**
 更新LYPopoverViewController优惠券
 */
#define kUpdateDetailsPageCoupons @"LYUpdateDetailsPageCoupons"
/**
 网络监听通知
 */
#define LYNetworkingReachabilityDidChangeNotificationName @"LYNetworkingReachabilityDidChangeNotificationName"
/**
 语言切换
 */
#define kUserChangeLanguageNotificationName @"LYUserChangeLanguageNotificationName"
/**
 用户评论列表点赞或者取消点赞
 */
#define kUserCommentGiveALikeNotificationName @"LYUserCommentGiveALikeNotificationName"


#pragma mark - animation

#define kPOPViewStartAnmationNotificationName @"LYPOPViewStartAnmationNotificationName"
#define kPOPViewEndAnmationNotificationName @"LYPOPViewEndAnmationNotificationName"

#define kUserObtainNewcomerGiftInviteNewPeopleSuccessful @"LYUserObtainNewcomerGiftInviteNewPeopleSuccessful"

#define kHomeReloadProductNotificationName @"kHomeReloadProductNotificationName"

//订单修改航班信息错误提示通知
#define kOrderFlightInfoErrorNotificationName @"kOrderFlightInfoErrorNotificationNames"

#define kOrderSecondVCPopNotificationName @"kOrderSecondVCPopNotificationName"

#endif /* LYToursCoolNotificationHeader_h */
