//
//  LYExploreContaintViewCell.m
//  EnToursCool
//
//  Created by tourscool on 2019/11/21.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYExploreContaintViewCell.h"
#import "LYCountyCollectionCell.h"
#import "LYAddressCollectionViewCell.h"

#import "LYHomeExploreModel.h"


@interface LYExploreContaintViewCell()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *countyCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *addressCollectionView;
@property (nonatomic, strong) LYHomeExploreModel *exploreModel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightCns;

@end

@implementation LYExploreContaintViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.countyCollectionView registerNib:[UINib nibWithNibName:@"LYCountyCollectionCell" bundle:nil] forCellWithReuseIdentifier:LYCountyCollectionCellID];
    self.countyCollectionView.backgroundColor = [UIColor whiteColor];
    self.countyCollectionView.dataSource = self;
    self.countyCollectionView.delegate = self;
    self.countyCollectionView.showsHorizontalScrollIndicator = NO;
    
    [self.addressCollectionView registerNib:[UINib nibWithNibName:@"LYAddressCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:LYAddressCollectionViewCellID];
    self.addressCollectionView.backgroundColor = [UIColor whiteColor];
    self.addressCollectionView.dataSource = self;
    self.addressCollectionView.delegate = self;
    self.addressCollectionView.showsHorizontalScrollIndicator = NO;

}

- (void)dataDidChange
{
    if (![self.exploreModel isEqual:self.data])
    {
        self.exploreModel = self.data;
        [self.countyCollectionView reloadData];
        [self.addressCollectionView reloadData];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == self.countyCollectionView)
    {
//        return self.exploreModel.countries.count;
        return 6;
    }else
    {
//        return self.exploreModel.adresses.count;
        return 4;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
     if (collectionView == self.countyCollectionView)
    {
        LYCountyCollectionCell *countyCell = [collectionView dequeueReusableCellWithReuseIdentifier:LYCountyCollectionCellID forIndexPath:indexPath];
//        countyCell.data = self.exploreModel.countries[indexPath.item];
        return countyCell;
    }else
    {
        LYAddressCollectionViewCell *adressCell = [collectionView dequeueReusableCellWithReuseIdentifier:LYAddressCollectionViewCellID forIndexPath:indexPath];
//        adressCell.data = self.exploreModel.adresses[indexPath.item];
        return adressCell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (collectionView == self.countyCollectionView)
    {
       LYNSLog(@"点击了collectionView1的第%ld个",indexPath.row);
    }else
    {
        LYNSLog(@"点击了collectionView2的第%ld个",indexPath.row);
        
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.countyCollectionView)
       {
           return CGSizeMake(78, 34);
       }else
       {
           CGFloat width = (kScreenWidth - 16 * 2 - 6 * 2) / 3;
           return CGSizeMake(width, width * 80 / 110);
       }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (collectionView == self.countyCollectionView)
    {
        return 8;
    }else
    {
        return 7;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.f;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (collectionView == self.countyCollectionView)
    {
        return UIEdgeInsetsMake(3, 16, 3, 0);
    }else
    {
        return UIEdgeInsetsMake(5, 16, 5, 16);

    }
}



@end
