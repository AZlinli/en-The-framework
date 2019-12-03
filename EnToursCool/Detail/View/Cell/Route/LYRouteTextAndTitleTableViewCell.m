//
//  LYRouteTextAndTitleTableViewCell.m
//  EnToursCool
//
//  Created by Lin Li on 2019/11/22.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYRouteTextAndTitleTableViewCell.h"

NSString * const LYRouteTextAndTitleTableViewCellID = @"LYRouteTextAndTitleTableViewCellID";
#import "LYRouteListModel.h"

@interface LYRouteTextAndTitleTableViewCell()
@property (weak, nonatomic) IBOutlet UIView *topLineView;
@property (weak, nonatomic) IBOutlet UIImageView *botImageView;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *textCotentLabel;

/**model*/
@property(nonatomic, strong) LYDetailBaseModel *baseModel;
@end

@implementation LYRouteTextAndTitleTableViewCell

-(void)dataDidChange {
    self.baseModel = self.data;
    if ([self.baseModel isKindOfClass:[LYRouteListhHotelModel class]]) {
        LYRouteListhHotelModel *hotelModel = (LYRouteListhHotelModel *)self.baseModel;
        self.titleLabel.text = hotelModel.title;
        self.textCotentLabel.text = hotelModel.text;
        self.bottomLineView.hidden = NO;
        self.botImageView.image = [UIImage imageNamed:@"detail_bed"];
        
    }else if ([self.baseModel isKindOfClass:[LYRouteListhMealsModel class]]){
        LYRouteListhMealsModel *mealsModel = (LYRouteListhMealsModel *)self.baseModel;
        self.titleLabel.text = mealsModel.title;
        self.textCotentLabel.text = mealsModel.text;
        self.bottomLineView.hidden = YES;
        self.botImageView.image = [UIImage imageNamed:@"detail_food"];
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.botImageView.xk_radius = 8.5;
    self.botImageView.xk_clipType = XKCornerClipTypeAllCorners;
    self.botImageView.xk_openClip = YES;
    
    self.bottomLineView.backgroundColor = [LYTourscoolAPPStyleManager ly_19A8C7Color];
    self.topLineView.backgroundColor = [LYTourscoolAPPStyleManager ly_19A8C7Color];

    self.titleLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_14];
    self.titleLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    
    self.textCotentLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_14];
    self.textCotentLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
}


@end
