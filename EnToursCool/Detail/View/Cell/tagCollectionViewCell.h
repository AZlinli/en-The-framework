//
//  tagCollectionViewCell.h
//  EnToursCool
//
//  Created by Lin Li on 2019/11/21.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface tagCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *tagTextLabel;
/**边框颜色*/
@property(nonatomic, strong) UIColor *tagBorderColor;
@end

NS_ASSUME_NONNULL_END
