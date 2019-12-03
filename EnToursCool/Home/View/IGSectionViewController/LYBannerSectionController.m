//
//  LYBannerSectionController.m
//  EnToursCool
//
//  Created by tourscool on 2019/11/19.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYBannerSectionController.h"
#import "LYHomeBannerCell.h"
#import "LYHomeBannerModel.h"
#import <SDCycleScrollView/SDCycleScrollView.h>


@interface LYBannerSectionController()

@property (nonatomic, strong) LYHomeBannerCell *bannerCell;

@property (nonatomic, strong) LYHomeBannerModel * homeBannerModel;

@end

@implementation LYBannerSectionController

#pragma mark - superMethod

- (instancetype)init
{
    if (self = [super init])
    {
        self.minimumLineSpacing = 0.0f;
        self.minimumInteritemSpacing = 0.0f;
    }
    return self;
}

- (NSInteger)numberOfItems
{
    return 1;
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index
{
    if (!self.bannerCell)
    {
        self.bannerCell = [self.collectionContext dequeueReusableCellWithNibName:@"LYHomeBannerCell" bundle:nil forSectionController:self atIndex:index];
    }
    self.bannerCell.data = self.homeBannerModel;
    return self.bannerCell;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index
{
     return CGSizeMake(kScreenWidth, 250 * kScreenWidth / 375);
}

- (void)didUpdateToObject:(id)object
{
    self.homeBannerModel = object;
}

- (void)didSelectItemAtIndex:(NSInteger)index
{
    
}

- (void)bannerCycleScrollViewAdjustWhenControllerViewWillAppera
{
    [self.bannerCell.bannerCycleScrollView adjustWhenControllerViewWillAppera];
}


@end
