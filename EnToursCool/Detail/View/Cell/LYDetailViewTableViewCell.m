//
//  LYDetailViewTableViewCell.m
//  EnToursCool
//
//  Created by Lin Li on 2019/11/25.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYDetailViewTableViewCell.h"

NSString * const LYDetailViewTableViewCellID = @"LYDetailViewTableViewCellID";

@interface LYDetailViewTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *labelContentView;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *endCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *LanguageLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end

@implementation LYDetailViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    self.titleLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    self.titleLabel.font = [LYTourscoolAPPStyleManager ly_ArialBold_16];
    
    self.lineView.backgroundColor = [LYTourscoolAPPStyleManager ly_lineColor];
    
    self.labelContentView.backgroundColor = [LYTourscoolAPPStyleManager ly_F9F9F9Color];
    self.labelContentView.xk_radius = 8;
    self.labelContentView.xk_clipType = XKCornerClipTypeAllCorners;
    self.labelContentView.xk_openClip = YES;
    
    [self.dayLabel rz_colorfulConfer:^(RZColorfulConferrer * _Nonnull confer) {
        confer.appendImage([UIImage imageNamed:@"detail_time"]).bounds(CGRectMake(0, -4, 20, 20));
        confer.text(@" ");
        confer.text(@"Duration: 6 Days").textColor([LYTourscoolAPPStyleManager ly_484848Color]).font([LYTourscoolAPPStyleManager ly_ArialRegular_14]);
    }];
    
    [self.cityLabel rz_colorfulConfer:^(RZColorfulConferrer * _Nonnull confer) {
        confer.appendImage([UIImage imageNamed:@"detail_location"]).bounds(CGRectMake(0, -4, 20, 20));
        confer.text(@" ");
        confer.text(@"Departure city: Denver").textColor([LYTourscoolAPPStyleManager ly_484848Color]).font([LYTourscoolAPPStyleManager ly_ArialRegular_14]);
      }];
    
    [self.endCityLabel rz_colorfulConfer:^(RZColorfulConferrer * _Nonnull confer) {
        confer.appendImage([UIImage imageNamed:@"detail_location"]).bounds(CGRectMake(0, -4, 20, 20));
        confer.text(@" ");
        confer.text(@"End city: Salt Lake City").textColor([LYTourscoolAPPStyleManager ly_484848Color]).font([LYTourscoolAPPStyleManager ly_ArialRegular_14]);
      }];
    
    [self.typeLabel rz_colorfulConfer:^(RZColorfulConferrer * _Nonnull confer) {
        confer.appendImage([UIImage imageNamed:@"detail_type"]).bounds(CGRectMake(0, -4, 20, 20));
        confer.text(@" ");
        confer.text(@"Type: Bus/Coach").textColor([LYTourscoolAPPStyleManager ly_484848Color]).font([LYTourscoolAPPStyleManager ly_ArialRegular_14]);
      }];
    
    [self.LanguageLabel rz_colorfulConfer:^(RZColorfulConferrer * _Nonnull confer) {
        confer.appendImage([UIImage imageNamed:@"detail_language"]).bounds(CGRectMake(0, -4, 20, 20));
        confer.text(@" ");
        confer.text(@"Language: Chinese&English").textColor([LYTourscoolAPPStyleManager ly_484848Color]).font([LYTourscoolAPPStyleManager ly_ArialRegular_14]);
      }];
}



@end
