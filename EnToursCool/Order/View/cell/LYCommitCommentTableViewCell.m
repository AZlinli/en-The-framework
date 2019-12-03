//
//  LYCommitCommentTableViewCell.m
//  EnToursCool
//
//  Created by 稀饭旅行 on 2019/11/25.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYCommitCommentTableViewCell.h"
#import "LHRatingView.h"
#import "LYImageShow.h"

NSString * const LYCommitCommentTableViewCellID = @"LYCommitCommentTableViewCellID";
@interface LYCommitCommentTableViewCell()<ratingViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleTopCons; // 73 30

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageTopCons;  // 63 20


@property (weak, nonatomic) IBOutlet UILabel *valueForMoneyLabel;
@property (weak, nonatomic) IBOutlet LHRatingView *valueForMoneyStarView;


@property (weak, nonatomic) IBOutlet UILabel *reviewTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *seviceLabel;
@property (weak, nonatomic) IBOutlet LHRatingView *serviceStarView;
@property (weak, nonatomic) IBOutlet UILabel *safetyLabel;
@property (weak, nonatomic) IBOutlet LHRatingView *safetyStarView;
@property (weak, nonatomic) IBOutlet UILabel *tourGuideServiceLabel;
@property (weak, nonatomic) IBOutlet UILabel *hotelAndRepastLabel;
@property (weak, nonatomic) IBOutlet LHRatingView *tourGuideSeviceStarView;
@property (weak, nonatomic) IBOutlet LHRatingView *hotelAndRepastStarView;

@property(nonatomic, strong) LHRatingView *starView1;
@property(nonatomic, strong) LHRatingView *starView2;
@property(nonatomic, strong) LHRatingView *starView3;
@property(nonatomic, strong) LHRatingView *starView4;
@property(nonatomic, strong) LHRatingView *starView5;
@end
@implementation LYCommitCommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.starView1 = [[LHRatingView alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
    [self addSubview:self.starView1];
    [self.starView1 mas_remakeConstraints:^(MASConstraintMaker *make){
        make.left.bottom.equalTo(self.serviceStarView);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
    
    NSInteger score = ceil(5.0);
    self.starView1.score = score;
    self.starView1.ratingType = INTEGER_TYPE;
    self.starView1.delegate = self;
    
    self.starView2 = [[LHRatingView alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
    [self addSubview:self.starView2];
    [self.starView2 mas_remakeConstraints:^(MASConstraintMaker *make){
        make.left.bottom.equalTo(self.safetyStarView);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
    

    self.starView2.score = score;
    self.starView2.ratingType = INTEGER_TYPE;
    self.starView2.delegate = self;
    
    self.starView3 = [[LHRatingView alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
    [self addSubview:self.starView3];
    [self.starView3 mas_remakeConstraints:^(MASConstraintMaker *make){
        make.left.bottom.equalTo(self.tourGuideSeviceStarView);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
    
    self.starView3.score = score;
    self.starView3.ratingType = INTEGER_TYPE;
    self.starView3.delegate = self;
    
    self.starView4 = [[LHRatingView alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
    [self addSubview:self.starView4];
    [self.starView4 mas_remakeConstraints:^(MASConstraintMaker *make){
        make.left.bottom.equalTo(self.hotelAndRepastStarView);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
    
    self.starView4.score = score;
    self.starView4.ratingType = INTEGER_TYPE;
    self.starView4.delegate = self;
    
    self.starView5 = [[LHRatingView alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
    [self addSubview:self.starView5];
    [self.starView5 mas_remakeConstraints:^(MASConstraintMaker *make){
        make.left.bottom.equalTo(self.valueForMoneyStarView);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
    
    self.starView5.score = score;
    self.starView5.ratingType = INTEGER_TYPE;
    self.starView5.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)dataDidChange{
    NSString *type = self.data;
    if (type.integerValue == 1) {
        self.valueForMoneyLabel.hidden = YES;
        self.safetyLabel.hidden = YES;
        self.safetyStarView.hidden = YES;
        self.tourGuideServiceLabel.hidden = YES;
        self.hotelAndRepastLabel.hidden = YES;
        self.tourGuideSeviceStarView.hidden = YES;
        self.hotelAndRepastStarView.hidden = YES;
        self.valueForMoneyStarView.hidden = YES;
        self.starView2.hidden = YES;
        self.starView3.hidden = YES;
        self.starView4.hidden = YES;
        self.starView5.hidden = YES;
        self.reviewTitleLabel.hidden = NO;
        self.titleTopCons.constant = 73.f;
        self.imageTopCons.constant = 63.f;
   
    }else{
        self.valueForMoneyLabel.hidden = NO;
        self.safetyLabel.hidden = NO;
        self.safetyStarView.hidden = NO;
        self.tourGuideServiceLabel.hidden = NO;
        self.hotelAndRepastLabel.hidden = NO;
        self.tourGuideSeviceStarView.hidden = NO;
        self.hotelAndRepastStarView.hidden = NO;
        self.valueForMoneyStarView.hidden = NO;
        self.starView2.hidden = NO;
        self.starView3.hidden = NO;
        self.starView4.hidden = NO;
        self.starView5.hidden = NO;
        self.reviewTitleLabel.hidden = YES;
        self.titleTopCons.constant = 30.f;
        self.imageTopCons.constant = 20.f;
    }
}

- (void)ratingView:(LHRatingView *)view score:(CGFloat)score{
    NSString *scoreValue = @(score).stringValue;
    NSString *type = @"0";
    if (view == self.starView1) {
        //serviceStarView
        type = @"1";
    }
    if (view == self.starView2) {
        //safetyStarView
        type = @"2";
    }
    if (view == self.starView3) {
        //tourGuideSeviceStarView
        type = @"3";
    }
    if (view == self.starView4) {
        //hotelAndRepastStarView
        type = @"4";
    }
    if (view == self.starView5) {
        //valueForMoneyStarView
        type = @"5";
    }
    NSDictionary *dic = @{@"type":type,@"score":scoreValue};
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickStarView:)]) {
        [self.delegate clickStarView:dic];
    }
}

@end
