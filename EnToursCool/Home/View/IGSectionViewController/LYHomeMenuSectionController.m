//
//  LYHomeMenuSectionController.m
//  ToursCool
//
//  Created by tourscool on 12/7/18.
//  Copyright © 2018 tourscool. All rights reserved.
//

#import "LYHomeMenuSectionController.h"
#import "LYHomeMenuCollectionViewCell.h"
#import "LYCollectionElementKindSectionHeader.h"
#import "LYHomeMenuModel.h"
//
@interface LYHomeMenuSectionController ()<IGListSupplementaryViewSource>
@property (nonatomic, strong) LYHomeMenuModel * homeMenuModel;
@end

@implementation LYHomeMenuSectionController

- (instancetype)init
{
    if (self = [super init]) {
        self.supplementaryViewSource = self;
    }
    return self;
}

- (NSInteger)numberOfItems
{
    return 1;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index
{
    return CGSizeMake(kScreenWidth, (kScreenWidth / 4) * 100 / 93.75);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index
{
    LYHomeMenuCollectionViewCell * cell = [self.collectionContext dequeueReusableCellWithNibName:@"LYHomeMenuCollectionViewCell" bundle:nil forSectionController:self atIndex:index];
    cell.data = self.homeMenuModel;
    return cell;
}

- (void)didUpdateToObject:(id)object
{
    self.homeMenuModel = object;
}

#pragma mark - IGListSupplementaryViewSource

- (NSArray<NSString *> *)supportedElementKinds
{
    return self.homeMenuModel.collectionElementKindSectionArray;
}

- (CGSize)sizeForSupplementaryViewOfKind:(NSString *)elementKind atIndex:(NSInteger)index
{
    if ([elementKind isEqualToString:UICollectionElementKindSectionFooter])
    {
        return CGSizeMake(self.collectionContext.containerSize.width,10.f);
    }
    return CGSizeZero;
}

- (UICollectionReusableView *)viewForSupplementaryElementOfKind:(NSString *)elementKind atIndex:(NSInteger)index
{
    if ([elementKind isEqualToString:UICollectionElementKindSectionFooter]) {
        LYCollectionElementKindSectionHeader * header = [self.collectionContext dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter forSectionController:self nibName:@"LYCollectionElementKindSectionHeader" bundle:nil atIndex:index];
        return header;
    }
    return nil;
}

@end
