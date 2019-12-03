//
//  LYHomeMenuCollectionViewCell.m
//  ToursCool
//
//  Created by tourscool on 11/26/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYHomeMenuCollectionViewCell.h"
#import "LYHomeMenuItmeCollectionViewCell.h"
#import "LYHomeMenuModel.h"
#import "UIView+LYUtil.h"
#import <Masonry/Masonry.h>
NSString * const LYHomeMenuCollectionViewCellID = @"LYHomeMenuCollectionViewCellID";
@interface LYHomeMenuCollectionViewCell ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, weak) IBOutlet UICollectionView * menuCollectionView;
@property (nonatomic, strong) LYHomeMenuModel * homeMenuModel;
@end
@implementation LYHomeMenuCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.menuCollectionView registerNib:[UINib nibWithNibName:@"LYHomeMenuItmeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:LYHomeMenuItmeCollectionViewCellID];
    self.menuCollectionView.backgroundColor = [UIColor whiteColor];
    self.menuCollectionView.dataSource = self;
    self.menuCollectionView.delegate = self;
    self.menuCollectionView.showsHorizontalScrollIndicator = NO;
//    self.menuCollectionView.pagingEnabled = YES;
}

- (void)dataDidChange
{
    if (![self.homeMenuModel isEqual:self.data]) {
        self.homeMenuModel = self.data;
        if (self.homeMenuModel.nav.count) {
            [self.menuCollectionView reloadData];
        }
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.homeMenuModel.nav.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LYHomeMenuItmeCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:LYHomeMenuItmeCollectionViewCellID forIndexPath:indexPath];
    cell.data = self.homeMenuModel.nav[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LYNSLog(@"点击了菜单ITEM的第%ld个",indexPath.row);
//    LYHomeMenuItemModel * model = self.homeMenuModel.nav[indexPath.row];
//    if (model.eventID.length) {
//        [LYAnalyticsServiceManager analyticsEvent:model.eventID attributes:nil label:nil];
//    }
//    if (model.jumpUrl.length) {
//        [LYRouterManager allPowerfulOpenVCForServerWithUrlString:model.jumpUrl userInfo:@{kCurrentNavigationVCKey:self.viewController.navigationController}];
//    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(floor(kScreenWidth /4.f), (kScreenWidth / 4) * 100 / 93.75);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.f;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0.f, 0.f, 0.f, 0.f);
}

@end
