//
//  LYHomeExploreDetailController.m
//  EnToursCool
//
//  Created by tourscool on 2019/11/21.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYHomeExploreDetailController.h"
#import "LYHomeExploreModel.h"
#import "LYExploreContaintViewCell.h"
#import "LYCollectionElementKindSectionHeader.h"

@interface LYHomeExploreDetailController()<IGListSupplementaryViewSource>

@property (nonatomic, strong) LYHomeExploreModel *exploreModel;

@end

@implementation LYHomeExploreDetailController

- (instancetype)init
{
    if (self = [super init])
    {
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
    CGFloat width = (kScreenWidth - 16 * 2 - 6 * 2) / 3;
    CGFloat secondViewHeight = width * 80 / 110;
    CGFloat height = secondViewHeight + 79;
    return CGSizeMake(kScreenWidth, height);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index
{
    LYExploreContaintViewCell *contailCell = [self.collectionContext dequeueReusableCellWithNibName:@"LYExploreContaintViewCell" bundle:nil forSectionController:self atIndex:index];
    contailCell.data = self.exploreModel;
    return contailCell;
}

- (void)didUpdateToObject:(id)object
{
    self.exploreModel = object;
}

#pragma mark - IGListSupplementaryViewSource

- (NSArray<NSString *> *)supportedElementKinds
{
    return self.exploreModel.collectionElementKindSectionArray;
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
