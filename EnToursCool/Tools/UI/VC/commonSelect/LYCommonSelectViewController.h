//
//  LYCommonSelectViewController.h
//  EnToursCool
//
//  Created by Lin Li on 2019/12/2.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYCommonSelectViewController : UIViewController

@end

@interface LYCommonSelectModel : NSObject
@property (nonatomic , copy) NSString              * countriesID;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * key;
@property (nonatomic , copy) NSString              * pinyin;
@property (nonatomic , copy) NSString              * allPinYin;
@property (nonatomic , copy) NSString              * telcode;
@end

@interface LYCommonSelectTableViewCell : UITableViewCell


@end





NS_ASSUME_NONNULL_END
