//
//  LYRouteTextTableViewCell.m
//  EnToursCool
//
//  Created by Lin Li on 2019/11/22.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYRouteTextTableViewCell.h"
#import "LYRouteListModel.h"

NSString * const LYRouteTextTableViewCellID = @"LYRouteTextTableViewCellID";

@interface LYRouteTextTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *dotImageView;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *textContentLabel;
/**model*/
@property(nonatomic, strong) LYRouteListContentTextModel *model;
@end

@implementation LYRouteTextTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    self.dotImageView.xk_radius = 5;
    self.dotImageView.xk_clipType = XKCornerClipTypeAllCorners;
    self.dotImageView.xk_openClip = YES;
    self.dotImageView.backgroundColor = [LYTourscoolAPPStyleManager ly_19A8C7Color];
    
    self.lineView.backgroundColor = [LYTourscoolAPPStyleManager ly_19A8C7Color];
    
    self.textContentLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    self.textContentLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_14];
    
}

-(void)dataDidChange {
    self.model = self.data;
    self.textContentLabel.text = self.model.text;
}
@end
