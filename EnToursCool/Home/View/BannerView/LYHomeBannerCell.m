//
//  LYHomeBannerCell.m
//  EnToursCool
//
//  Created by tourscool on 2019/11/19.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYHomeBannerCell.h"
#import "LYHomeBannerModel.h"
//#import "LYWebViewController.h"
#import "UIView+LYUtil.h"
#import "UIView+LYCorner.h"
#import "LYImageShow.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import <SDCycleScrollView/SDCollectionViewCell.h>
#import <SDWebImage/SDWebImage.h>
#import <Masonry/Masonry.h>

@interface LYHomeBannerCell()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray<UIImageView *> * imageMutableArray;
@property (nonatomic, copy) NSArray * imagePathArray;
@property (nonatomic, weak) UIView * pageControl;

@end

@implementation LYHomeBannerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    self.bannerCycleScrollView = [[SDCycleScrollView alloc] init];
    self.bannerCycleScrollView.autoScrollTimeInterval = 5.0;
    [self.contentView addSubview:self.bannerCycleScrollView];
    
    self.bannerCycleScrollView.showPageControl = NO;
//    self.bannerCycleScrollView.layer.cornerRadius = 10.f;
    [self.bannerCycleScrollView adjustWhenControllerViewWillAppera];
    self.bannerCycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    self.bannerCycleScrollView.delegate = self;
    
    [self.bannerCycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
    }];
    
    @weakify(self);
    [self.bannerCycleScrollView setItemDidScrollOperationBlock:^(NSInteger currentIndex) {
        @strongify(self);
        [self setCurrentPageControlImageWithCurrentIndex:currentIndex];
    }];
}

- (Class)customCollectionViewCellClassForCycleScrollView:(SDCycleScrollView *)view
{
    return [SDCollectionViewCell class];
}

- (void)setupCustomCell:(UICollectionViewCell *)cell forIndex:(NSInteger)index cycleScrollView:(SDCycleScrollView *)view
{
    SDCollectionViewCell * collectionViewCell = (SDCollectionViewCell *)cell;
    NSString *imagePath = self.imagePathArray[index];
    [LYImageShow ly_showClippedRectImageInImageView:collectionViewCell.imageView path:imagePath cornerRadius:0.0f placeholderImage:[UIImage imageNamed:@"home_banner_placeholder_img"] itemSize:CGSizeMake(kScreenWidth, 250 * kScreenWidth / 375)];
}

- (void)setCurrentPageControlImageWithCurrentIndex:(NSInteger)currentIndex
{
    [self.imageMutableArray enumerateObjectsUsingBlock:^(UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == currentIndex) {
            obj.image = [UIImage imageNamed:@"home_banner_currentDot_img"];
        }else{
            obj.image = [UIImage imageNamed:@"home_banner_dot_img"];
        }
    }];
}

- (void)dataDidChange
{
    LYHomeBannerModel * model = self.data;
    NSMutableArray * array = [NSMutableArray array];
    [model.banner enumerateObjectsUsingBlock:^(LYHomeBannerItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [array addObject:obj.imageUrl];
    }];
    self.imagePathArray = [array copy];
    self.bannerCycleScrollView.imageURLStringsGroup = self.imagePathArray;
    [self addPageControl];
    @weakify(self);
    [self.bannerCycleScrollView setClickItemOperationBlock:^(NSInteger currentIndex) {
        @strongify(self);
        if (model.banner.count > 0) {
            [LYAnalyticsServiceManager analyticsEvent:@"HomeBanner" attributes:nil label:nil];
            if ([model.banner[currentIndex].linkUrl hasPrefix:@"tourscool"]) {
                [LYRouterManager allPowerfulOpenVCForServerWithUrlString:model.banner[currentIndex].linkUrl userInfo:@{kCurrentNavigationVCKey:self.viewController.navigationController}];
            }else{
//                [LYWebViewController goPushWebVCWithVC:self.viewController para:@{@"url_path":model.banner[currentIndex].linkUrl}];
            }
        }
    }];
}

- (void)addPageControl
{
    if (self.pageControl) {
        return;
    }
    if (self.imagePathArray.count <= 1) {
        return;
    }
    UIView *pageControl = [[UIView alloc] init];
    self.pageControl = pageControl;
    [self.contentView addSubview:pageControl];
    [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-11.f);
        make.centerX.equalTo(self.mas_centerX);
        make.height.offset(4.f);
    }];
    self.imageMutableArray = [NSMutableArray<UIImageView *> array];
    UIImageView * imageView = nil;
    for (int i = 0; i < self.imagePathArray.count; i++) {
        UIImageView * currentImageView = [[UIImageView alloc] init];
        [pageControl addSubview:currentImageView];
        currentImageView.image = [UIImage imageNamed:@"home_banner_dot_img"];
        if (i == 0) {
            currentImageView.image = [UIImage imageNamed:@"home_banner_currentDot_img"];
            [currentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(pageControl.mas_left);
                make.top.equalTo(pageControl.mas_top);
            }];
        }else if (i == self.imagePathArray.count - 1){
            [currentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(imageView.mas_right).offset(2.f);
                make.right.equalTo(pageControl.mas_right);
                make.top.equalTo(pageControl.mas_top);
            }];
        }else{
            [currentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(imageView.mas_right).offset(2.f);
                make.top.equalTo(pageControl.mas_top);
            }];
        }
        [self.imageMutableArray addObject:currentImageView];
        imageView = currentImageView;
    }
}

- (void)drawRect:(CGRect)rect
{

}

@end
