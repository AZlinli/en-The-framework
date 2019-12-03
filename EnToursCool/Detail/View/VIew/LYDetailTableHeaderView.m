//
//  LYDetailTableHeaderView.m
//  EnToursCool
//
//  Created by Lin Li on 2019/11/21.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYDetailTableHeaderView.h"
#import <SDCycleScrollView.h>
#import "LHRatingView.h"
#import "NSObject+LYCalculatedHeightWidth.h"
#import "LYDetailViewModel.h"
#import "tagCollectionViewCell.h"
#import "TagCollectionViewCustomLayout.h"
#import "LYDetailTableHeaderModel.h"

NSString * const LYDetailTableHeaderViewID = @"LYDetailTableHeaderViewID";

@interface LYDetailTableHeaderView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet SDCycleScrollView *bannerView;
@property (weak, nonatomic) IBOutlet UILabel *bannerCountLabel;
@property (weak, nonatomic) IBOutlet UIView * mycontentView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *starContentView;
@property (weak, nonatomic) IBOutlet UILabel *reviewCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *productIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *bestsellerLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *salePriceLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *tagCollectionView;

/**viewModel*/
@property(nonatomic, strong) LYDetailViewModel *viewModel;

@property(nonatomic, strong) LHRatingView *starView;

/**model*/
@property(nonatomic, strong) LYDetailTableHeaderModel *model;

/**标签的数组*/
@property(nonatomic, strong) NSArray *tagArray;

@end

@implementation LYDetailTableHeaderView

- (void)dataDidChange {
    self.model =  self.data;
    self.bannerView.imageURLStringsGroup = self.model.bannerArray;
    self.bannerView.showPageControl = NO;
    self.bannerView.autoScroll = NO;
    self.bannerView.delegate = self;
    
    self.tagArray = self.model.tagArray;
    self.titleLabel.text = self.model.title;
    self.bannerCountLabel.text = [NSString stringWithFormat:@"%d/%lu", 1,(unsigned long)self.model.bannerArray.count];

}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentView.xk_radius = 20;
    self.contentView.xk_openClip = YES;
    self.contentView.xk_clipType = XKCornerClipTypeTopBoth;
    
    self.bannerCountLabel.textColor = [LYTourscoolAPPStyleManager ly_FFFFFFColor];
    self.bannerCountLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_12];
    self.bannerCountLabel.backgroundColor = [LYTourscoolAPPStyleManager ly_484848ColorAlpha:0.67];
    self.bannerCountLabel.xk_clipType = XKCornerClipTypeAllCorners;
    self.bannerCountLabel.xk_openClip = YES;
    self.bannerCountLabel.xk_radius = 20;
    
    self.titleLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    self.titleLabel.font = [LYTourscoolAPPStyleManager ly_ArialBold_16];
    
    self.reviewCountLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    self.reviewCountLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_12];
    
    self.productIDLabel.textColor = [LYTourscoolAPPStyleManager ly_484848Color];
    self.productIDLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_12];
    
    self.bestsellerLabel.textColor = [LYTourscoolAPPStyleManager ly_FFFFFFColor];
    self.bestsellerLabel.font = [LYTourscoolAPPStyleManager ly_ArialRegular_12];
    self.bestsellerLabel.backgroundColor = [LYTourscoolAPPStyleManager ly_19A8C7Color];
    self.bestsellerLabel.xk_clipType = XKCornerClipTypeAllCorners;
    self.bestsellerLabel.xk_openClip = YES;
    self.bestsellerLabel.xk_radius = 2;
    
    [self.currentPriceLabel rz_colorfulConfer:^(RZColorfulConferrer * _Nonnull confer) {
        confer.text(@"from").font([LYTourscoolAPPStyleManager ly_ArialRegular_12]).textColor([LYTourscoolAPPStyleManager ly_484848Color]);
        confer.text(@" ");
        confer.text(@"US$899.00").font([LYTourscoolAPPStyleManager ly_ArialBold_16]).textColor([LYTourscoolAPPStyleManager ly_484848Color]);
    }];
    
    [self.salePriceLabel rz_colorfulConfer:^(RZColorfulConferrer * _Nonnull confer) {
         confer.text(@"US$900").font([LYTourscoolAPPStyleManager ly_ArialRegular_12]).textColor([LYTourscoolAPPStyleManager ly_A7A7A7Color]).strikeThrough(1);
         confer.text(@" ");
         confer.text(@"US$900 saved").font([LYTourscoolAPPStyleManager ly_ArialRegular_12]).textColor([LYTourscoolAPPStyleManager ly_EC6564Color]);
    }];
    
    self.starView = [[LHRatingView alloc]initWithFrame:self.starContentView.bounds];
    [self.starContentView addSubview:self.starView];
    self.starView.score = 5;
    self.starView.ratingType = INTEGER_TYPE;
    
    
    TagCollectionViewCustomLayout *layout = [[TagCollectionViewCustomLayout alloc]init];
    layout.minimumInteritemSpacing = 8;
    layout.minimumLineSpacing = 8;
    layout.maximumInteritemSpacing = 8;
    self.tagCollectionView.collectionViewLayout = layout;
    self.tagCollectionView.delegate = self;
    self.tagCollectionView.dataSource = self;
    [self.tagCollectionView registerNib:[UINib nibWithNibName:@"tagCollectionViewCell" bundle:nil]forCellWithReuseIdentifier:@"cell"];
    
}

- (LYDetailViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[LYDetailViewModel alloc]init];
    }
    return _viewModel;
}

- (NSArray *)tagArray {
    if (!_tagArray) {
        _tagArray = @[@"Lowest Price Guarantee",@"Buy 2 Get 2 for Free",@"Small Group",@"Small Group"];
    }
    return _tagArray;
}
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    self.bannerCountLabel.text = [NSString stringWithFormat:@"%ld/%lu",(long)index + 1,(unsigned long)self.model.bannerArray.count];
}

#pragma mark  UICollectionViewDelegate&&UICollectionViewDataSource&&UICollectionViewDelegateFlowLayout
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.tagArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = self.tagArray[indexPath.row];
    tagCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.tagTextLabel.text = title;
    cell.tagBorderColor = [LYTourscoolAPPStyleManager ly_EC6564Color];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = self.tagArray[indexPath.row];
    CGFloat itemH = 18;
    CGFloat itemW = [self getWidthWithText:title height:itemH font:[LYTourscoolAPPStyleManager ly_ArialRegular_10]];
    return CGSizeMake(itemW + 18, itemH);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end
