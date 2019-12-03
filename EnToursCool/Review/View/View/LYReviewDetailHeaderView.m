//
//  LYReviewDetailHeaderView.m
//  EnToursCool
//
//  Created by Lin Li on 2019/11/19.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYReviewDetailHeaderView.h"
#import "LHRatingView.h"

@interface LYReviewDetailHeaderView()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet LHRatingView *starView;
/**<##>*/
@property(nonatomic, strong) LHRatingView *starView1;
@end

@implementation LYReviewDetailHeaderView
- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.nameLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    self.nameLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_14];
    
    self.headerImageView.xk_radius = 16;
    self.headerImageView.xk_openClip = YES;
    self.headerImageView.xk_clipType = XKCornerClipTypeAllCorners;
    
    self.timeLabel.textColor = [LYTourscoolAPPStyleManager ly_7F7F7FColor];
    self.timeLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_12];
    self.starView1 = [[LHRatingView alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
    [self addSubview:self.starView1];
    [self.starView1 mas_remakeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.headerImageView.mas_left);
        make.top.equalTo(self.headerImageView.mas_bottom).offset(20);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
    self.starView1.score = 5;
    self.starView1.ratingType = INTEGER_TYPE;
    
}

@end
