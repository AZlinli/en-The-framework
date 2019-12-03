//
//  LYProductListFliterModel.h
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/21.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYProductListFliterModel : NSObject
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *value;

@property(nonatomic, assign) BOOL isSelected;
@end

@interface LYProductListFliterSectionModel : NSObject
@property(nonatomic, assign) BOOL onlySelectedOne;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSArray<LYProductListFliterModel*>* dataArray;
@property(nonatomic, assign) BOOL isShowMore;
@end

@interface LYFiltrateItemModel : NSObject
@property (nonatomic, copy) NSString * itemID;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * firstCode;
@property (nonatomic, assign) BOOL selected;
@end

NS_ASSUME_NONNULL_END
