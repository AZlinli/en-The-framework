//
//  LYHomeSectionTitleCollectionViewCell.m
//  ToursCool
//
//  Created by tourscool on 12/7/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYHomeSectionTitleCollectionViewCell.h"
#import "LYHomeSectionTitleListSectionModel.h"
#import "LYToursCoolAPPManager.h"
#import "LYHTTPAPI.h"
#import "UIButton+LYTourscoolExtension.h"
#import "UIView+LYUtil.h"

@interface LYHomeSectionTitleCollectionViewCell()
@property (nonatomic, weak) IBOutlet UILabel * sectionTitleLabel;
@property (nonatomic, weak) IBOutlet UIButton * showMoreButton;
@end
@implementation LYHomeSectionTitleCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.sectionTitleLabel.font = [LYTourscoolAPPStyleManager ly_pingFangSCSemiboldFont_24];
    self.sectionTitleLabel.textColor = [LYTourscoolAPPStyleManager ly_393939Color];
    self.sectionTitleLabel.layer.masksToBounds = YES;
    
    self.showMoreButton.titleLabel.font = [LYTourscoolAPPStyleManager ly_pingFangSCRegularFont_12];
    [self.showMoreButton setTitleColor:[LYTourscoolAPPStyleManager ly_00ABF9Color] forState:UIControlStateNormal];
    self.backgroundColor = [UIColor clearColor];
}

- (void)dataDidChange
{
    LYHomeSectionTitleListSectionModel * model = self.data;
    self.showMoreButton.hidden = !model.showMore;
    self.sectionTitleLabel.text = model.moduleName;
//    [self.showMoreButton setTitle:[LYLanguageManager ly_localizedStringForKey:@"Home_Show_More_Title"] forState:UIControlStateNormal];
    [self.showMoreButton setImagePosition:LYImagePositionRight spacing:4.f];
    
     @weakify(model,self);
        [[[self.showMoreButton rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(model,self);
            if (model.type == 1)
            {
                //Explore
                LYNSLog(@"点击了Explore的头部NextBtn");
            }else
            {
                //Deals
                LYNSLog(@"点击了Deals的头部NextBtn");
            }
        }];
}

@end
