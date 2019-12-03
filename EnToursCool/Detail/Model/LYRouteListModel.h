//
//  LYRouteListModel.h
//  EnToursCool
//
//  Created by Lin Li on 2019/11/22.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYDetailBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LYRouteListModel : LYDetailBaseModel
/**行程里面的数组*/
@property(nonatomic, strong) NSArray *listArray;
/**组名*/
@property(nonatomic, copy) NSString *title;
/**是否展开*/
@property (nonatomic, strong) NSNumber * showMore;

@end

//概述
@interface LYRouteListContentTextModel : LYDetailBaseModel
/**概述*/
@property(nonatomic, copy) NSString *text;
/**cell高度*/
@property(nonatomic, assign) CGFloat contentTextCellH;
@end
//景点
@interface LYRouteListScenicSpotModel : LYDetailBaseModel
/**概述*/
@property(nonatomic, copy) NSString *text;
/**标题*/
@property(nonatomic, copy) NSString *title;
/**图片数组*/
@property(nonatomic, strong) NSArray *imageArray;
/**cell高度*/
@property(nonatomic, assign) CGFloat scenicSpotCellH;
@end

//酒店
@interface LYRouteListhHotelModel : LYDetailBaseModel
/**概述*/
@property(nonatomic, copy) NSString *text;
/**标题*/
@property(nonatomic, copy) NSString *title;
/**cell高度*/
@property(nonatomic, assign) CGFloat hotelCellH;

@end
//餐饮
@interface LYRouteListhMealsModel : LYDetailBaseModel
/**概述*/
@property(nonatomic, copy) NSString *text;
/**标题*/
@property(nonatomic, copy) NSString *title;
/**cell高度*/
@property(nonatomic, assign) CGFloat mealsCellH;

@end
NS_ASSUME_NONNULL_END
