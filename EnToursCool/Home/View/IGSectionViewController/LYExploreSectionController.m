//
//  LYExploreSectionController.m
//  EnToursCool
//
//  Created by tourscool on 2019/11/19.
//  Copyright © 2019 稀饭旅行. All rights reserved.
//

#import "LYExploreSectionController.h"

#import "LYExploreCell.h"
#import "LYSectionHeadCell.h"

@interface LYExploreSectionController()<IGListSupplementaryViewSource>

@end

@implementation LYExploreSectionController

#pragma mark - superMethod

- (instancetype)init
{
    if (self = [super init])
    {
         self.supplementaryViewSource = self;
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
    LYExploreCell *cell = [self.collectionContext dequeueReusableCellWithNibName:NSStringFromClass([LYExploreCell class]) bundle:nil forSectionController:self atIndex:index];
    return cell;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index
{
    //3个cell中平均一个cell的宽度
    CGFloat width = (kScreenWidth - 13 * 2) / 3;
    return CGSizeMake(kScreenWidth, 10 + 83 +  width * 86 / 116);
}

- (void)didUpdateToObject:(id)object
{
    
}

- (void)didSelectItemAtIndex:(NSInteger)index
{
    
}

#pragma mark - IGListSupplementaryViewSource

- (NSArray<NSString *> *)supportedElementKinds
{
    return @[UICollectionElementKindSectionHeader];
}

- (UICollectionReusableView *)viewForSupplementaryElementOfKind:(NSString *)elementKind atIndex:(NSInteger)index
{
    LYSectionHeadCell *headView = [self.collectionContext dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader forSectionController:self nibName:NSStringFromClass([LYSectionHeadCell class]) bundle:nil atIndex:index];
    return headView;
}

- (CGSize)sizeForSupplementaryViewOfKind:(NSString *)elementKind atIndex:(NSInteger)index
{
    return CGSizeMake(self.collectionContext.containerSize.width, 47);
}
@end
